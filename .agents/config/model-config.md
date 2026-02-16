````markdown
# Agent Model Configuration

> Single source of truth for agent → model mapping used by the orchestrator.

## Current assignment (logical agent id → preferred model)

| Agent (id) | Preferred model | Reasoning |
|------------|-----------------|----------|
| requirements-engineer | `haiku` | Fast, cheap — structure + conversation tasks
| solution-architect | `sonnet` | Balanced reasoning and design capability
| python-developer | `sonnet` | Code implementation, deterministic outputs
| qa-engineer | `sonnet` | Test generation and analysis
| prompt-engineer | `sonnet` | Nuanced prompt development and eval
| status-tracker | `haiku` | Lightweight summarization
| ml-expert | `sonnet` | ML review and technical evaluation

## Available Claude models (example mapping)

```
haiku   → claude-haiku-4-5-20251001   (quick + low cost)
sonnet  → claude-sonnet-4-5-20250929  (balanced, good for code + reasoning)
opus    → claude-opus-4-6             (highest capability, higher cost)
```

## When to temporarily escalate to `opus`?

- solution-architect: very complex design with many tradeoffs
- python-developer: large refactor (50+ files) or complex API integrations
- qa-engineer: hard-to-diagnose critical bug

## Multi‑provider note
This registry is provider‑agnostic and the orchestrator may map `sonnet` → an available model from another provider (e.g., `gpt-4o-code`) depending on availability and cost policy.

## Update process

1. Edit this file to change preferred models.
2. Run `.agents/scripts/update-agent-models.sh --apply` to propagate to agent frontmatter files.
3. Verify by running:

```bash
grep "^model:" .agents/agents/*.md || true
```

Notes:
- Keep agent ids consistent between `agents-registry.md`, agent frontmatter `id:` and filenames (`agent-<id>.md`).
```

````
