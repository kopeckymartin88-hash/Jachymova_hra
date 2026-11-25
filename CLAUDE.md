# Dráček – plošinovka (HTML5 canvas)

Celá hra je v jednom souboru `index.html` (bez závislostí). Hraje se na GitHub Pages:
https://kopeckymartin88-hash.github.io/Jachymova_hra/

## Číslo verze (důležité)
- Verze se zobrazuje v levém dolním rohu hry (konstanta `VERSION` v `index.html`).
- **S každým pushem se verze zvyšuje o 0.1** (0.0 → 0.1 → 0.2 …, po 0.9 následuje 0.10).
- Před každým commitem/pushem spusť `./bump-version.sh`, výsledek patří do stejného commitu jako změna hry.
- Neposouvej verzi při opakovaném pokusu o push téhož commitu (např. po chybě sítě) – zvyšuje se jen s novým commitem.

## Poznámky
- Vývojová větev: `claude/gracious-cannon-qnfziu`.
- Ovládání: šipky/WASD, skok ↑/W/Mezerník (2× = dvojskok), oheň Shift/F/X (jen s bonusem), P pauza, M zvuk.
