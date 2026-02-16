---
# Machine-readable agent registry (basic template)
agents:
  - id: solution-architect
    name: "Solution Architect"
    role: architect
    model_preferences:
      - provider: claude
        model: sonnet
        cost_tier: medium
    allowed_tools:
      - docs_retriever
      - web_search
      - git_read
    runtime_settings:
      temperature: 0.2
      max_tokens: 1500
    permissions:
      git: read
      secrets: none

  - id: python-developer
    name: "Python Developer"
    role: developer
    model_preferences:
      - provider: claude
        model: sonnet
        cost_tier: medium
    allowed_tools:
      - code_executor
      - git_read
      - git_write
      - package_manager
    runtime_settings:
      temperature: 0.0
      max_tokens: 2000
    permissions:
      git: write
      secrets: none

  - id: qa-engineer
    name: "QA Engineer"
    role: qa
    model_preferences:
      - provider: claude
        model: sonnet
        cost_tier: medium
    allowed_tools:
      - test_runner
      - git_read
      - reporter
    runtime_settings:
      temperature: 0.0
      max_tokens: 1200
    permissions:
      git: read
      secrets: none

  - id: ml-expert
    name: "ML Expert"
    role: ml
    model_preferences:
      - provider: claude
        model: sonnet
        cost_tier: medium
    allowed_tools:
      - docs_retriever
      - vector_store
      - git_read
    runtime_settings:
      temperature: 0.1
      max_tokens: 2000
    permissions:
      git: read
      secrets: none

  - id: prompt-engineer
    name: "Prompt Engineer"
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

  - id: requirements-engineer
    name: "Requirements Engineer"
    role: requirements
    model_preferences:
      - provider: claude
        model: haiku
        cost_tier: low
    allowed_tools:
      - docs_retriever
      - git_read
    runtime_settings:
      temperature: 0.2
      max_tokens: 1000
    permissions:
      git: read
      secrets: none

  - id: status-tracker
    name: "Status Tracker"
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

  - id: code-reviewer
    name: "Code Reviewer"
    role: reviewer
    model_preferences:
      - provider: openai
        model: gpt-4o-code
        cost_tier: high
    allowed_tools:
      - git_read
      - static_analyzer
      - linter
    runtime_settings:
      temperature: 0.0
      max_tokens: 1500
    permissions:
      git: read
      secrets: none

  - id: ci-runner
    name: "CI Runner"
    role: ci
    model_preferences: []
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

  - id: code-executor
    name: "Code Executor"
    role: executor
    model_preferences: []
    allowed_tools:
      - container_runtime
      - resource_limiter
    runtime_settings:
      temperature: 0.0
      max_tokens: 600
    permissions:
      git: read
      secrets: none

  - id: release-manager
    name: "Release Manager"
    role: release
    model_preferences:
      - provider: openai
        model: gpt-4o
        cost_tier: high
    allowed_tools:
      - git_read
      - git_write
      - changelog_generator
    runtime_settings:
      temperature: 0.2
      max_tokens: 800
    permissions:
      git: write
      secrets: none

  - id: security-engineer
    name: "Security Agent"
    role: security
    model_preferences: []
    allowed_tools:
      - dependency_scanner
      - secret_scanner
      - static_analyzer
    runtime_settings:
      temperature: 0.0
      max_tokens: 1200
    permissions:
      git: read
      secrets: none

---

Notes:
- Update this registry when adding/removing agents.
- Orchestrator can parse this YAML to wire agent → tool bindings and permissions.
