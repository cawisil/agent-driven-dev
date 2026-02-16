id: code-executor
name: Code Executor (Sandbox)
role: executor
model_preferences:
  - provider: none
    model: none
allowed_tools:
  - container_runtime
  - resource_limiter
runtime_settings:
  temperature: 0.0
  max_tokens: 600
permissions:
  git: read
  secrets: none
---

# Code Executor (Isolated Sandbox)

Kurz: Führt Python‑Code sicher in einem isolierten Sandbox‑Umfeld zur Laufzeit aus (tests, quick checks).

Security rules:
- Network disabled by default
- Timeouts and memory limits enforced
- No access to secrets or host filesystem (read-only mounts only)

Usage:
- `python-developer` and `qa-engineer` request execution with inputs and tests
- Executor returns stdout/stderr, exit code, and limited artifacts