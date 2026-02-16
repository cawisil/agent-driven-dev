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
| `ml-expert` | ML-Annahmen + Modellwahl + Transformationen fachlich prüfen |
| `prompt-engineer` | Prompts entwickeln + optimieren |
| `status-tracker` | Entwicklungsstand loggen + STATUS.md aktualisieren |

### Agenten-Transparenz

**Immer explizit ausgeben**, welcher Agent gerade arbeitet — vor dem Aufruf:

```
🤖 Agent: solution-architect (opus)
📋 Aufgabe: Migrationsplan für PROJ-1 entwerfen
⏱️ Geschätzte Dauer: 15 Min
```

Nach Abschluss:
```
✅ Agent: solution-architect complete
📊 Output: Tech-Design in /features/PROJ-1.md
👉 Nächster Schritt: Python Developer implementiert
```

### Agent-Workflow mit Modell-Transparenz

| Agent | Modell | Wann |
|-------|--------|------|
| requirements-engineer | haiku | Feature-Idee → Spec |
| solution-architect | **opus** | Spec → Architektur |
| python-dev | **opus** | Architektur → Code |
| qa-engineer | sonnet | Code → Tests |
| status-tracker | haiku | Nach Major-Agents |

**Auto-Status-Tracker nach jedem dieser Agents:**
1. ✅ Python Developer (nach Code)
2. ✅ QA Engineer (nach Tests)
3. ✅ Requirements Engineer (nach Spec)

Pattern: Agent arbeitet → STATUS.md updated automatisch → User sieht Fortschritt sofort.

## Modell-Konfiguration

Welches Claude-Modell jeder Agent nutzt ist zentral in `.claude/model-config.md` dokumentiert.
Modelle NIE direkt in den Agent-Dateien ändern — stattdessen:
1. `.claude/model-config.md` anpassen
2. `bash scripts/update-agent-models.sh` ausführen

## Token Budget Management

**KRITISCH:** Session-Kontext ist limitiert (200.000 Tokens pro Session).

### Monitoring (nach jedem Major-Agent-Aufruf)

Jede Tool-Nutzung zeigt:
```
<usage>
  total_tokens: XXXX
</usage>
```

**Berechnung:**
```
Verbleibend = 200.000 - total_tokens
Prozent = (Verbleibend / 200.000) * 100
```

### Thresholds & Actions

| Verbleibend | Aktion | Grund |
|------------|--------|-------|
| **>20%** | Weitermachen | Noch ausreichend Platz für nächsten Agent |
| **10-20%** | Status Tracker aufrufen | Fortschritt sichern, neue Session vorbereiten |
| **<10%** | STOPP + neue Session | Session endet bald, nächsten Step in frischer Session starten |

### WICHTIG: Proaktiver Status-Update

**Wenn Tokens kritisch werden (<15%):**
1. 🛑 Keinen neuen Major-Agent starten
2. 📝 SOFORT Status Tracker aufrufen: `status-tracker` → STATUS.md aktualisieren
3. ✅ Nach Status-Update: Session beenden
4. 🔄 Neue Session starten für nächsten Major-Agent

**Code-Pattern:**
```python
# Nach jedem Major-Agent-Aufruf:
if tokens_remaining < 15% * 200000:  # ~30.000 Tokens
    # → Status Tracker aufrufen
    # → Session beenden
    # → User: "Neue Session starten"
```

## Konventionen

- Feature Specs: `/features/PROJ-X-name.md`
- Python Code: `/src/`
- Tests: `/tests/` (pytest)
- Prompts: `/src/prompts/`
- API-Keys: `.env` (nie ins Git)
- Commit-Format: `type(PROJ-X): message`
