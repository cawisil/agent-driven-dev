id: ci-runner
name: CI Runner
role: ci
model_preferences:
  - provider: none
    model: none
    cost_tier: none
allowed_tools:
  - test_runner
  - build_system
  - container_runtime
runtime_settings:
  temperature: 0.0
  max_tokens: 600
permissions:
  git: read
  secrets: none
---

# CI Runner (Agent)

Kurz: Orchestrates automated builds and tests in isolated environment. Not an LLM heavy agent — runs tooling.

Responsibilities:
- Execute build matrix and tests
- Collect logs and artifacts
- Report failing jobs to `status-tracker` and `code-reviewer`

Safety:
- Run in containerized sandboxes with resource/time limits

Example commands (human):
```bash
docker build -t project-test .
docker run --rm project-test pytest -q
```