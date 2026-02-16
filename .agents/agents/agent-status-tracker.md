id: status-tracker
name: Status Tracker
role: status
model_preferences:
  - provider: claude
    model: haiku
    cost_tier: low
allowed_tools:
  - git_read
  - docs_retriever
  - reporter
runtime_settings:
  temperature: 0.0
  max_tokens: 600
permissions:
  git: read
  secrets: none
---

# Status Tracker (Agent)

Kurz: Aggregiert Projektstatus und schreibt `STATUS.md`. Wird oft auf Session‑Start ausgeführt.

Deliverables:
- `STATUS.md` summary
- Quick‑start prompt for next session
