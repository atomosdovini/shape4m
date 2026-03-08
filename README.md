# PROMPT PARA GERAÇÃO DE PLANO DE TREINO E NUTRIÇÃO PERSONALIZADO

Você é um especialista em treinamento físico e nutrição. Crie um plano completo e personalizado baseado nas informações fornecidas abaixo.

## INSTRUÇÕES GERAIS
- O plano deve ser 100% executável em casa (sem academia)
- Use linguagem clara, motivadora e prática
- Inclua valores específicos e mensuráveis
- Organize tudo de forma cronológica e fácil de seguir

---

## INFORMAÇÕES DO USUÁRIO

### PERFIL FÍSICO
- **Altura:** [ALTURA_CM] cm
- **Peso Inicial:** [PESO_INICIAL] kg
- **Duração do Plano:** [DURAÇÃO_SEMANAS] semanas
- **Objetivo:** [OBJETIVO - ex: perda de peso, ganho de massa, definição, etc.]
- **Nível de experiência:** [NÍVEL - iniciante/intermediário/avançado]
- **Restrições/Preferências:** [RESTRIÇÕES - ex: vegetariano, sem lactose, lesões, etc.]
- **Equipamentos disponíveis:** [EQUIPAMENTOS - ex: nenhum, esteira, pesos, etc.]

### METAS E OBJETIVOS
- **Peso Alvo:** [PESO_ALVO] kg
- **Perda/Ganho esperado (12 semanas):** [META_12S] kg
- **Perda/Ganho esperado (16 semanas):** [META_16S] kg
- **Outras metas:** [OUTRAS_METAS]

---

## ESTRUTURA DO PLANO A SER GERADO

### 1. TÍTULO DO PLANO
Crie um título motivador e descritivo que reflita o objetivo e a duração.
**Formato:** "Projeto [DURAÇÃO] — [OBJETIVO] ([CONTEXTO])"
**Exemplo:** "Projeto 4 Meses — Shape Atlético e Definido (100% Casa)"

---

### 2. PERFIL (Profile)
```json
{
  "height_cm": [número],
  "start_weight_kg": [número],
  "duration_weeks": [número]
}
```

---

### 3. METAS DIÁRIAS (Targets)
Calcule baseado no perfil e objetivos:
```json
{
  "calories": [número total de calorias],
  "protein_g": [gramas de proteína - idealmente 1.6-2.2g/kg de peso],
  "fat_g": [gramas de gordura - idealmente 0.8-1.2g/kg de peso],
  "carbs_g": [gramas de carboidrato - resto das calorias],
  "steps": [número de passos diários - mínimo 10.000],
  "water_l": [litros de água - formato "X–Y"],
  "sleep_h": [horas de sono - formato "X–Y"]
}
```

**Fórmulas sugeridas:**
- Proteína: peso_alvo × 1.8-2.2g
- Gordura: peso_alvo × 0.9-1.1g
- Carboidrato: (calorias - (proteína×4 + gordura×9)) / 4
- Calorias: TMB × fator_atividade (para perda: -300 a -500kcal; para ganho: +300 a +500kcal)

---

### 4. OBJETIVOS (Goals)
```json
{
  "weight_target": "[PESO_ALVO] kg",
  "loss_12w": "[PERDA_12S] kg",
  "loss_16w": "[PERDA_16S] kg"
}
```

---

### 5. REGRAS DO JOGO (Rules)
Crie 5-7 regras claras e específicas. Exemplos:
- "Bater proteína todo dia ([X]g)"
- "Água: [X]L a [Y]L/dia"
- "[X] refeição livre/semana (uma refeição, não um dia)"
- "Passos/dia: [X]"
- "Dormir [X]–[Y]h sempre que possível"
- "Treinar [X] dias por semana"
- "Sem álcool durante a semana" (se aplicável)

---

### 6. ESTRUTURA DE REFEIÇÕES (Meals)
Crie 4-5 refeições principais com 2-3 opções cada. Adapte aos horários e preferências.

**Formato:**
```json
[
  {
    "name": "Refeição 1 — [NOME]",
    "options": [
      "[Opção 1 com quantidades específicas]",
      "[Opção 2 com quantidades específicas]",
      "[Opção 3 com quantidades específicas]"
    ]
  },
  {
    "name": "Refeição 2 — [NOME]",
    "options": [...]
  }
]
```

**Exemplo:**
```json
[
  {
    "name": "Refeição 1 — Café da Manhã",
    "options": [
      "3 ovos + 1 banana média",
      "Iogurte grego natural (200g) + aveia (30g) + fruta (1 unidade)"
    ]
  },
  {
    "name": "Refeição 2 — Almoço",
    "options": [
      "[X]g proteína (frango, peixe, carne magra) + [Y]g arroz cozido OU [Z]g batata + salada grande (à vontade)"
    ]
  }
]
```

---

### 7. LISTA DE ALIMENTOS (Foods)
Organize por categoria com opções variadas:

```json
{
  "proteins": ["Lista de fontes de proteína"],
  "carbs": ["Lista de fontes de carboidrato"],
  "fats": ["Lista de fontes de gordura saudável"],
  "fibers": ["Lista de vegetais e fibras"]
}
```

**Adapte baseado em:**
- Restrições alimentares
- Disponibilidade regional
- Orçamento
- Preferências pessoais

---

### 8. TREINOS (Workouts)
Crie 5 treinos diferentes para segunda a sexta. Adapte baseado em:
- Nível de experiência
- Equipamentos disponíveis
- Objetivo (força, hipertrofia, resistência, etc.)

**Formato:**
```json
{
  "DIA 1 — [NOME DO TREINO]": [
    ["Nome do exercício", "Séries e repetições"],
    ["Nome do exercício", "Séries e repetições"],
    ...
  ],
  "DIA 2 — [NOME DO TREINO]": [...],
  ...
}
```

**Estrutura sugerida:**
- **DIA 1 — PUSH** (peito, ombro, tríceps)
- **DIA 2 — PERNAS + CORE**
- **DIA 3 — PULL** (costas, bíceps)
- **DIA 4 — OMBROS + BRAÇOS**
- **DIA 5 — FULL BODY**

**Para cada exercício, inclua:**
- Nome claro
- Séries × repetições (ex: "5x 6–15")
- Variações para diferentes níveis
- Dicas de execução se necessário

**Exemplo:**
```json
{
  "DIA 1 — PUSH": [
    ["Flexão tradicional", "5x 6–15"],
    ["Flexão inclinada (sofá/cadeira)", "4x 10–20"],
    ["Pike push-up (ombro)", "4x 6–12"],
    ["Mergulho no banco (tríceps)", "4x 10–20"],
    ["Flexão diamante (finisher)", "2–3x até quase falhar"],
    ["Prancha", "3x 45–60s"]
  ]
}
```

---

### 9. TEMPLATE SEMANAL (Week Template)
Lista dos 5 treinos em ordem (segunda a sexta):
```json
[
  "DIA 1 — [NOME]",
  "DIA 2 — [NOME]",
  "DIA 3 — [NOME]",
  "DIA 4 — [NOME]",
  "DIA 5 — [NOME]"
]
```

---

### 10. ROTINA DIÁRIA (Daily Routine Template)
Crie uma rotina completa do dia com horários específicos:

```json
[
  {
    "time": "HH:MM",
    "title": "Título da atividade",
    "detail": "Descrição detalhada do que fazer"
  },
  ...
]
```

**Estrutura sugerida:**
- Acordar + hidratação
- Café da manhã
- Bloco de passos/cardio
- Hidratação
- Almoço
- Bloco de passos/cardio
- Lanche
- Treino (dias de treino) OU Atividade leve (fins de semana)
- Bloco de passos/cardio
- Jantar
- Fechar passos + hidratação
- Sono

**Exemplo:**
```json
[
  {
    "time": "07:00",
    "title": "Acordar + água",
    "detail": "500ml água + 5 min mobilidade"
  },
  {
    "time": "07:30",
    "title": "Café (Refeição 1)",
    "detail": "Opção: 3 ovos + banana OU iogurte grego + aveia + fruta"
  },
  {
    "time": "08:00",
    "title": "Passos (Bloco 1)",
    "detail": "2.000–3.000 passos (10–20 min)"
  }
]
```

---

### 11. BLOCOS DE PASSOS (Steps Blocks)
Divida a meta diária de passos em blocos ao longo do dia:

```json
[
  {
    "time": "HH:MM",
    "steps": [número],
    "label": "Nome do bloco"
  },
  ...
]
```

**Exemplo:**
```json
[
  {
    "time": "08:00",
    "steps": 3000,
    "label": "Passos (Bloco 1)"
  },
  {
    "time": "13:15",
    "steps": 4000,
    "label": "Passos (Bloco 2)"
  },
  {
    "time": "18:15",
    "steps": 4000,
    "label": "Passos (Bloco 3)"
  },
  {
    "time": "21:30",
    "steps": 1000,
    "label": "Fechar passos"
  }
]
```

---

## FORMATO DE SAÍDA

Gere o plano completo em formato JSON seguindo exatamente esta estrutura:

```json
{
  "title": "[TÍTULO DO PLANO]",
  "profile": {
    "height_cm": [número],
    "start_weight_kg": [número],
    "duration_weeks": [número]
  },
  "targets": {
    "calories": [número],
    "protein_g": [número],
    "fat_g": [número],
    "carbs_g": [número],
    "steps": [número],
    "water_l": "[X–Y]",
    "sleep_h": "[X–Y]"
  },
  "goals": {
    "weight_target": "[X–Y] kg",
    "loss_12w": "[X–Y] kg",
    "loss_16w": "[X–Y] kg"
  },
  "rules": [
    "Regra 1",
    "Regra 2",
    ...
  ],
  "meals": [
    {
      "name": "Nome da refeição",
      "options": ["Opção 1", "Opção 2", ...]
    },
    ...
  ],
  "foods": {
    "proteins": ["...", "..."],
    "carbs": ["...", "..."],
    "fats": ["...", "..."],
    "fibers": ["...", "..."]
  },
  "workouts": {
    "DIA 1 — [NOME]": [
      ["Exercício", "Séries"],
      ...
    ],
    ...
  },
  "week_template": [
    "DIA 1 — [NOME]",
    "DIA 2 — [NOME]",
    "DIA 3 — [NOME]",
    "DIA 4 — [NOME]",
    "DIA 5 — [NOME]"
  ],
  "daily_routine_template": [
    {
      "time": "HH:MM",
      "title": "...",
      "detail": "..."
    },
    ...
  ],
  "steps_blocks": [
    {
      "time": "HH:MM",
      "steps": [número],
      "label": "..."
    },
    ...
  ]
}
```

---

## DIRETRIZES IMPORTANTES

1. **Personalização:** Adapte TUDO baseado nas informações do usuário
2. **Realismo:** Valores devem ser alcançáveis e sustentáveis
3. **Progressão:** Considere progressão ao longo das semanas
4. **Flexibilidade:** Ofereça opções e alternativas
5. **Clareza:** Use linguagem simples e direta
6. **Especificidade:** Sempre inclua quantidades e medidas
7. **Motivação:** Mantenha tom positivo e encorajador

---

## EXEMPLO DE USO

### Input do Usuário:
```
Altura: 175 cm
Peso: 85 kg
Objetivo: Perda de peso e definição
Duração: 12 semanas
Nível: Intermediário
Equipamentos: Nenhum (100% casa)
Restrições: Sem lactose
Peso alvo: 75 kg
```

### Output Esperado:
[Plano completo em JSON seguindo a estrutura acima, com todos os valores calculados e personalizados]

---

## EXEMPLO COMPLETO DE PLANO GERADO

```json
{
  "title": "Projeto 12 Semanas — Perda de Peso e Definição (100% Casa)",
  "profile": {
    "height_cm": 175,
    "start_weight_kg": 85,
    "duration_weeks": 12
  },
  "targets": {
    "calories": 1800,
    "protein_g": 150,
    "fat_g": 60,
    "carbs_g": 165,
    "steps": 12000,
    "water_l": "2.5–3.0",
    "sleep_h": "7–8"
  },
  "goals": {
    "weight_target": "73–75 kg",
    "loss_12w": "8–10 kg",
    "loss_16w": "10–12 kg"
  },
  "rules": [
    "Bater proteína todo dia (150g)",
    "Água: 2,5L a 3L/dia",
    "1 refeição livre/semana (uma refeição, não um dia)",
    "Passos/dia: 12.000",
    "Dormir 7–8h sempre que possível",
    "Treinar 5 dias por semana (segunda a sexta)",
    "Sem álcool durante a semana"
  ],
  "meals": [
    {
      "name": "Refeição 1 — Café da Manhã",
      "options": [
        "3 ovos + 1 banana média",
        "Aveia (50g) + frutas + amêndoas (10g)",
        "Panqueca proteica (2 ovos + 1 banana + aveia 30g)"
      ]
    },
    {
      "name": "Refeição 2 — Almoço",
      "options": [
        "200g proteína (frango, peixe, patinho) + 150g arroz cozido OU 250g batata + salada grande (à vontade)"
      ]
    },
    {
      "name": "Refeição 3 — Lanche",
      "options": [
        "Whey 30g + banana",
        "2 ovos + fruta",
        "Iogurte grego sem lactose + fruta"
      ]
    },
    {
      "name": "Refeição 4 — Jantar",
      "options": [
        "200g proteína + legumes/salada à vontade + carbo pequeno se necessário (80–100g arroz OU 150g batata)"
      ]
    }
  ],
  "foods": {
    "proteins": [
      "Frango",
      "Patinho",
      "Peixe",
      "Ovos",
      "Iogurte grego sem lactose",
      "Whey protein",
      "Peito de peru"
    ],
    "carbs": [
      "Arroz",
      "Feijão",
      "Batata",
      "Batata doce",
      "Aveia",
      "Frutas",
      "Quinoa"
    ],
    "fats": [
      "Azeite",
      "Amendoim/Castanhas (pouco)",
      "Gema do ovo",
      "Abacate"
    ],
    "fibers": [
      "Salada grande",
      "Brócolis",
      "Abobrinha",
      "Pepino",
      "Cenoura",
      "Espinafre",
      "Couve"
    ]
  },
  "workouts": {
    "DIA 1 — PUSH": [
      ["Flexão tradicional", "5x 6–15"],
      ["Flexão inclinada (sofá/cadeira)", "4x 10–20"],
      ["Pike push-up (ombro)", "4x 6–12"],
      ["Mergulho no banco (tríceps)", "4x 10–20"],
      ["Flexão diamante (finisher)", "2–3x até quase falhar"],
      ["Prancha", "3x 45–60s"]
    ],
    "DIA 2 — PERNAS + CORE": [
      ["Agachamento livre", "5x 15–30"],
      ["Afundo / Lunge", "4x 10–15 por perna"],
      ["Agachamento búlgaro", "4x 8–12 por perna"],
      ["Elevação pélvica (hip thrust)", "4x 12–25"],
      ["Panturrilha em degrau", "6x 12–25"],
      ["Abdominal infra", "4x 15–25"]
    ],
    "DIA 3 — PULL": [
      ["Remada (mesa OU mochila OU toalha)", "5x 6–20"],
      ["Superman (postura)", "4x 15–25"],
      ["Rosca bíceps (mochila)", "4x 10–20"],
      ["Encolhimento trapézio (mochila)", "4x 12–25"],
      ["Curl martelo (mochila)", "3x 10–20"],
      ["Prancha lateral", "3x 30–45s/lado"]
    ],
    "DIA 4 — OMBROS + BRAÇOS": [
      ["Pike push-up", "5x 6–12"],
      ["Flexão lenta / arqueiro", "4x 8–15"],
      ["Elevação lateral (garrafas)", "5x 12–25"],
      ["Tríceps no banco (lento)", "4x 10–20"],
      ["Bíceps (mochila, 2s no topo)", "4x 10–20"],
      ["Finisher: flexão até falhar", "1x"],
      ["Prancha", "1x 2 min"]
    ],
    "DIA 5 — FULL BODY": [
      ["Flexão (declinada ou normal)", "4x 8–15"],
      ["Agachamento com mochila", "4x 15–30"],
      ["Remada (qualquer variação)", "4x 10–20"],
      ["Afundo", "3x 12 por perna"],
      ["Burpee controlado", "5x 6–12"],
      ["Bicicleta", "4x 20"],
      ["Prancha", "3x 60s"]
    ]
  },
  "week_template": [
    "DIA 1 — PUSH",
    "DIA 2 — PERNAS + CORE",
    "DIA 3 — PULL",
    "DIA 4 — OMBROS + BRAÇOS",
    "DIA 5 — FULL BODY"
  ],
  "daily_routine_template": [
    {
      "time": "07:00",
      "title": "Acordar + água",
      "detail": "500ml água + 5 min mobilidade"
    },
    {
      "time": "07:30",
      "title": "Café (Refeição 1)",
      "detail": "Opção: 3 ovos + banana OU aveia + frutas + amêndoas"
    },
    {
      "time": "08:00",
      "title": "Passos (Bloco 1)",
      "detail": "2.000–3.000 passos (10–20 min)"
    },
    {
      "time": "10:30",
      "title": "Água",
      "detail": "Mais 400–600ml água"
    },
    {
      "time": "12:30",
      "title": "Almoço (Refeição 2)",
      "detail": "200g proteína + arroz/batata + salada grande"
    },
    {
      "time": "13:15",
      "title": "Passos (Bloco 2)",
      "detail": "3.000–4.000 passos (20–30 min)"
    },
    {
      "time": "16:30",
      "title": "Lanche (Refeição 3)",
      "detail": "Whey + banana OU ovos + fruta OU iogurte grego sem lactose + fruta"
    },
    {
      "time": "17:00",
      "title": "Treino (Força)",
      "detail": "40–60 min — quase falha (1–3 reps na reserva)"
    },
    {
      "time": "18:15",
      "title": "Passos (Bloco 3)",
      "detail": "3.000–4.000 passos (20–30 min)"
    },
    {
      "time": "20:00",
      "title": "Jantar (Refeição 4)",
      "detail": "200g proteína + legumes/salada; carbo pequeno se necessário"
    },
    {
      "time": "21:30",
      "title": "Fechar passos + água",
      "detail": "Bater 12k + 300–500ml água"
    },
    {
      "time": "23:00",
      "title": "Sono",
      "detail": "Meta: 7–8h"
    }
  ],
  "steps_blocks": [
    {
      "time": "08:00",
      "steps": 3000,
      "label": "Passos (Bloco 1)"
    },
    {
      "time": "13:15",
      "steps": 4000,
      "label": "Passos (Bloco 2)"
    },
    {
      "time": "18:15",
      "steps": 4000,
      "label": "Passos (Bloco 3)"
    },
    {
      "time": "21:30",
      "steps": 1000,
      "label": "Fechar passos"
    }
  ]
}
```

---

## NOTAS FINAIS

Este prompt foi criado para ser usado com modelos de IA (como GPT-4, Claude, etc.) para gerar planos de treino e nutrição completamente personalizados. 

**Como usar:**
1. Preencha as informações do usuário nas seções marcadas com `[VARIÁVEL]`
2. Envie o prompt completo para a IA
3. A IA gerará um JSON completo seguindo a estrutura especificada
4. O JSON gerado pode ser diretamente inserido no sistema através da página de perfil

**Dicas:**
- Seja específico nas informações do usuário
- Ajuste as fórmulas de cálculo conforme necessário
- Revise sempre os valores gerados para garantir realismo
- Personalize exemplos baseados em casos reais

---

**Versão:** 1.0  
**Data:** 2026-01-11  
**Autor:** Sistema Shape4M
