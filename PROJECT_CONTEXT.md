# Project Context

<!-- Fülle dieses Dokument mit deinen projektspezifischen Informationen aus.
     Claude liest diese Datei automatisch und nutzt den Kontext für bessere Antworten. -->

## Projekt-Übersicht

**Name:** [Dein Projektname]
**Beschreibung:** [Was baut dieses Projekt? Was ist das Ziel?]
**Status:** In Entwicklung

## Ziele & Vision

[Was willst du mit diesem AI-Workflow erreichen?]

Beispiele:
- Automatische Zusammenfassung von Research-Papieren
- Lokaler AI-Assistent für Dokument-Analyse
- Pipeline zur Datenextraktion und -anreicherung

## Tech-Stack

- **Sprache:** Python 3.12+
- **LLM:** [z.B. Claude (Anthropic API) / Ollama lokal / Gemini]
- **Key Libraries:** [z.B. anthropic, langchain, pandas, etc.]
- **Datenspeicherung:** [z.B. SQLite / JSON-Files / Chroma Vektordatenbank]

## Projektstruktur

```
project/
├── .claude/agents/          # AI-Agenten für den Entwicklungs-Workflow
├── features/                # Feature Specifications (PROJ-X.md)
├── src/                     # Python-Quellcode
│   └── [module]/
├── tests/                   # pytest Tests
├── .env                     # Lokale API-Keys (NICHT ins Git!)
├── .env.example             # Template für API-Keys
└── requirements.txt         # Python-Dependencies
```

## Aktuelle Features

| Feature | Status | Beschreibung |
|---------|--------|-------------|
| -       | 🔵 Planned | - |

### Status-Legende
- 🔵 Planned — Spec geschrieben, noch nicht started
- 🟡 In Progress — In Entwicklung
- 🟢 Done — Implementiert und getestet
- ❌ Blocked — Blockiert durch Dependency

## Bekannte Einschränkungen / Tech-Schulden

[Dokumentiere hier bekannte Probleme oder temporäre Lösungen]

## Nützliche Befehle

```bash
# Virtuelle Umgebung
python -m venv .venv
source .venv/bin/activate  # Linux/Mac
.venv\Scripts\activate     # Windows

# Dependencies installieren
pip install -r requirements.txt

# Tests ausführen
pytest tests/ -v
pytest tests/ -v -m "not integration"  # Ohne echte API-Calls

# Ollama (lokale Modelle)
ollama serve                 # Server starten
ollama pull llama3.2         # Modell herunterladen
ollama list                  # Verfügbare Modelle
```

## API-Keys & Konfiguration

Benötigte Environment Variables (in `.env`):

```bash
# Anthropic Claude API
ANTHROPIC_API_KEY=sk-ant-...

# Optional: Weitere Services
OPENAI_API_KEY=sk-...
OLLAMA_BASE_URL=http://localhost:11434
```
