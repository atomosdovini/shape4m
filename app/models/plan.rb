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
end
