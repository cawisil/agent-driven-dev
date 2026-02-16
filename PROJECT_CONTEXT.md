# Project Context

## Inhaltsverzeichnis

- [Projekt-Uebersicht](#projekt-uebersicht)
- [Ziele und Vision](#ziele-und-vision)
- [Ziel-Workflow (Produktsicht)](#ziel-workflow-produktsicht)
- [Abgeschlossene Refactorings](#abgeschlossene-refactorings)
- [Bug-Status](#bug-status)
- [Next Steps: Best-Practice Foundation](#next-steps-best-practice-foundation)
- [Tech-Stack](#tech-stack)
- [Projektstruktur](#projektstruktur)
- [Aktuelle Features (fachlich)](#aktuelle-features-fachlich)
- [Bekannte Einschraenkungen / Tech Debt](#bekannte-einschraenkungen--tech-debt)
- [Definition of Done fuer Refactoring](#definition-of-done-fuer-refactoring)

---

## Projekt-Uebersicht

**Name:** COREMat Framework
**Beschreibung:** Python-Framework fuer tabulare Daten. Ein Datensatz mit Features
wird eingelesen, ein Target definiert und es werden Vorhersagen mit unterschiedlichen
Modellarchitekturen sowie Auswertungen erzeugt.
**Status:** Refactoring Complete, Best-Practice Foundation in Progress

---

## Ziele und Vision

- Eine stabile, nachvollziehbare und erweiterbare Framework-Basis fuer tabulares ML.
- Einheitlicher Workflow von Input-Daten bis Prediction + Evaluation.
- Klare Modulgrenzen (Config, Preprocessing, Training, Evaluation, Runtime/Entry Points).
- Refactoring ohne Funktionsverlust: bestehende Logik erhalten, Struktur verbessern.

---

## Ziel-Workflow (Produktsicht)

1. Tabularen Datensatz laden.
2. Feature-Spalten und Target-Spalte definieren.
3. Preprocessing reproduzierbar ausfuehren.
4. Mehrere Modellarchitekturen trainieren/aufrufen.
5. Predictions je Modell erzeugen.
6. Metriken und Vergleichsauswertung ausgeben.
7. Ergebnisse/Artefakte fuer spaetere Runs speichern.

---

## Abgeschlossene Refactorings

### PROJ-1: Config Unification

- **Ziel:** Divergenzen zwischen v1 (settings.py) und v2 (modulare Dataclasses) aufloesen
- **Ergebnis:** 11/11 Acceptance Criteria erfuellt
- **Tests:** 38 QA-Tests + 41 Regression-Tests bestanden
- **Impact:** Einheitliches `FrameworkConfig`-Objekt als Single Source of Truth
  fuer Pfade, Preprocessing, Training, Evaluation und Modellkonfiguration

### PROJ-2: ModelTrainer Split

- **Ziel:** Monolithische train.py (2353 Zeilen) in spezialisierte Module aufteilen
- **Ergebnis:** 8/8 Acceptance Criteria erfuellt
- **Code-Reduktion:** train.py 2353 -> 1189 Zeilen (-49.5%)
- **Neue Module:** transforms.py (217 Zeilen), shap_runner.py (710 Zeilen),
  feature_selector.py (228 Zeilen), reporting.py (430 Zeilen)
- **Architektur:** One-way Dependencies, Lazy-Imports fuer schwere Libraries

### PROJ-3: Quick Wins

- **Ziel:** 9 Cleanup-Aufgaben (Duplikate, Typos, Dead Code, Side-Effects)
- **Ergebnis:** 9/9 Aufgaben abgeschlossen
- **Impact:** Sauberere Codebasis ohne funktionale Aenderungen

**Test-Status nach Phase 1:** 83/83 Tests PASSING

---

## Bug-Status

3 pre-existing Bugs wurden in Session 6 dokumentiert und behoben:

| Bug | Modul | Severity | Status |
|-----|-------|----------|--------|
| BUG-B5 | trainlab/train.py | Medium | FIXED |
| BUG-B6 | preplab/custom_preprocessor.py | High | FIXED |
| BUG-B7 | config/models.py | Medium | FIXED |

Details: `.claude/bugs/README.md`

---

## Next Steps: Best-Practice Foundation

7 weitere Features sind spezifiziert und bereit zur Implementierung:

| PROJ | Feature | Status |
|------|---------|--------|
| PROJ-4 | Documentation Update | COMPLETE |
| PROJ-5 | Module Reorganization | COMPLETE |
| PROJ-6 | Type Safety | Planned |
| PROJ-7 | CI/CD Infrastructure | Planned |
| PROJ-8 | Public API Exports | Planned |
| PROJ-9 | Config Orchestration | Planned |
| PROJ-10 | Unified CLI | Planned |

Details: [features/ROADMAP.md](./features/ROADMAP.md)

---

## Tech-Stack

- **Sprache:** Python 3.8+
- **Domaene:** Tabulares Machine Learning
- **Core ML:** scikit-learn, CatBoost, XGBoost, LightGBM, TabPFN (optional)
- **Explainability:** SHAP, shapiq
- **HPO:** Optuna
- **Neural:** PyTorch, skorch (optional)
- **Visualisierung:** matplotlib, seaborn
- **Tests:** pytest (123 Tests)
- **Konfiguration:** Dataclass-basiert (FrameworkConfig)

---

## Projektstruktur

```text
coremat-framework/
  src/
    main.py                  # Training Pipeline Entry Point
    main_eval.py             # Re-Evaluation Entry Point
    main_test.py             # Inference Entry Point
    coremat/
      core/                  # Zentrale Definitionen (PROJ-5)
        constants.py         #   MISSING_TOKEN, DEFAULT_RANDOM_STATE, etc.
        types/               #   ScalerKind, PreprocessPolicy, FeatSelectionScore
        config/              #   FrameworkConfig, PathsConfig, TrainConfig, etc.
      config/                # Backward-Compat Shim (-> core/config/)
      preplab/               # Preprocessing (10 Dateien, ~2912 Zeilen)
      trainlab/              # Training (21 Dateien, ~6750 Zeilen)
        registry.py          #   ModelSpec, register(), get_model_spec()
        models/              #   Model Zoo (40+ Modelle)
      evallab/               # Evaluation (11 Dateien, ~2250 Zeilen)
        reports/             #   Umbrella fuer outlier_report + prediction_report
      shared/                # Utilities (4 Dateien, ~695 Zeilen)
      runtime/               # Entry-Point-Wrapper (PROJ-5)
        train_runner.py      #   run_training(fw)
        eval_runner.py       #   run_evaluation(fw)
  tests/                     # pytest Test-Suite (123 Tests)
  docs/                      # Dokumentation
  features/                  # Feature-Spezifikationen + Roadmap
```

---

## Aktuelle Features (fachlich)

| Feature | Status | Beschreibung |
|---------|--------|-------------|
| Tabular Input -> Prediction | Done | End-to-end Workflow vorhanden und stabil |
| Multi-Model Support | Done | 40+ Modelle ueber einheitliches Registry-System |
| Evaluation und Vergleich | Done | Metriken, Plots, Outlier Reports |
| Preprocessing Pipeline | Done | Konfigurierbar pro Modell via PreprocessPolicy |
| Config System | Done | Unified FrameworkConfig (PROJ-1) |
| Feature Selection | Done | Iteratives Feature-Dropping |
| SHAP Explainability | Done | TreeSHAP, GroupSHAP, Interaction Values |

---

## Bekannte Einschraenkungen / Tech Debt

- Config wird aktuell als Python-Datei definiert (kein YAML/JSON-Support -- geplant in PROJ-9)
- Keine formale Public API mit `__init__.py`-Exports auf Package-Ebene (geplant in PROJ-8)
- Type Hints nicht durchgaengig vorhanden (geplant in PROJ-6)
- Keine CI/CD-Pipeline (geplant in PROJ-7)
- Entry Points sind separate main-Dateien statt CLI-Commands (geplant in PROJ-10)

---

## Definition of Done fuer Refactoring

- Modulgrenzen klar und dokumentiert.
- Importstruktur konsistent.
- Kernworkflow (Input -> Target -> Prediction -> Evaluation) laeuft.
- Keine Regression in bestehenden Kernfunktionen.
- Dokumentation (README, Context, Architecture) auf aktuellem Stand.
