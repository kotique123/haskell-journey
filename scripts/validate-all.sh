#!/usr/bin/env bash
# validate-all.sh — verify every exercise's reference solution passes all tests
#
# Usage:
#   ./scripts/validate-all.sh              # validate all exercises
#   ./scripts/validate-all.sh 01 05 11     # validate specific exercises by number
#
# For each exercise, the script temporarily swaps Solution.hs in for Exercise.hs,
# runs `stack test`, then restores the original skeleton.

set -euo pipefail

BASE="$(cd "$(dirname "$0")/.." && pwd)/exercises"
PASS=0
FAIL=0
ERRORS=()

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

run_exercise() {
  local dir="$1"
  local name
  name="$(basename "$dir")"
  local skeleton="$dir/src/Exercise.hs"
  local solution="$dir/src/Solution.hs"
  local backup="$dir/src/Exercise.hs.bak"

  if [ ! -f "$solution" ]; then
    echo -e "  ${YELLOW}SKIP${NC}  $name  (no Solution.hs)"
    return
  fi

  # Swap in the solution
  cp "$skeleton" "$backup"
  cp "$solution" "$skeleton"

  # Run tests
  local output
  local exit_code=0
  output=$(cd "$dir" && stack test 2>&1) || exit_code=$?

  # Restore skeleton
  cp "$backup" "$skeleton"
  rm "$backup"

  # Parse results
  local summary
  summary=$(echo "$output" | grep "examples" | tail -1)

  if echo "$summary" | grep -q ", 0 failures"; then
    echo -e "  ${GREEN}PASS${NC}  $name  — $summary"
    PASS=$((PASS + 1))
  elif [ -n "$summary" ]; then
    echo -e "  ${RED}FAIL${NC}  $name  — $summary"
    FAIL=$((FAIL + 1))
    ERRORS+=("$name")
    # Show first compile error if any
    echo "$output" | grep -E "error:" | head -3 | sed 's/^/          /'
  else
    # Compile error — no test summary
    echo -e "  ${RED}ERR ${NC}  $name  — compile error"
    FAIL=$((FAIL + 1))
    ERRORS+=("$name")
    echo "$output" | grep -E "error:" | head -3 | sed 's/^/          /'
  fi
}

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Haskell Curriculum — Solution Validator"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $# -gt 0 ]; then
  # Validate specific exercises by number prefix
  for num in "$@"; do
    for dir in "$BASE"/${num}-*/; do
      [ -d "$dir" ] && run_exercise "$dir"
    done
  done
else
  # Validate all exercises in order
  for dir in "$BASE"/*/; do
    [ -d "$dir" ] && run_exercise "$dir"
  done
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Results: ${PASS} passed, ${FAIL} failed"
if [ ${#ERRORS[@]} -gt 0 ]; then
  echo " Failed:  ${ERRORS[*]}"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

[ $FAIL -eq 0 ]
