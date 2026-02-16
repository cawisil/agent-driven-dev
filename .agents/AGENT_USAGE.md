# Agent Usage Workflow

Kurz: Schritt‑für‑Schritt Anleitung wie Agenten im Projekt sicher und konsistent eingesetzt werden.

1) Agent auswählen
- Öffne `.agents/agents-registry.md` und wähle Agent `id` (z. B. `python-developer`).
- Öffne die zugehörige Datei `.agents/agents/agent-<id>.md` für Details.

2) Prüfe Model‑Zuweisung
- Optional: passe `.agents/config/model-config.md` an.
- Propagiere Änderungen mit:
```bash
.agents/scripts/update-agent-models.sh --dry-run
.agents/scripts/update-agent-models.sh --apply
```

3) Vor dem Agent‑Aufruf: Preamble (human‑readable)
- Beispiel (immer ausgeben *vor* Ausführung):
```
🤖 Agent: python-developer (sonnet)
📋 Task: Implement PROJ-12 feature: add inference API
⏱️ Estimated: 30m
```

4) Agent ausführen (konzeptuell)
- Orchestrator/you should: provide Feature Spec path, repo context, and allowed tools.
- For code execution/tests use `code-executor` sandbox; CI jobs run via `ci-runner`.

5) Post‑Run: Output & Handoff
- Agent outputs changed files and a short summary.
- Commit messages follow conventions: `feat(PROJ-X): description`.
- Run `status-tracker` to update `STATUS.md` (automated after Major Agents).

6) Safety & Ops
- Use least‑privilege: only grant `git_write` to `python-developer` and `release-manager` as needed.
- Run `security-engineer` (SCA) before merging release PRs.
- For cost control, prefer `haiku` for small tasks and escalate to `sonnet`/`opus` only when necessary.

7) Typical sequences
- New Feature:
  1. `requirements-engineer` → creates `/features/PROJ-X.md`
  2. `solution-architect` → adds Tech‑Design
  3. `ml-expert` (if ML) → review
  4. `python-developer` → implement + tests
  5. `code-reviewer` → review PR
  6. `qa-engineer` → final tests
  7. `release-manager` → release draft

- Hotfix:
  1. `python-developer` → fix in branch
  2. `code-reviewer` → quick review
  3. `ci-runner` → run tests
  4. `security-engineer` → quick SCA
  5. Merge + `release-manager`

8) Notes for humans
- Always verify agent suggestions before merging.
- Keep `agents-registry.md` and agent frontmatter `id:` in sync.

