# Claude Code Instructions

## Beim Session-Start

**Immer zuerst `STATUS.md` lesen** — dort ist der aktuelle Entwicklungsstand:
- Welche Features sind in Arbeit?
- Was war der letzte erledigte Schritt?
- Was ist als nächstes geplant?

Falls `STATUS.md` nicht existiert oder veraltet wirkt:
```
Lies .claude/agents/status-tracker.md und aktualisiere STATUS.md
```

## Projektkontext

Lies `PROJECT_CONTEXT.md` für Projekt-Ziele, Tech-Stack und Konventionen.

## Agenten

Die spezialisierten Agenten liegen in `.claude/agents/`. Nutze sie für strukturierte Workflows:

| Agent | Zweck |
|-------|-------|
| `requirements-engineer` | Feature-Idee → Spec |
| `solution-architect` | Spec → Architektur |
| `python-dev` | Architektur → Code |
| `qa-engineer` | Code → Tests + Bug-Report |
| `prompt-engineer` | Prompts entwickeln + optimieren |
| `status-tracker` | Entwicklungsstand loggen + STATUS.md aktualisieren |

## Konventionen

- Feature Specs: `/features/PROJ-X-name.md`
- Python Code: `/src/`
- Tests: `/tests/` (pytest)
- Prompts: `/src/prompts/`
- API-Keys: `.env` (nie ins Git)
- Commit-Format: `type(PROJ-X): message`
