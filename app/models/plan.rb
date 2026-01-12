# app/models/plan.rb
class Plan
  def self.config(user)
    # Sempre busca do banco para garantir dados atualizados
    # Busca diretamente do banco sem cache
    config = PlanConfiguration.current(user)
    # Recarrega apenas se o registro já foi salvo
    config.persisted? ? config.reload : config
  end
  
  # Limpa o cache para um usuário específico
  def self.clear_cache_for_user(user_id)
    @config ||= {}
    @config.delete(user_id)
  end
  
  # Limpa todo o cache
  def self.clear_cache
    @config = {}
  end
  
  def self.current_user=(user)
    @current_user = user
  end
  
  def self.current_user
    @current_user
  end
  
  # Delegar tudo para config
  def self.title(user)
    config(user).title
  end
  
  def self.profile(user)
    # Converter hash de strings para símbolos para compatibilidade
    config(user).profile.transform_keys(&:to_sym)
  end
  
  def self.targets(user)
    # Converter hash de strings para símbolos para compatibilidade
    config(user).targets.transform_keys(&:to_sym)
  end
  
  def self.goals(user)
    # Converter hash de strings para símbolos para compatibilidade
    config(user).goals.transform_keys(&:to_sym)
  end
  
  def self.rules(user)
    config(user).rules
  end
  
  def self.meals(user)
    # Converter array de hashes com strings para símbolos
    config(user).meals.map do |meal|
      {
        name: meal['name'],
        options: meal['options']
      }
    end
  end
  
  def self.foods(user)
    # Converter hash de strings para símbolos
    config(user).foods.transform_keys(&:to_sym)
  end
  
  def self.workouts(user)
    config(user).workouts
  end
  
  def self.week_template(user)
    config(user).week_template
  end
  
  def self.daily_routine_template(user)
    config(user).daily_routine_template
  end
  
  def self.steps_blocks(user)
    config(user).steps_blocks
  end
  
  # Métodos existentes (mantidos)
  def self.workout_for(date, user)
    wday = date.wday
    return nil if wday == 0 || wday == 6
    week_template(user)[wday - 1]
  end
  
  def self.routine_for(_date, user)
    daily_routine_template(user)
  end
  
  # Retorna índice do próximo item baseado no horário atual
  def self.next_routine_index(now_time, user)
    routine = daily_routine_template(user)
    now_minutes = now_time.hour * 60 + now_time.min

    routine_minutes = routine.map do |item|
      h, m = item['time'].split(":").map(&:to_i)
      h * 60 + m
    end

    idx = routine_minutes.index { |mins| mins >= now_minutes }
    idx || (routine.length - 1)
  end
  
  def self.training_day?(date)
    # Seg–Sex = treino; Sáb/Dom = descanso/steps
    !(date.saturday? || date.sunday?)
  end
  
  # Rotina "template" do dia (retorna array de steps com key única)
  def self.routine_template_for(date, user)
    routine = []

    routine << { key: "wake_water", time: "07:00", title: "Acordar + água", detail: "500ml água + 5 min mobilidade" }
    routine << { key: "meal_1", time: "07:30", title: "Café (Refeição 1)", detail: "3 ovos + banana OU iogurte grego + aveia + fruta" }

    steps_blocks(user).each_with_index do |b, i|
      routine << {
        key: "steps_#{i+1}",
        time: b['time'],
        title: b['label'],
        detail: "#{b['steps']} passos (esteira/caminhada)"
      }
    end

    routine << { key: "water_mid", time: "10:30", title: "Água", detail: "Mais 400–600ml água" }
    routine << { key: "meal_2", time: "12:30", title: "Almoço (Refeição 2)", detail: "200g proteína + arroz/batata + salada grande" }
    routine << { key: "meal_3", time: "16:30", title: "Lanche (Refeição 3)", detail: "Whey + banana OU ovos + fruta OU iogurte grego + fruta" }

    if training_day?(date)
      workout_name = workout_for(date, user)
      routine << { key: "workout", time: "17:00", title: "Treino (Força)", detail: workout_name || "Treino do dia" }
    else
      routine << { key: "active_rest", time: "17:00", title: "Atividade leve", detail: "Caminhada longa / mobilidade (20–40 min)" }
    end

    routine << { key: "meal_4", time: "20:00", title: "Jantar (Refeição 4)", detail: "200g proteína + legumes/salada; carbo pequeno se necessário" }
    routine << { key: "sleep", time: "23:00", title: "Sono", detail: "Meta: 7–8h" }

    # Ordenar por horário
    routine.sort_by do |item|
      h, m = item[:time].split(":").map(&:to_i)
      h * 60 + m
    end
  end
  
  # Garante que existe RoutineLog para o dia (idempotente)
  def self.ensure_routine_logs_for!(date, user)
    template = routine_template_for(date, user)

    template.each_with_index do |item, idx|
      RoutineLog.find_or_create_by!(date: date, key: item[:key], user: user) do |rl|
        rl.position = idx + 1
        rl.done = false
        rl.user = user
      end
    end

    # Atualiza posição caso template mude com o tempo
    template.each_with_index do |item, idx|
      RoutineLog.where(date: date, key: item[:key], user: user).update_all(position: idx + 1)
    end
  end
end
