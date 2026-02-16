# Agent Workflow — Complete Flow

## 🔄 Standard Feature Development Flow

```
User Input (Feature Idea)
    ↓
🤖 Requirements Engineer (haiku)
   ├─ Versteht Feature-Ziel + Edge Cases
   └─ Commits: features/PROJ-X.md
    ↓ AUTO: 📊 Status-Tracker updated STATUS.md
    ↓
🤖 Solution Architect (opus)
   ├─ Liest Feature Spec
   ├─ Entwirft Modul-Struktur + Datenfluss
   └─ Commits: design(PROJ-X): ...
    ↓ (OPTIONAL bei ML-Features)
🤖 ML Expert (opus)             ← Fachliche Bewertung des Designs
   ├─ Liest Tech-Design in Spec
   ├─ Bewertet Modellwahl, Transformationen, Metriken
   └─ Commits: review(PROJ-X): ...
    ↓
🤖 Python Developer (opus)
   ├─ Implementiert nach Tech-Design + ML Review
   └─ Commits: feat(PROJ-X): ...
    ↓ AUTO: 📊 Status-Tracker updated STATUS.md
    ↓ (OPTIONAL bei ML-Features)
🤖 ML Expert (opus)             ← Review der Implementierung
   ├─ Prüft tatsächliche Transformationen + Preprocessing im Code
   └─ Commits: review(PROJ-X): ...
    ↓
🤖 QA Engineer (sonnet)
   ├─ Schreibt pytest Tests (alle Acceptance Criteria)
   ├─ Findet + documented Bugs
   └─ Commits: test(PROJ-X): ... + fix(BUG-X): ...
    ↓ AUTO: 📊 Status-Tracker updated STATUS.md
    ↓
✅ FEATURE COMPLETE
```

---

## 🤖 Agent Übersicht

| Agent | Model | Rolle | Wann |
|-------|-------|-------|------|
| requirements-engineer | **haiku** | Feature Idea → Spec | Anfang |
| solution-architect | **opus** | Spec → Architektur | Nach Requirements |
| **ml-expert** | **opus** | ML-Annahmen, Modellwahl, Transformationen prüfen | Nach SA oder nach Dev |
| python-dev | **opus** | Architektur → Code | Nach SA + ML Review |
| qa-engineer | **sonnet** | Code → Tests + Bugs | Nach Dev |
| status-tracker | **haiku** | STATUS.md updaten | Auto nach Major-Agents |

---

## 🧠 ML Expert — Einsatz-Guide

Der ML Expert braucht **kein volles Code-Verständnis**. Er bekommt Kontext durch:

1. **Feature Spec** (`/features/PROJ-X.md`) → enthält Tech-Design des Solution Architects
2. **Gezielter Code-Blick** → nur relevante Methoden (z.B. `_init_transforms`, `train_outer_cv`)

**Zwei Einsatz-Punkte:**

| Zeitpunkt | Was er prüft | Nutzen |
|-----------|-------------|--------|
| **Nach Solution Architect** (Pre-Dev) | ML-Design-Entscheidungen | Verhindert falsche Implementierungen |
| **Nach Python Developer** (Post-Dev) | Tatsächliche Implementierung | Findet Leakage, falsche Transforms |

**Typische Fragen des ML Experts:**
- Ist die Target-Transformation (log, log1p, Box-Cox) für die Datenverteilung korrekt?
- Wird der Scaler korrekt nur auf Train-Daten gefittet (kein Leakage)?
- Ist SHAP-basiertes Feature Dropping methodisch valide?
- Sind die Evaluations-Metriken für das Business-Ziel geeignet?
- Gibt es Data Leakage-Risiken im Preprocessing?

---

## ⚡ Auto-Status-Tracker Rule

**Automatisch status-tracker aufrufen nach:**

1. ✅ **Requirements Engineer** — neue Spec erstellt
2. ✅ **Python Developer** — nach Code-Implementierung
3. ✅ **QA Engineer** — nach Tests + Bug-Fixes

**Manuell (wenn sinnvoll):**
- Solution Architect (nach komplexem Design)
- ML Expert (nach Review)

---

## 📋 Agent Output Format

**BEFORE Agent startet:**
```
🤖 Agent: {name} ({model})
📋 Task: {Kurzbeschreibung}
⏱️ Estimated: {Zeit-Schätzung}
```

**AFTER Agent fertig:**
```
✅ Agent: {name} complete
📊 Deliverable: {Was wurde erstellt/geändert}
📂 Files: {Liste der geänderten Dateien}
👉 Next: {Wer arbeitet jetzt?}
```

---

## 💰 Modell-Kosten Faustregel

| Budget | Nutzung |
|--------|---------|
| **opus** | Architektur, Code, ML-Review (komplex, reasoning-intensiv) |
| **sonnet** | Testing, Prompting (ausgewogen) |
| **haiku** | Status-Updates, Requirements (schnell + günstig) |
