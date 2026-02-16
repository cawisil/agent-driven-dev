# Project Context

## Inhaltsverzeichnis

- [Projekt-Uebersicht](#projekt-uebersicht)
- [Ziele und Vision](#ziele-und-vision)
- [Ziel-Workflow (Produktsicht)](#ziel-workflow-produktsicht)

---

## Projekt-Uebersicht

**Name:** COREMat Framework
**Beschreibung:** Python-Framework fuer tabulare Daten. Ein Datensatz mit Features
wird eingelesen, ein Target definiert und es werden Vorhersagen mit unterschiedlichen
Modellarchitekturen sowie Auswertungen erzeugt.

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
