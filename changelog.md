# Changelog

All changes to the data are listed here, newest first.

The data comes from the SIRUTA register published by INS. Where a name in this database is different from the INS file, the difference is listed below, with the reason and the source that confirms it. Each location keeps its SIRUTA code, so any name can be checked against the INS file.

## 27.11.2026

Checked against SIRUTA S1 2026 (register last updated by INS on 30.06.2026). The counties, the locations and the SIRUTA codes are the same as before: 42 counties and 13755 locations. No location was added, removed or moved to another county. 63 location names changed.

### Added

- `county_abbr` column in the counties table: the official two-letter county abbreviation from the INS county table (AB, CJ, B, ...). This is the code that WooCommerce and e-Factura use for the county.
- `update.sql`: update script for an existing installation. It adds the `county_abbr` column and applies the corrected names by SIRUTA code. It works with both data files and keeps the letter case of the installation.
- `source/SIRUTA_S1_2026.rar`: the INS archive this version was checked against. The 2023 archive is kept.
- `.gitattributes`: the same line endings (LF) for all text files.

### Changed in the SQL files

- Location names are now in single quotes instead of double quotes. Double quotes made the import fail in `ANSI_QUOTES` mode and in other databases.
- `SET NAMES utf8mb4;` added as the first line of the data files, so the diacritics are imported correctly on any connection.
- The data itself is not affected by these two changes.

### Tested

On MariaDB 11.8: a new installation with each data file; `update.sql` on the previous version with each data file (the result is identical to a new installation); import in `ANSI_QUOTES` mode; import on a latin1 connection.

### Renamed by law

| SIRUTA | County | Name in the INS file | Name in this database | Reason |
|---|---|---|---|---|
| 110704 | MEHEDINȚI | BÂLVĂNEȘTII DE JOS | BĂSEȘTI | Renamed by Legea nr. 211/2025 (M.O. nr. 1133/08.12.2025) |

### Corrected by INS

| SIRUTA | County | Name in the INS file | Name in this database | Reason |
|---|---|---|---|---|
| 27178 | BIHOR | ABRĂMUT | ABRĂMUȚ | Corrected by INS itself in SIRUTA S1 2026 |

### INS spelling mistakes corrected

The INS file with diacritics contains spelling mistakes (mostly missing diacritics). To find them, all 13755 names were compared by SIRUTA code with two sources that are independent from INS: Wikidata and OpenStreetMap. A name was corrected only when the sources named in the last column give the corrected form.

| SIRUTA | County | Name in the INS file | Name in this database | Confirmed by |
|---|---|---|---|---|
| 3976 | ALBA | CRACIUNELU DE SUS | CRĂCIUNELU DE SUS | Wikidata and OpenStreetMap |
| 6413 | ALBA | DUPA DEAL | DUPĂ DEAL | Wikidata and OpenStreetMap |
| 4605 | ALBA | HANĂȘEȘTI | HĂNĂȘEȘTI | Wikidata and OpenStreetMap |
| 6949 | ALBA | ROȘA DE SECAȘ | ROȘIA DE SECAȘ | INS table without diacritics, Wikipedia |
| 6459 | ALBA | VALE IN JOS | VALE ÎN JOS | Wikidata and OpenStreetMap |
| 10523 | ARAD | COVĂSINȚ | COVĂSÂNȚ | Wikidata and OpenStreetMap |
| 10024 | ARAD | CĂPĂLNAȘ | CĂPÂLNAȘ | Wikidata and OpenStreetMap |
| 9477 | ARAD | NADAB | NĂDAB | INS 2026 diacritics table, Wikipedia |
| 10042 | ARAD | VIRISMORT | VIRIȘMORT | Wikidata and OpenStreetMap |
| 13828 | ARGEȘ | ALBEȘTII PAMÂNTENI | ALBEȘTII PĂMÂNTENI | Wikidata (evident missing diacritic) |
| 18894 | ARGEȘ | LUNCA GÂRTII | LUNCA GÂRȚII | Wikidata and OpenStreetMap |
| 17655 | ARGEȘ | MUȘĂȚEȘTI | MUȘĂTEȘTI | Wikidata and OpenStreetMap |
| 15787 | ARGEȘ | OEȘTII PAMÂNTENI | OEȘTII PĂMÂNTENI | Wikidata (evident missing diacritic) |
| 19098 | ARGEȘ | STEFĂNEȘTI | ȘTEFĂNEȘTI | Wikidata (evident missing diacritic) |
| 24392 | BACĂU | HÂINEALA | HĂINEALA | INS 2026 diacritics table, Wikipedia |
| 30693 | BIHOR | SALIȘTE DE POMEZEU | SĂLIȘTE DE POMEZEU | Wikidata and OpenStreetMap |
| 33916 | BISTRIȚA-NĂSĂUD | DUPA DEAL | DUPĂ DEAL | Wikidata and OpenStreetMap |
| 33373 | BISTRIȚA-NĂSĂUD | ILVA MICA | ILVA MICĂ | Wikidata and OpenStreetMap |
| 35214 | BISTRIȚA-NĂSĂUD | LUNCA SĂTEASCA | LUNCA SĂTEASCĂ | Wikidata (evident missing diacritic) |
| 34431 | BISTRIȚA-NĂSĂUD | SILIVAIȘU DE CÂMPIE | SILIVAȘU DE CÂMPIE | INS 2026 diacritics table, Wikipedia |
| 38303 | BOTOȘANI | SARATA | SĂRATA | Wikidata and OpenStreetMap |
| 37654 | BOTOȘANI | SARATA-BASARAB | SĂRATA-BASARAB | Wikidata and OpenStreetMap |
| 41961 | BRAȘOV | BĂRCUT | BĂRCUȚ | Wikidata and OpenStreetMap |
| 40866 | BRAȘOV | COMANA DE JOS | COMĂNA DE JOS | Wikidata and OpenStreetMap |
| 40875 | BRAȘOV | COMANA DE SUS | COMĂNA DE SUS | Wikidata and OpenStreetMap |
| 41685 | BRAȘOV | LUNCA CALNICULUI | LUNCA CÂLNICULUI | Wikidata and OpenStreetMap |
| 46885 | BUZĂU | CĂLDĂRUȘEANCA | CĂLDĂRUȘANCA | Wikidata and OpenStreetMap |
| 62271 | CONSTANȚA | SINOIE | SINOE | Wikidata and OpenStreetMap |
| 62976 | CONSTANȚA | TEPEȘ VODĂ | ȚEPEȘ VODĂ | Wikidata and OpenStreetMap |
| 73451 | DOLJ | VELESTI | VELEȘTI | Wikidata (evident missing diacritic) |
| 85305 | HARGHITA | CASINU NOU | CAȘINU NOU | Wikidata and OpenStreetMap |
| 84497 | HARGHITA | GĂLĂUȚAȘ-PÂRÂU | GĂLĂUȚAȘ-PÂRĂU | Wikidata and OpenStreetMap |
| 102669 | IALOMIȚA | CHIROIU-PAMÂNTENI | CHIROIU-PĂMÂNTENI | Wikidata (evident missing diacritic) |
| 95783 | IAȘI | ȘOROGANI | ȘOROGARI | INS table without diacritics, Wikipedia |
| 109103 | MARAMUREȘ | ȘISEȘTI | ȘIȘEȘTI | Wikidata and OpenStreetMap |
| 111088 | MEHEDINȚI | TÂNȚARU | ȚÂNȚARU | Wikidata (evident missing diacritic) |
| 115593 | MUREȘ | DELENII | DELENI | Wikidata and OpenStreetMap |
| 119251 | MUREȘ | SARMAȘU | SĂRMAȘU | Wikidata and OpenStreetMap |
| 119714 | MUREȘ | VAIDACUȚA | VAIDACUTA | Wikidata and OpenStreetMap |
| 121144 | NEAMȚ | VARATEC | VĂRATEC | Wikidata and OpenStreetMap |
| 128392 | OLT | POTCOAVA FĂLCOENI | POTCOAVA-FĂLCOENI | Wikidata and OpenStreetMap |
| 139964 | SĂLAJ | RĂSTOLȚU-DEȘERT | RĂSTOLȚU DEȘERT | Wikidata and OpenStreetMap |
| 140949 | SĂLAJ | TĂMASA | TĂMAȘA | Wikidata and OpenStreetMap |
| 152190 | TELEORMAN | CĂLUGARU | CĂLUGĂRU | Wikidata and OpenStreetMap |
| 151889 | TELEORMAN | ROSIORI DE VEDE | ROȘIORI DE VEDE | Wikidata (OpenStreetMap has ROȘIORII DE VEDE) |
| 153785 | TELEORMAN | VITANESTI | VITĂNEȘTI | Wikidata and OpenStreetMap |
| 156071 | TIMIȘ | CHARLOTENBURG | CHARLOTTENBURG | Wikidata and OpenStreetMap |
| 156945 | TIMIȘ | DRĂGSINEȘTI | DRĂGȘINEȘTI | Wikidata (evident missing diacritic) |
| 156963 | TIMIȘ | GLADNA ROMÂNA | GLADNA ROMÂNĂ | Wikidata and OpenStreetMap |
| 157488 | TIMIȘ | GRABĂȚ | GRABAȚ | Wikidata and OpenStreetMap |
| 159320 | TIMIȘ | VIȘAG | VISAG | Wikidata and OpenStreetMap |
| 177067 | VRANCEA | ROMĂNEȘTI | ROMÂNEȘTI | Wikidata (evident missing diacritic) |
| 172778 | VÂLCEA | PLESEȘTI | PLEȘEȘTI | Wikidata (evident missing diacritic) |
| 172046 | VÂLCEA | PĂUSEȘTI-OTĂSĂU | PĂUȘEȘTI-OTĂSĂU | Wikidata (evident missing diacritic) |
| 172796 | VÂLCEA | ROMÂNEȘTI | ROMANEȘTI | Wikidata and OpenStreetMap |

### Hyphen added

The INS table without diacritics and Wikipedia write these names with a hyphen. The INS table with diacritics leaves it out.

| SIRUTA | County | Name in the INS file | Name in this database | Confirmed by |
|---|---|---|---|---|
| 68020 | DÂMBOVIȚA | DRĂGĂEȘTI PĂMÂNTENI | DRĂGĂEȘTI-PĂMÂNTENI | INS table without diacritics, Wikipedia |
| 68039 | DÂMBOVIȚA | DRĂGĂEȘTI UNGURENI | DRĂGĂEȘTI-UNGURENI | INS table without diacritics, Wikipedia |
| 69544 | DÂMBOVIȚA | GEMENEA BRĂTULEȘTI | GEMENEA-BRĂTULEȘTI | INS table without diacritics, Wikipedia |
| 69143 | DÂMBOVIȚA | VALEA LUNGĂ GORGOTA | VALEA LUNGĂ-GORGOTA | INS table without diacritics, Wikipedia |
| 69152 | DÂMBOVIȚA | VALEA LUNGĂ OGREA | VALEA LUNGĂ-OGREA | INS table without diacritics, Wikipedia |
| 120842 | NEAMȚ | DUMBRAVA DEAL | DUMBRAVA-DEAL | INS table without diacritics, Wikipedia |

### Letter case (only in `data_corrected_character_casing.sql`)

The linking words `cu`, `pe`, `sub`, `la`, `în` are now lower case, like `de`, `din`, `lui`, `cel` already were. This changes 17 names, for example Valea cu Apă, Remeți pe Someș, Poienile de sub Munte, Câmpulung la Tisa, Vale în Jos.

### Files

- `data_corected_character_casing.sql` renamed to `data_corrected_character_casing.sql` (spelling of the file name).
- `README.md` rewritten, with separate English and Romanian sections.
- `notes.txt` updated with the new INS source and the steps for the next update.

### Not changed

- About 47 names where only Wikidata gives a different form and it is not clear which one is correct (for example ȘEBIȘ / SEBIȘ, PIATRA-NEAMȚ / PIATRA NEAMȚ, LEHLIU-GARĂ / LEHLIU GARĂ). These stay as in the INS file.
- 94 names where only OpenStreetMap gives a different form. These were not checked one by one and stay as in the INS file.
- New spelling mistakes that appear only in the INS 2026 diacritics table (CIOFLINCENI, ROMĂNEȘTI in Maramureș, GRESU, POPEȘTI LEORDENI) were not taken over.

## Applied at every update

These differences from the INS file are kept at every update (see `notes.txt`).

- All names: the cedilla letters Ş and Ţ are replaced with the correct Romanian letters Ș and Ț.
- A space is added after the dots in initials. The INS file writes them without it:

| SIRUTA | County | Name in the INS file | Name in this database |
|---|---|---|---|
| 45824 | BUZĂU | C.A. ROSETTI | C. A. ROSETTI |
| 159892 | TULCEA | C.A.ROSETTI | C. A. ROSETTI |
| 161534 | TULCEA | I.C.BRĂTIANU | I. C. BRĂTIANU |
| 95621 | IAȘI | ALEXANDRU I.CUZA | ALEXANDRU I. CUZA |
| 103050 | CĂLĂRAȘI | ALEXANDRU I.CUZA | ALEXANDRU I. CUZA |

## 30.01.2023

| SIRUTA | County | Old name | New name |
|---|---|---|---|
| 59247 | CLUJ | RÂȘCA | RIȘCA |
