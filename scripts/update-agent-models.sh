#!/usr/bin/env bash
# update-agent-models.sh
# Setzt das model-Feld im Frontmatter jeder Agent-Datei.
# Modell-Zuweisung hier pflegen — muss mit .claude/model-config.md übereinstimmen.
#
# Verwendung:
#   bash scripts/update-agent-models.sh            # Änderungen anwenden
#   bash scripts/update-agent-models.sh --dry-run  # Nur anzeigen, was sich ändert

set -e

AGENTS_DIR=".claude/agents"
DRY_RUN=false
[[ "${1}" == "--dry-run" ]] && DRY_RUN=true

# ─── Modell-Zuweisung (hier anpassen wenn neue Modelle kommen) ───────────────
declare -A MODEL_MAP=(
  ["requirements-engineer"]="haiku"
  ["solution-architect"]="sonnet"      # Downgrade: opus → sonnet (PROJ-5 validated)
  ["python-dev"]="sonnet"              # Downgrade: opus → sonnet (Code impl. proven)
  ["qa-engineer"]="sonnet"
  ["prompt-engineer"]="sonnet"
  ["status-tracker"]="haiku"
  ["ml-expert"]="sonnet"               # Downgrade: opus → sonnet (or remove if unused)
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
$DRY_RUN && echo "(DRY RUN — keine Änderungen)"
echo ""

for agent_name in "${!MODEL_MAP[@]}"; do
  file="${AGENTS_DIR}/${agent_name}.md"
  model="${MODEL_MAP[$agent_name]}"

  if [[ ! -f "$file" ]]; then
    echo "⚠  Skipped: $file (nicht gefunden)"
    continue
  fi

  current=$(grep "^model:" "$file" 2>/dev/null | awk '{print $2}' || echo "—")

  if [[ "$current" == "$model" ]]; then
    echo "✓  ${agent_name}: ${model} (unverändert)"
    continue
  fi

  echo "→  ${agent_name}: ${current} → ${model}"

  if ! $DRY_RUN; then
    $PYTHON - "$file" "$model" << 'PYEOF'
import re, sys
filepath, model = sys.argv[1], sys.argv[2]
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()
if re.search(r'^model:.*$', content, re.MULTILINE):
    content = re.sub(r'^model:.*$', f'model: {model}', content, flags=re.MULTILINE)
else:
    content = re.sub(r'(^agent:.*$)', rf'\1\nmodel: {model}', content, count=1, flags=re.MULTILINE)
with open(filepath, 'w', encoding='utf-8') as f:
    f.write(content)
PYEOF
  fi
done

echo ""
echo "=== Aktueller Stand ==="
grep "^model:" "${AGENTS_DIR}"/*.md | sed "s|${AGENTS_DIR}/||;s|\.md:model:| →|"
