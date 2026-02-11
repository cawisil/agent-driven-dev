# Agent Model Configuration

> **Einzige Stelle für Modell-Zuweisung.**
> Nach Änderungen hier: `bash scripts/update-agent-models.sh` ausführen.

## Aktuelle Zuweisung

| Agent | Modell | Begründung |
|-------|--------|-----------|
| requirements-engineer | `haiku` | Konversation + strukturierter Output — kein tiefes Reasoning nötig, schnell und günstig |
| solution-architect | `opus` | Architektur-Entscheidungen + Abwägungen brauchen gutes Reasoning |
| python-dev | `opus` | Coding-Qualität wichtiger als Geschwindigkeit; gutes Kontextfenster für große Codebasen |
| qa-engineer | `sonnet` | Code verstehen + Tests schreiben + Bugs analysieren |
| prompt-engineer | `sonnet` | Nuanciertes Sprachverständnis, Prompt-Qualität hängt stark vom Modell ab |
| status-tracker | `haiku` | Nur lesen + zusammenfassen — maximale Geschwindigkeit, minimale Kosten |

## Verfügbare Claude-Modelle

```
haiku   → claude-haiku-4-5-20251001   (schnell, günstig, gut für einfache Tasks)
sonnet  → claude-sonnet-4-5-20250929  (ausgewogen, Coding-Stärke, Standard-Wahl)
opus    → claude-opus-4-6             (stärkstes Modell, teuer — für hochkomplexe Aufgaben)
```

## Wann auf `opus` upgraden?

Temporär für einen Agenten auf `opus` wechseln wenn:
- Sehr komplexe Architektur-Entscheidungen (solution-architect)
- Große, verworrene Codebase wird refactored (python-dev)
- Debugging eines schwer zu findenden Bugs (qa-engineer)

Danach wieder zurück auf `sonnet` um Kosten zu sparen.

## Andere LLMs

Claude Code Agenten unterstützen ausschließlich Claude-Modelle im `model`-Feld.
Für andere LLMs (Gemini, GPT-4, Ollama) gilt:
- **Nicht** als Claude Code Agent konfigurierbar
- **Aber** nutzbar im Python-Code selbst (via `google-generativeai`, `openai`, `ollama` Libraries)
- Einsatzempfehlungen für Python-Code:

| LLM | Stärken | Einsetzen für |
|-----|---------|---------------|
| Claude Sonnet/Opus | Coding, Reasoning, Instruktionen | Hauptmodell für AI-Workflows |
| Gemini 2.0 Flash | Schnell, multimodal, langes Context-Fenster (1M Token) | Dokument-Analyse, große Dateien |
| GPT-4o | Gute Allround-Performance | Fallback oder A/B-Tests |
| Ollama (lokal) | Privacy, keine API-Kosten | Sensible Daten, Offline-Betrieb |

## Update-Prozess

Wenn neue Modelle erscheinen:
1. Tabelle oben aktualisieren
2. "Verfügbare Modelle" Sektion ergänzen
3. Script ausführen: `bash scripts/update-agent-models.sh`
4. Testen: `cat .claude/agents/*.md | grep "^model:"`
