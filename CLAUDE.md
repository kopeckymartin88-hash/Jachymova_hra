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
- Ovládání: šipky/WASD, skok ↑/W/Mezerník (2× = dvojskok), oheň Shift/F/X (s bonusem nebo koupený v obchodě), B obchod, P/Esc pauza, **M zvuky**, **H hudba**; podporován i **gamepad** (`pollGamepad`: A skok, X/B oheň, Start pauza, Y obchod).
- Plátno se kreslí v rozlišení displeje (`fitCanvas`, `RS` max. 2×); když zařízení nestíhá (< 45 fps), kvalita se sníží. Kresli vždy v logických souřadnicích 800×480.
- Telefon na výšku ukáže výzvu k otočení (`#rotate`) a hru zapauzuje. Na iOS se zvuk odemyká v `unlockAudio`.
- Na tabletu/telefonu se zapne dotykové ovládání (HTML tlačítka `#touch` + tlačítka nakreslená na plátně `drawTouchButtons`); klepnutí na plátno = Enter v menu.

## Levely (21 celkem)
- **Level 1** je ručně postavený (`buildLevel1`), **levely 2–20** generuje `genLevel(n)` z pevného semínka podle obtížnosti
  (délka 150–240 dlaždic, víc děr, rour, nepřátel i rychlejších směrem k levelu 20; Pankáč od levelu 3).
- **Level 21** je hradní aréna s bossem Mimoněm (`buildBoss`, vlastnosti bosse v konstantě `BOSS` – zatím zástupné hodnoty).
- Každý level má vlastní motiv prostředí v poli `THEMES` (barvy, pozadí, počasí, vzhled dlaždic i děr).
- Hra se neukládá. Po konci hry pokračuje hráč **v levelu, kde zemřel** (3 životy, **skóre i body k utracení se vynulují**, nákupy zůstávají); po výhře nad bossem začíná nová hra (vše se nuluje). Životy se dají získat srdíčky 1UP a každými 50 mincemi (max. 9).
- Pro zkoušení lze hru spustit od libovolného levelu: `index.html?level=12`.
- Překážky, které vypadají jako **záchody** (dlaždice `T`, 2 široké, 1–3 vysoké), nahradily původní roury. Víko a sedátko mají barvu motivu.
- Boss Mimoň **háže banány** (`throwBanana`, `updateBananas`): letí obloukem k hráči, dá se jim uhnout nebo je sestřelit ohněm; ve zuřivé fázi hází dva naráz.
  Frekvenci hodů nastavují `BOSS.banana` / `BOSS.bananaRage` (snímky mezi hody).

## Hudba
- Hudba na pozadí je syntetizovaná přes Web Audio (žádné soubory) v chiptune stylu: obdélníkový/pulzní lead, trojúhelníková basa, šumová bicí.
- Čtyři skladby Beethovena (`PIECES`): **Óda na radost**, **Pro Elišku**, **Osudová** (5. symfonie), **Měsíční svit**; každý level má vlastní aranž
  (tónina, tempo, zvuk, doprovod, bicí, ozvěna) v poli `MUSIC_ARR` (21 levelů + finále po výhře).
- Hudba se pouští ve `startLevel`, zastavuje se po dokončení levelu / konci hry, pauza ji drží, `M` ji ztlumí.
  Ve zuřivé fázi bosse zrychlí o 20 % (`musicTempo`).
- Chceš-li změnit aranž levelu, uprav jeho řádek v `MUSIC_ARR` (`key` = posun v půltónech, `minor` = mollová verze Ódy).

## Obchod (klávesa B / ikona 🛒)
- Za nasbírané **body** (skóre) se kupují: vylepšení (Ohnivý dech = střílení bez bonusu, Rychlý oheň, Extra život, Štít, Delší bonusy, Rychlejší běh),
  **skiny** dráčka (`SKINS`) a **oblečení** (`CLOTHES`: hlava / obličej / tělo). Katalog je v `SHOP_ITEMS`, stav nákupů v `SHOP`.
- Obchod jde otevřít ve hře i na obrazovce „level splněn“, hra se při něm zastaví (včetně hudby). Ovládá se klávesami i dotykem.
- Nákupy se neukládají (po obnovení stránky jsou pryč) a po výhře se nulují.
- Ceny jsou nastavené tak, aby se na vše muselo sbírat celou hru (~100 000 bodů). Některé věci jsou zamčené (`lvl` = od levelu, `req` = nejdřív jiná věc);
  Extra život zdražuje o 1 500 s každým nákupem (`itemPrice`).

## Bodování
- Mince 50 · mince z bloku ? 100 · truhlička 500 · bonus z bloku 100 · oheň zabije 200 · traktor 100 · banán ohněm 25.
- Zašlápnutí nepřítele: **kombo** bez dotyku země 100 → 200 → 400 → 800 → 1600 (`stompScore`); Pankáč ×3.
- Konec levelu (`G.clear`): cíl 500 + 100 × level, čas pod limitem 50 / s, bez zranění +1000, všechny mince +1000.
- Boss: 300 za zásah, výhra +5000 a +500 za každý život.
- Body se přičítají přes `addScore(n)` – zvýší **skóre** (`G.score`) i **body k utracení** (`G.wallet`, `wallet()`). Nákup snižuje jen `G.wallet`.
- **Konec hry** (ztráta všech životů) = skóre i body k utracení na 0. Ztráta jednoho života body nebere.

## Celá obrazovka
- Klávesa **C** / tlačítko ⛶ (`toggleFullscreen`, Fullscreen API) – PC, Android, iPad. Na dotykovém zařízení se zapne už prvním klepnutím na titulní obrazovku.
- iPhone Fullscreen API nemá: celá obrazovka jde přes **Sdílet → Přidat na plochu** (`manifest.webmanifest`, ikony `icon-192/512.png`, `apple-touch-icon.png`).
