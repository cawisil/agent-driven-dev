# AI Workflow Starter Kit

Ein Claude Code Starter Kit für lokale Python-basierte AI-Workflow-Entwicklung.

## Was ist das?

Dieses Repo enthält einen strukturierten Entwicklungs-Workflow mit spezialisierten Claude Code Agenten für Python AI-Projekte. Die Agenten decken den gesamten Entwicklungsprozess ab — von der Feature-Spec bis zu Prompt-Optimierung und Tests.

## Agenten

| Agent | Wann nutzen |
|-------|-------------|
| **Requirements Engineer** | Neue Feature-Idee → strukturierte Spec |
| **Solution Architect** | Feature-Spec → Architektur-Design |
| **Python Developer** | Architektur-Design → Python-Code |
| **QA Engineer** | Implementierung → pytest Tests + Bug-Report |
| **Prompt Engineer** | LLM-Prompts entwickeln und optimieren |
| **Status Tracker** | Entwicklungsstand loggen → STATUS.md aktualisieren |

## Agenten verwenden

Agenten werden durch direkte Anweisung an Claude aktiviert:

```
Lies .claude/agents/requirements-engineer.md und erstelle eine Feature Spec für [deine Idee]
```

Oder kürzer — Claude erkennt die Agenten automatisch anhand ihrer Beschreibung:

```
Erstelle eine Feature Spec für einen Document-Parser der PDFs zu Markdown konvertiert
```

## Workflow

```
Feature-Idee
    → Requirements Engineer → /features/PROJ-X.md
    → Solution Architect   → Architektur-Design in PROJ-X.md
    → Python Developer     → src/ Code + tests/
    → QA Engineer          → Test-Report in PROJ-X.md
    → (optional) Prompt Engineer → src/prompts/ optimierte Prompts
```

## Projekt einrichten

```bash
# Virtuelle Umgebung
python -m venv .venv
source .venv/bin/activate   # Linux/Mac
.venv\Scripts\activate      # Windows

# .env Datei anlegen
cp .env.example .env
# → .env öffnen und API-Keys eintragen

# Dependencies (nach erster Implementierung)
pip install -r requirements.txt
```

## Projektkontext anpassen

Öffne PROJECT_CONTEXT.md und trage dein Projekt ein:
- Was baut dieses Projekt?
- Welchen Tech-Stack verwendest du?
- Welche Features sind geplant?

Claude nutzt diese Datei automatisch als Kontext.

## Session-Kontext & Status

`CLAUDE.md` wird von Claude Code **automatisch bei jeder Session geladen** und weist Claude an, `STATUS.md` zu lesen. Damit kennt Claude den aktuellen Entwicklungsstand ohne manuelle Einleitung.

**Status aktualisieren** — nach einem Feature-Abschluss, einer Pause oder vollem Kontextfenster:

```
Lies .claude/agents/status-tracker.md und aktualisiere STATUS.md
```

Der Status Tracker liest alle Feature-Specs, die Git-History und offene Änderungen und schreibt einen kompakten Snapshot inkl. eines fertigen Quick-Start-Prompts für die nächste Session.

## Features tracken

Alle Feature-Specs liegen in `/features/PROJ-X-name.md`.

```bash
ls features/          # Alle Features anzeigen
git log --oneline     # Entwicklungshistorie
cat STATUS.md         # Aktueller Projektstatus
```
