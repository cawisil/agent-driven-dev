id: prompt-engineer
name: Prompt Engineer
role: prompt
model_preferences:
  - provider: claude
    model: sonnet
    cost_tier: medium
allowed_tools:
  - test_runner
  - git_read
runtime_settings:
  temperature: 0.2
  max_tokens: 1200
permissions:
  git: read
  secrets: none
---

# Prompt Engineer (Agent)

Kurz: Entwickelt und evaluiert Prompt‑Templates, erstellt Eval‑Sets and runs A/B prompt comparisons.

Deliverables:
- Prompt library in `src/prompts/`
- Evaluation results and recommended variant