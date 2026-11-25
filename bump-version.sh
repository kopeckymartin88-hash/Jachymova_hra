#!/usr/bin/env bash
# Zvýší číslo verze hry v index.html o 0.1  (0.0 -> 0.1 -> 0.2 -> ... -> 0.10 -> 0.11).
# Spusť před každým pushem:  ./bump-version.sh
# Volitelně lze zadat jiný soubor:  ./bump-version.sh cesta/k/index.html
set -euo pipefail
f="${1:-$(dirname "$0")/index.html}"
cur=$(grep -oE "const VERSION = '[0-9]+\.[0-9]+'" "$f" | grep -oE "[0-9]+\.[0-9]+")
major=${cur%%.*}
minor=${cur##*.}
new="$major.$((minor + 1))"
sed -i "s/const VERSION = '$cur'/const VERSION = '$new'/" "$f"
echo "verze: $cur -> $new"
