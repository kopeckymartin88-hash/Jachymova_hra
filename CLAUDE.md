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

## Levely (21 celkem)
- **Level 1** je ručně postavený (`buildLevel1`), **levely 2–20** generuje `genLevel(n)` z pevného semínka podle obtížnosti
  (délka 150–240 dlaždic, víc děr, rour, nepřátel i rychlejších směrem k levelu 20; Pankáč od levelu 3).
- **Level 21** je hradní aréna s bossem Mimoněm (`buildBoss`, vlastnosti bosse v konstantě `BOSS` – zatím zástupné hodnoty).
- Každý level má vlastní motiv prostředí v poli `THEMES` (barvy, pozadí, počasí, vzhled dlaždic i děr).
- Hra se neukládá. Po konci hry začíná hráč znovu od levelu 1. Životy se dají získat srdíčky 1UP a každými 50 mincemi (max. 9).
- Pro zkoušení lze hru spustit od libovolného levelu: `index.html?level=12`.
