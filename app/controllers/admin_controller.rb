# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!
  
  def index
    # Lista todos os usuários que completaram o questionário mas não têm plano customizado
    @users_pending = User.where(questionnaire_completed: true)
                        .left_joins(:plan_configuration)
                        .where(plan_configurations: { is_customized: [false, nil] })
                        .order(created_at: :desc)
    
    @users_customized = User.where(questionnaire_completed: true)
                           .joins(:plan_configuration)
                           .where(plan_configurations: { is_customized: true })
                           .order(created_at: :desc)
  end
  
  def show_user
    @user = User.find(params[:user_id])
    @config = @user.plan_configuration || PlanConfiguration.current(@user)
  end
  
  def update_custom_plan
    @user = User.find(params[:user_id])
    @config = @user.plan_configuration || PlanConfiguration.current(@user)
    
    begin
      update_type = params[:update_type] || "full"
      # Garante que temos um hash válido para fazer merge
      current_data = (@config.data || {}).deep_dup
      
      case update_type
      when "full"
        # Atualiza com JSON completo
        custom_data = JSON.parse(params[:custom_json])
        merged_data = custom_data
        
      when "meals_foods"
        # Atualiza apenas meals e foods
        partial_data = JSON.parse(params[:meals_foods_json])
        merged_data = current_data.merge(partial_data)
        
      when "workouts"
        # Atualiza apenas workouts
        partial_data = JSON.parse(params[:workouts_json])
        merged_data = current_data.merge(partial_data)
        
      else
        raise ArgumentError, "Tipo de atualização inválido"
      end
      
      # Atualiza o plan_configuration com os dados mesclados
      if @config.update(data: merged_data, is_customized: true)
        message = case update_type
        when "full"
          "Plano completo salvo com sucesso para #{@user.email}!"
        when "meals_foods"
          "Refeições e alimentos atualizados com sucesso para #{@user.email}!"
        when "workouts"
          "Treinos atualizados com sucesso para #{@user.email}!"
        end
        redirect_to admin_user_path(@user), notice: message
      else
        flash[:alert] = "Erro ao salvar: #{@config.errors.full_messages.join(', ')}"
        render :show_user, status: :unprocessable_entity
      end
    rescue JSON::ParserError => e
      flash[:alert] = "JSON inválido: #{e.message}"
      render :show_user, status: :unprocessable_entity
    rescue ArgumentError => e
      flash[:alert] = "Erro: #{e.message}"
      render :show_user, status: :unprocessable_entity
    end
  end
  
  def generate_prompt
    @user = User.find(params[:user_id])
    
    # Lê o arquivo de prompt base
    prompt_file_path = Rails.root.join("PROMPT_PLANO_PERSONALIZADO.md")
    base_prompt = File.exist?(prompt_file_path) ? File.read(prompt_file_path) : ""
    
    # Gera o prompt personalizado
    @prompt = generate_chatgpt_prompt(@user, base_prompt)
  end
  
  private
  
  def ensure_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Acesso negado. Apenas administradores podem acessar esta área."
    end
  end
  
  def generate_chatgpt_prompt(user, base_prompt = "")
    objective_text = case user.objective
    when "emagrecer"
      "Perda de peso e definição"
    when "definir"
      "Definição e tonificação muscular"
    when "ganhar_massa"
      "Ganho de massa muscular"
    else
      "Shape atlético e definido"
    end
    
    # Calcula peso alvo estimado baseado no objetivo
    weight_target = case user.objective
    when "emagrecer"
      "#{(user.start_weight_kg - 8).round(1)}–#{(user.start_weight_kg - 6).round(1)} kg"
    when "definir"
      "#{(user.start_weight_kg - 4).round(1)}–#{(user.start_weight_kg - 2).round(1)} kg"
    when "ganhar_massa"
      "#{(user.start_weight_kg + 4).round(1)}–#{(user.start_weight_kg + 6).round(1)} kg"
    else
      "#{(user.start_weight_kg - 6).round(1)}–#{(user.start_weight_kg - 4).round(1)} kg"
    end
    
    user_info = <<~INFO
      ## INFORMAÇÕES DO USUÁRIO

      ### PERFIL FÍSICO
      - **Altura:** #{user.height_cm} cm
      - **Peso Inicial:** #{user.start_weight_kg} kg
      - **Duração do Plano:** 16 semanas
      - **Objetivo:** #{objective_text}
      - **Nível de experiência:** Intermediário
      - **Restrições/Preferências:** Nenhuma
      - **Equipamentos disponíveis:** Nenhum (100% casa)

      ### METAS E OBJETIVOS
      - **Peso Alvo:** #{weight_target}
      - **Dias de treino por semana:** #{user.training_days_per_week} dias
      - **Perda/Ganho esperado (12 semanas):** Calcule baseado no objetivo
      - **Perda/Ganho esperado (16 semanas):** Calcule baseado no objetivo

      ---

    INFO
    
    if base_prompt.present?
      # Substitui a seção de informações do usuário no prompt base
      base_prompt.gsub(/## INFORMAÇÕES DO USUÁRIO.*?## ESTRUTURA DO PLANO/m, user_info + "## ESTRUTURA DO PLANO")
    else
      # Se não tiver o arquivo, usa prompt simples
      <<~PROMPT
        #{user_info}
        
        Crie um plano de treino e nutrição personalizado em formato JSON seguindo exatamente a estrutura especificada.
        
        Gere o JSON completo com todos os campos:
        - title
        - profile (height_cm, start_weight_kg, duration_weeks)
        - targets (calorias, macros, passos, água, sono)
        - goals (weight_target, loss_12w, loss_16w)
        - rules (5-7 regras)
        - meals (4-5 refeições com opções)
        - foods (proteins, carbs, fats, fibers)
        - workouts (5 treinos diferentes para #{user.training_days_per_week} dias/semana)
        - week_template (lista dos treinos)
        - daily_routine_template (rotina completa do dia)
        - steps_blocks (blocos de passos)
        
        Adapte TODOS os valores baseado nas informações do usuário acima.
      PROMPT
    end
  end
end

