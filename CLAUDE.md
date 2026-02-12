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

### Agenten-Transparenz

**Immer explizit ausgeben**, welcher Agent gerade arbeitet — vor dem Aufruf:

```
🤖 Agent: solution-architect
📋 Aufgabe: Migrationsplan für PROJ-1 entwerfen
```

Nach Abschluss kurze Zusammenfassung, was der Agent geliefert hat.

## Modell-Konfiguration

Welches Claude-Modell jeder Agent nutzt ist zentral in `.claude/model-config.md` dokumentiert.
Modelle NIE direkt in den Agent-Dateien ändern — stattdessen:
1. `.claude/model-config.md` anpassen
2. `bash scripts/update-agent-models.sh` ausführen

## Konventionen

- Feature Specs: `/features/PROJ-X-name.md`
- Python Code: `/src/`
- Tests: `/tests/` (pytest)
- Prompts: `/src/prompts/`
- API-Keys: `.env` (nie ins Git)
- Commit-Format: `type(PROJ-X): message`
