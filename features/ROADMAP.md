# PROJ-4 bis PROJ-10: Implementierungs-Roadmap

**Status:** Alle Spezifikationen geschrieben und committed (7x✓)

---

## Übersicht

Nach den erfolgreichen Refactorings PROJ-1, PROJ-2, PROJ-3 (83/83 Tests bestanden) folgen jetzt 7 weitere Features für eine Production-ready Architektur:

| PROJ | Name | Size | AC | Dependencies | Est. Time |
|------|------|------|----|----|-----------|
| 4 | Documentation Update | 5.9 KB | 6 | — | 2-3h |
| 5 | Module Reorganization | 6.8 KB | 8 | ← PROJ-4 | 4-5h |
| 6 | Type Safety | 5.4 KB | 8 | ← PROJ-5 | 3-4h |
| 7 | CI/CD Infrastructure | 5.6 KB | 8 | ← PROJ-6 | 3-4h |
| 8 | Public API Exports | 5.4 KB | 8 | ← PROJ-5,6 | 2-3h |
| 9 | Config Orchestration | 6.1 KB | 8 | ← PROJ-5 | 3-4h |
| 10 | Unified CLI | 6.3 KB | 8 | ← PROJ-8,9 | 3-4h |
| **Total** | **7 Features** | **40.4 KB** | **54 AC** | **Linear** | **~24-28h** |

---

## Rekommandierte Implementierungs-Reihenfolge

### Phase 1: Foundation (PROJ-4)
**Ziel:** Dokumentationsgrundlage etablieren
- Schreibe COREMAT_README.md (Quick Start + Übersicht)
- Aktualisiere PROJECT_CONTEXT.md (Status: REFACTORING COMPLETE)
- Schreibe docs/ARCHITECTURE.md (Module, Dependencies)
- Schreibe docs/API_GUIDE.md (Entry Points, Examples)
- Schreibe test_documentation_consistency.py

**Dauer:** 2-3h | **Tests:** 5+ neue Tests sollten bestehen

---

### Phase 2: Architecture (PROJ-5)
**Ziel:** Modulstruktur reorganisieren
- Erstelle src/coremat/core/ Struktur
- Erstelle src/coremat/core/constants.py (zentralisierte Konstanten)
- Erstelle src/coremat/core/types/ (Typ-Definitionen)
- Verschiebe config/ → core/config/
- Verschiebe models/registry.py → trainlab/registry.py
- Erstelle evallab/reports/ (unified reporting)
- Erstelle runtime/ (train_runner, eval_runner)
- Update alle Imports (nur relative in src/, absolute in tests/)

**Dauer:** 4-5h | **Tests:** Alle 79 Regression-Tests müssen bestehen

---

### Phase 3: Code Quality (PROJ-6)
**Ziel:** Type Safety und Dokumentation
- Füge Type Hints zu allen public Methoden hinzu (mypy --strict)
- Schreibe Google-Style Docstrings für alle public APIs
- Definiere core/types/ Dataclasses (ConfigDict, TrainResult, EvalResult)
- Füge __all__ zu jedem Modul hinzu
- Schreibe test_type_hints.py + test_docstrings.py

**Dauer:** 3-4h | **Tests:** mypy laufen, 80+ Tests bestehen

---

### Phase 4: Infrastructure (PROJ-7)
**Ziel:** CI/CD und Code-Qualität automatisieren
- Aktualisiere pyproject.toml mit [tool.*] sections
- Erstelle .pre-commit-config.yaml (black, ruff, mypy, pytest hooks)
- Erstelle .github/workflows/ci.yml (Test-Matrix, Coverage)
- Schreibe docs/DEVELOPMENT.md (Local setup)
- Schreibe CONTRIBUTING.md (Contributor guidelines)

**Dauer:** 3-4h | **Tests:** CI-Pipeline grün, Coverage 80%+

---

### Phase 5: Public API & Config (PROJ-8 + PROJ-9) — Optional parallel
**Ziel:** API-Exports und Config-Management

#### PROJ-8 (Public API)
- Schreibe src/coremat/__init__.py (Exports, __version__)
- Schreibe docs/PUBLIC_API.md (mit 5+ Use Cases)
- Aktualisiere pyproject.toml [project.scripts] für Entry Points
- Schreibe test_public_api.py

**Dauer:** 2-3h

#### PROJ-9 (Config Orchestration)
- Schreibe config/loader.py (load_config mit validation)
- Erstelle config/{defaults,dev,test,prod}.yaml
- Schreibe .env.example
- Update main.py, main_eval.py zum neuen Loader
- Schreibe test_config_loader.py

**Dauer:** 3-4h

---

### Phase 6: CLI (PROJ-10)
**Ziel:** Unified Click-basierte CLI
- Refactor main.py logic als function (trainieren-funktion)
- Schreibe src/coremat/cli.py mit 4 Commands: train, eval, test, config
- Schreibe docs/CLI_GUIDE.md (mit Beispiele)
- Schreibe tests/test_cli.py (mit CliRunner)
- Füge Deprecation Warnings zu old main.py, main_eval.py, main_test.py hinzu

**Dauer:** 3-4h | **Tests:** 5+ CLI-Tests + Backward-Compat-Tests

---

## Estimated Timeline

```
Week 1:
  Mon: PROJ-4 (Documentation) — 2-3h
  Tue: PROJ-5 (Module Reorganization) — 4-5h
  Wed: PROJ-6 (Type Safety) — 3-4h
  Thu: PROJ-7 (CI/CD) — 3-4h
  Fri: Testing + Buffer

Week 2:
  Mon: PROJ-8 (Public API) — 2-3h
  Tue: PROJ-9 (Config) — 3-4h
  Wed: PROJ-10 (CLI) — 3-4h
  Thu: Integration Testing + Documentation
  Fri: Buffer + Reviews
```

**Total:** 24-28h work = ~4-5 full Development Sessions

---

## Critical Path

```
PROJ-4 (Documentation)
  ↓ DEPENDS ON
PROJ-5 (Module Reorganization)
  ↓ DEPENDS ON
PROJ-6 (Type Safety)
  ↓ DEPENDS ON
PROJ-7 (CI/CD) ← can be parallel with PROJ-8/PROJ-9
  ↓ DEPENDS ON
PROJ-10 (Unified CLI)
```

**Minimum Sequence:** PROJ-4 → PROJ-5 → PROJ-6 → PROJ-7 → PROJ-10
**Optimization:** PROJ-8 + PROJ-9 können parallel mit PROJ-6/PROJ-7 laufen

---

## File Locations

```
/work/cawi/coremat-framework/features/
├── PROJ-4-documentation-update.md        [SPEC DONE]
├── PROJ-5-module-reorganization.md       [SPEC DONE]
├── PROJ-6-type-safety.md                 [SPEC DONE]
├── PROJ-7-ci-cd-infrastructure.md        [SPEC DONE]
├── PROJ-8-public-api-exports.md          [SPEC DONE]
├── PROJ-9-config-orchestration.md        [SPEC DONE]
├── PROJ-10-unified-cli.md                [SPEC DONE]
└── ROADMAP.md                            [THIS FILE]
```

---

## Success Criteria (Definition of Done)

Each PROJ is done when:
- [ ] All Acceptance Criteria (AC) fulfilled
- [ ] All pytest tests pass (79+ existing + new AC tests)
- [ ] Code follows conventions from PROJ-1, PROJ-2, PROJ-3
- [ ] Documentation updated (README, docs/*, code comments)
- [ ] Git commit with `feat(PROJ-X): ...` message
- [ ] STATUS.md updated by status-tracker agent
- [ ] No regressions in existing functionality

---

## Next Steps

1. **Solution Architect** (Next Session):
   - Read all 7 specs (PROJ-4 to PROJ-10)
   - Create tech-design documents
   - Identify risks/blockers
   - Propose final timeline

2. **Python Developer** (After SA approval):
   - Start with PROJ-4 (Documentation)
   - Follow Critical Path
   - Ensure AC satisfaction
   - Write tests for each AC

3. **QA Engineer** (After Dev implementation):
   - Verify AC satisfaction
   - Write regression tests
   - Report bugs if found

4. **Status Tracker** (After each PROJ):
   - Update STATUS.md
   - Log progress

---

## Notes

- All specs are written in **Deutsch + English code examples**
- All AC are **pytest-testable**
- All dependencies are **cross-referenced**
- Each PROJ has **single responsibility** (no mixing concerns)
- All PROJs build on **PROJ-1, PROJ-2, PROJ-3 success** (83/83 tests)

**Ready to go!** 🚀
