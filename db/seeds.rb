# db/seeds.rb

puts "Seeding DailyLogs..."

# Limpa dados antigos (opcional)
DailyLog.delete_all

today = Date.current

# Simulação: 2 semanas completas (14 dias)
days = 14

start_weight = 70.0
start_waist  = 96.0

# Vamos fazer queda gradual
# - peso: -0.25kg por dia (~3.5kg em 14 dias)
# - cintura: -0.35cm por dia (~4.9cm em 14 dias)
weight_drop_per_day = 0.25
waist_drop_per_day  = 0.35

# Padrão de checklist (variação realista)
# score = quantos true no dia (0..6)
scores_pattern = [
  3, 5, 6, 4, 6, 2, 1,   # semana 1
  4, 5, 6, 4, 6, 3, 2    # semana 2
]

# Helpers: converte "score" em booleans para 6 itens
# Ordem: protein, calories, steps, workout, water, sleep
def checklist_from_score(score)
  score = score.to_i.clamp(0, 6)

  base = {
    hit_protein:  false,
    hit_calories: false,
    hit_steps:    false,
    did_workout:  false,
    hit_water:    false,
    hit_sleep:    false
  }

  # Prioriza hábitos mais importantes (proteína/dieta/treino/passos)
  order = [:hit_protein, :hit_calories, :did_workout, :hit_steps, :hit_water, :hit_sleep]

  order.first(score).each { |k| base[k] = true }
  base
end

# Monta logs do mais antigo ao mais recente
(days - 1).downto(0).each_with_index do |offset, idx|
  date = today - offset

  # curvas realistas: pequeno ruído pra não ficar linear demais
  weight_noise = [-0.2, -0.1, 0.0, 0.1, 0.2].sample
  waist_noise  = [-0.3, -0.1, 0.0, 0.1, 0.2].sample

  weight = (start_weight - (idx * weight_drop_per_day) + weight_noise).round(1)
  waist  = (start_waist  - (idx * waist_drop_per_day)  + waist_noise).round(1)

  score = scores_pattern[idx] || rand(2..6)
  checklist = checklist_from_score(score)

  # Notas realistas em alguns dias
  notes = case idx
          when 1
            "Primeiro dia bem focado. Bati proteína e fiz passos."
          when 5
            "Dia corrido. Fiz pouco passo, mas mantive dieta."
          when 6
            "Domingo: descanso. Foquei só em comer melhor."
          when 8
            "Treino pesado hoje. Flexão quase falhando nas últimas séries."
          when 12
            "Fome à noite, mas segurei com proteína."
          else
            nil
          end

  DailyLog.create!(
    date: date,
    weight_kg: weight,
    waist_cm: waist,
    notes: notes,
    **checklist
  )
end

puts "Seed completo! Criados #{DailyLog.count} DailyLogs."
