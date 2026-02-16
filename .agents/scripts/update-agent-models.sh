#!/usr/bin/env bash
# update-agent-models.sh
# Setzt das model-Feld im Frontmatter jeder Agent-Datei.
# Modell-Zuweisung hier pflegen — muss mit .agents/config/model-config.md übereinstimmen.
#
# Verwendung:
#   bash scripts/update-agent-models.sh            # Änderungen anwenden
#   bash scripts/update-agent-models.sh --dry-run  # Nur anzeigen, was sich ändert

set -e

AGENTS_DIR=".agents/agents"
DRY_RUN=false
APPLY=false
if [[ "${1}" == "--dry-run" ]]; then
  DRY_RUN=true
elif [[ "${1}" == "--apply" ]]; then
  APPLY=true
fi

# ─── Modell-Zuweisung (hier anpassen wenn neue Modelle kommen) ───────────────
declare -A MODEL_MAP=(
  ["requirements-engineer"]="haiku"
  ["solution-architect"]="sonnet"
  ["python-developer"]="sonnet"
  ["qa-engineer"]="sonnet"
  ["prompt-engineer"]="sonnet"
  ["status-tracker"]="haiku"
  ["ml-expert"]="sonnet"
)
# ─────────────────────────────────────────────────────────────────────────────

# Python-Interpreter ermitteln (Windows: python, Unix: python3)
PYTHON=""
for cmd in python3 python py; do
  if command -v "$cmd" &>/dev/null; then
    PYTHON="$cmd"
    break
  fi
done

if [[ -z "$PYTHON" ]]; then
  echo "❌ Python nicht gefunden. Bitte Python installieren."
  exit 1
fi

echo "=== Agent Model Update (Python: $PYTHON) ==="
if $DRY_RUN; then
  echo "(DRY RUN — no changes will be written)"
elif $APPLY; then
  echo "(APPLY — changes will be written)"
else
  echo "Usage: $0 [--dry-run|--apply]"
  exit 0
fi

for agent_name in "${!MODEL_MAP[@]}"; do
  file="${AGENTS_DIR}/agent-${agent_name}.md"
  model="${MODEL_MAP[$agent_name]}"

  if [[ ! -f "$file" ]]; then
    echo "⚠  Skipped: $file (not found)"
    continue
  fi

  current=$(grep "^model: " "$file" 2>/dev/null | sed -E 's/^model: *//' || echo "—")

  if [[ "$current" == "$model" ]]; then
    echo "✓  ${agent_name}: ${model} (unchanged)"
    continue
  fi

  echo "→  ${agent_name}: ${current} → ${model}"

  if $APPLY; then
    $PYTHON - "$file" "$model" << 'PYEOF'
import re, sys
filepath, model = sys.argv[1], sys.argv[2]
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()
if re.search(r'^model:.*$', content, re.MULTILINE):
    content = re.sub(r'^model:.*$', f'model: {model}', content, flags=re.MULTILINE)
else:
    content = re.sub(r'(^---\n)', rf'\1model: {model}\n', content, count=1, flags=re.MULTILINE)
with open(filepath, 'w', encoding='utf-8') as f:
    f.write(content)
PYEOF
  fi
done

echo ""
echo "=== Current model entries ==="
grep -h "^model:" "${AGENTS_DIR}"/agent-*.md || true
