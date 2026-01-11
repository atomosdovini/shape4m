# app/models/plan.rb
class Plan
  TITLE = "Projeto 4 Meses — Shape Atlético e Definido (100% Casa)"

  PROFILE = {
    height_cm: 160,
    start_weight_kg: 70,
    duration_weeks: 16
  }

  TARGETS = {
    calories: 1600,
    protein_g: 140,
    fat_g: 50,
    carbs_g: 110,
    steps: 12_000,
    water_l: "2.5–3.0",
    sleep_h: "7–8"
  }

  GOALS = {
    weight_target: "62–64 kg",
    loss_12w: "6–8 kg",
    loss_16w: "8–10 kg"
  }.freeze


  RULES = [
    "Bater proteína todo dia (140g)",
    "Água: 2,5L a 3L/dia",
    "1 refeição livre/semana (uma refeição, não um dia)",
    "Passos/dia: 12.000",
    "Dormir 7–8h sempre que possível"
  ].freeze


  MEALS = [
    {
      name: "Refeição 1 — Café",
      options: [
        "3 ovos + 1 banana",
        "Iogurte grego natural + aveia (30g) + fruta"
      ]
    },
    {
      name: "Refeição 2 — Almoço (padrão)",
      options: [
        "200g proteína (frango, patinho, peixe)",
        "150g arroz cozido OU 250g batata",
        "Salada grande (à vontade)"
      ]
    },
    {
      name: "Refeição 3 — Lanche",
      options: [
        "Whey 30g + banana",
        "2 ovos + fruta",
        "Iogurte grego + fruta"
      ]
    },
    {
      name: "Refeição 4 — Jantar (mais seco)",
      options: [
        "200g proteína",
        "Legumes/salada à vontade",
        "Carbo pequeno somente se necessário (80–100g arroz OU 150g batata)"
      ]
    }
  ]

  FOODS = {
    proteins: ["Frango", "Patinho", "Peixe", "Ovos", "Iogurte grego natural", "Whey (opcional)"],
    carbs: ["Arroz", "Feijão", "Batata", "Aveia", "Frutas"],
    fats: ["Azeite", "Amendoim/Castanhas (pouco)", "Gema do ovo"],
    fibers: ["Salada grande", "Brócolis", "Abobrinha", "Pepino", "Cenoura"]
  }

  WORKOUTS = {
    "DIA 1 — PUSH" => [
      ["Flexão tradicional", "5x 6–15"],
      ["Flexão inclinada (sofá/cadeira)", "4x 10–20"],
      ["Pike push-up (ombro)", "4x 6–12"],
      ["Mergulho no banco (tríceps)", "4x 10–20"],
      ["Flexão diamante (finisher)", "2–3x até quase falhar"],
      ["Prancha", "3x 45–60s"]
    ],
    "DIA 2 — PERNAS + CORE" => [
      ["Agachamento livre", "5x 15–30"],
      ["Afundo / Lunge", "4x 10–15 por perna"],
      ["Agachamento búlgaro", "4x 8–12 por perna"],
      ["Elevação pélvica (hip thrust)", "4x 12–25"],
      ["Panturrilha em degrau", "6x 12–25"],
      ["Abdominal infra", "4x 15–25"]
    ],
    "DIA 3 — PULL" => [
      ["Remada (mesa OU mochila OU toalha)", "5x 6–20"],
      ["Superman (postura)", "4x 15–25"],
      ["Rosca bíceps (mochila)", "4x 10–20"],
      ["Encolhimento trapézio (mochila)", "4x 12–25"],
      ["Curl martelo (mochila)", "3x 10–20"],
      ["Prancha lateral", "3x 30–45s/lado"]
    ],
    "DIA 4 — OMBROS + BRAÇOS" => [
      ["Pike push-up", "5x 6–12"],
      ["Flexão lenta / arqueiro", "4x 8–15"],
      ["Elevação lateral (garrafas)", "5x 12–25"],
      ["Tríceps no banco (lento)", "4x 10–20"],
      ["Bíceps (mochila, 2s no topo)", "4x 10–20"],
      ["Finisher: flexão até falhar", "1x"],
      ["Prancha", "1x 2 min"]
    ],
    "DIA 5 — FULL BODY" => [
      ["Flexão (declinada ou normal)", "4x 8–15"],
      ["Agachamento com mochila", "4x 15–30"],
      ["Remada (qualquer variação)", "4x 10–20"],
      ["Afundo", "3x 12 por perna"],
      ["Burpee controlado", "5x 6–12"],
      ["Bicicleta", "4x 20"],
      ["Prancha", "3x 60s"]
    ]
  }

  # segunda..sexta
  WEEK_TEMPLATE = ["DIA 1 — PUSH", "DIA 2 — PERNAS + CORE", "DIA 3 — PULL", "DIA 4 — OMBROS + BRAÇOS", "DIA 5 — FULL BODY"]

  def self.workout_for(date)
    # 0=Sunday..6=Saturday. Considera treino apenas seg(1) a sex(5)
    wday = date.wday
    return nil if wday == 0 || wday == 6
    WEEK_TEMPLATE[wday - 1]
  end

    # Rotina diária (hard-coded) — você pode ajustar depois
  DAILY_ROUTINE = [
    { time: "07:00", title: "Acordar + água", detail: "500ml água + 5 min mobilidade" },
    { time: "07:30", title: "Café (Refeição 1)", detail: "Opção: 3 ovos + banana OU iogurte grego + aveia + fruta" },
    { time: "08:00", title: "Passos (Bloco 1)", detail: "2.000–3.000 passos (10–20 min)" },
    { time: "10:30", title: "Água", detail: "Mais 400–600ml água" },
    { time: "12:30", title: "Almoço (Refeição 2)", detail: "200g proteína + arroz/batata + salada grande" },
    { time: "13:15", title: "Passos (Bloco 2)", detail: "3.000–4.000 passos (20–30 min)" },
    { time: "16:30", title: "Lanche (Refeição 3)", detail: "Whey + banana OU ovos + fruta OU iogurte grego + fruta" },
    { time: "17:00", title: "Treino (Força)", detail: "40–60 min — quase falha (1–3 reps na reserva)" },
    { time: "18:15", title: "Passos (Bloco 3)", detail: "3.000–4.000 passos (20–30 min)" },
    { time: "20:00", title: "Jantar (Refeição 4)", detail: "200g proteína + legumes/salada; carbo pequeno se necessário" },
    { time: "21:30", title: "Fechar passos + água", detail: "Bater 12k + 300–500ml água" },
    { time: "23:00", title: "Sono", detail: "Meta: 7–8h" }
  ].freeze

  def self.routine_for(_date)
    DAILY_ROUTINE
  end

  # Retorna índice do próximo item baseado no horário atual
  def self.next_routine_index(now_time)
    routine = DAILY_ROUTINE
    now_minutes = now_time.hour * 60 + now_time.min

    routine_minutes = routine.map do |item|
      h, m = item[:time].split(":").map(&:to_i)
      h * 60 + m
    end

    idx = routine_minutes.index { |mins| mins >= now_minutes }
    idx || (routine.length - 1)
  end



  def self.training_day?(date)
    # Seg–Sex = treino; Sáb/Dom = descanso/steps
    !(date.saturday? || date.sunday?)
  end

  # blocos que batem 12k (pode ajustar depois)
  def self.steps_blocks
    [
      { time: "08:00", steps: 3000, label: "Passos (Bloco 1)" },
      { time: "13:15", steps: 4000, label: "Passos (Bloco 2)" },
      { time: "18:15", steps: 4000, label: "Passos (Bloco 3)" },
      { time: "21:30", steps: 1000, label: "Fechar passos" }
    ]
  end

  # Rotina “template” do dia (retorna array de steps com key única)
  def self.routine_template_for(date)
    routine = []

    routine << { key: "wake_water", time: "07:00", title: "Acordar + água", detail: "500ml água + 5 min mobilidade" }
    routine << { key: "meal_1", time: "07:30", title: "Café (Refeição 1)", detail: "3 ovos + banana OU iogurte grego + aveia + fruta" }

    steps_blocks.each_with_index do |b, i|
      routine << {
        key: "steps_#{i+1}",
        time: b[:time],
        title: b[:label],
        detail: "#{b[:steps]} passos (esteira/caminhada)"
      }
    end

    routine << { key: "water_mid", time: "10:30", title: "Água", detail: "Mais 400–600ml água" }
    routine << { key: "meal_2", time: "12:30", title: "Almoço (Refeição 2)", detail: "200g proteína + arroz/batata + salada grande" }
    routine << { key: "meal_3", time: "16:30", title: "Lanche (Refeição 3)", detail: "Whey + banana OU ovos + fruta OU iogurte grego + fruta" }

    if training_day?(date)
      workout_name = workout_for(date) # seu método existente
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
  def self.ensure_routine_logs_for!(date)
    template = routine_template_for(date)

    template.each_with_index do |item, idx|
      RoutineLog.find_or_create_by!(date: date, key: item[:key]) do |rl|
        rl.position = idx + 1
        rl.done = false
      end
    end

    # Atualiza posição caso template mude com o tempo
    template.each_with_index do |item, idx|
      RoutineLog.where(date: date, key: item[:key]).update_all(position: idx + 1)
    end
  end
end
