# Changelog

All changes to the data are listed here, newest first.

The data comes from the SIRUTA register published by INS. Where a name in this database is different from the INS file, the difference is listed below, with the reason and the source that confirms it. Each location keeps its SIRUTA code, so any name can be checked against the INS file.

## 27.11.2026

Checked against SIRUTA S1 2026 (register last updated by INS on 30.06.2026). The counties, the locations and the SIRUTA codes are the same as before: 42 counties and 13755 locations. No location was added, removed or moved to another county. 63 location names changed.

### Added

- `county_abbr` column in the counties table: the official two-letter county abbreviation from the INS county table (AB, CJ, B, ...). This is the code that WooCommerce and e-Factura use for the county.
- `uat_siruta` and `uat_name` columns in the locations table: the SIRUTA code and the name of the commune, town or municipality (UAT) each location belongs to, taken from the INS file (`SIRSUP`). Inside a county, 889 locations share their name with another one (for example 9 locations called POPEȘTI in VÂLCEA). With `uat_name` every location is unique inside its county. For București the unit is BUCUREȘTI.
- `update.sql`: update script for an existing installation. It adds the `county_abbr`, `uat_siruta` and `uat_name` columns and applies the corrected names by SIRUTA code. It works with both data files and keeps the letter case of the installation.
- `source/SIRUTA_S1_2026.rar`: the INS archive this version was checked against. The 2023 archive is kept.
- `.gitattributes`: the same line endings (LF) for all text files.

### Changed in the SQL files

- Location names are now in single quotes instead of double quotes. Double quotes made the import fail in `ANSI_QUOTES` mode and in other databases.
- `SET NAMES utf8mb4;` added as the first line of the data files, so the diacritics are imported correctly on any connection.
- The data itself is not affected by these two changes.

### Tested

On MariaDB 11.8: a new installation with each data file; `update.sql` on the previous version with each data file (the result is identical to a new installation); no two locations in a county with the same name and the same unit; import in `ANSI_QUOTES` mode; import on a latin1 connection.

### Renamed by law

| SIRUTA | County | Old name | New name | Reason |
|---|---|---|---|---|
| 110704 | MEHEDINȚI | BÂLVĂNEȘTII DE JOS | BĂSEȘTI | Renamed by Legea nr. 211/2025 (M.O. nr. 1133/08.12.2025) |

### Corrected by INS

| SIRUTA | County | Old name | New name | Reason |
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

### Names of communes, towns and municipalities (`uat_name`)

The INS file writes these units as MUNICIPIUL ALBA IULIA, ORAȘ ABRUD, ALBAC. Here the words MUNICIPIUL and ORAȘ are left out. Where the unit has the same name as its seat locality, it has the same corrected form as that locality (for example SILIVAȘU DE CÂMPIE, COVĂSÂNȚ, ILVA MICĂ, C. A. ROSETTI). Three more names are different from the INS file:

| SIRUTA | County | Name in the INS file | Name in this database | Reason |
|---|---|---|---|---|
| 40857 | BRAȘOV | COMANA | COMĂNA | Same as its villages COMĂNA DE JOS and COMĂNA DE SUS; Wikidata |
| 93281 | CĂLĂRAȘI | CUZA VODA | CUZA VODĂ | Missing diacritic; the INS file has CUZA VODĂ for the village; Wikidata |
| 130366 | OLT | SÂRBII - MĂGURA | SÂRBII-MĂGURA | Spaces around the hyphen removed; Wikidata |

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

### Open questions (not changed)

For the names below, the sources do not agree, and it is not clear which form is the official one. They are not changed: this database has the same form as the INS file. They are listed here so that they can be checked. Corrections from INS or from anyone who knows the official form are welcome.

**Wikidata has a different form (47 names).** OpenStreetMap has the same form as the INS file, or no entry.

| SIRUTA | County | Name in the INS file and in this database | Name in Wikidata |
|---|---|---|---|
| 20448 | BACĂU | DEALU-MARE | DEALU MARE |
| 26207 | BACĂU | NĂZĂRIOAIA | NAZĂRIOAIA |
| 30050 | BIHOR | MARȚIHAZ | MĂRȚIHAZ |
| 29314 | BIHOR | ȘEBIȘ | SEBIȘ |
| 34388 | BISTRIȚA-NĂSĂUD | DEALU ȘTEFĂNIȚEI | DEALUL ȘTEFĂNIȚEI |
| 35982 | BOTOȘANI | LISMĂNIȚA | LIȘMĂNIȚA |
| 43288 | BRĂILA | GRADIȘTEA | GRĂDIȘTEA |
| 43536 | BRĂILA | NEDEICU | NEDELCU |
| 43705 | BRĂILA | RACOVIȚĂ | RACOVIȚA |
| 45156 | BUZĂU | MÂNĂSTIREA RĂTEȘTI | MĂNĂSTIREA RĂTEȘTI |
| 50040 | BUZĂU | OREAVUL | OREAVU |
| 53461 | CARAȘ-SEVERIN | OHABIȚA | OHĂBIȚA |
| 52437 | CARAȘ-SEVERIN | PRISACINA | PRISĂCINA |
| 63660 | COVASNA | SĂRĂMĂȘ | SĂRĂMAȘ |
| 93897 | CĂLĂRAȘI | LEHLIU-GARĂ | LEHLIU GARĂ |
| 77849 | GORJ | DRĂGOENI | DRĂGOIENI |
| 79040 | GORJ | PEȘTEANA JIU | PEȘTEANA-JIU |
| 79709 | GORJ | STRÂMBA VULCAN | STRÂMBA-VULCAN |
| 82546 | GORJ | VÂNATA | VÂNĂTA |
| 85519 | HARGHITA | VIDACUT | VIDĂCUT |
| 89598 | HUNEDOARA | BACÂIA | BĂCÂIA |
| 95649 | IAȘI | SCHEIA | ȘCHEIA |
| 99888 | IAȘI | ȚIGĂNĂȘI | ȚIGĂNAȘI |
| 104476 | ILFOV | MICȘUNEȘTII-MOARĂ | MICȘUNEȘTI-MOARĂ |
| 113634 | MEHEDINȚI | ȘIȘEȘTI | SISEȘTI |
| 119411 | MUREȘ | CIPĂIENI | CIPAIENI |
| 121395 | NEAMȚ | BIRA | BÂRA |
| 121019 | NEAMȚ | IZVORUL ALB | IZVORU ALB |
| 125043 | NEAMȚ | MĂNĂSTIREA NEAMȚ | MÂNĂSTIREA NEAMȚ |
| 120735 | NEAMȚ | PIATRA-NEAMȚ | PIATRA NEAMȚ |
| 135921 | PRAHOVA | MAGULA | MĂGULA |
| 143986 | SIBIU | NOUL ROMÂN | NOU ROMÂN |
| 149566 | SUCEAVA | DEMACUȘA | DEMĂCUȘA |
| 148104 | SUCEAVA | DOLHEȘTII-MARI | DOLHEȘTII MARI |
| 147287 | SUCEAVA | DUBIUȘCA | DUBIUSCA |
| 154291 | TELEORMAN | SILIȘTEA-GUMEȘTI | SILIȘTEA GUMEȘTI |
| 159053 | TIMIȘ | CADAR | CADĂR |
| 166271 | VASLUI | FOCȘEAȘCA | FOCȘEASCA |
| 166379 | VASLUI | MANTU | MANȚU |
| 165327 | VASLUI | PODU PETRIȘ | PODU PIETRIȘ |
| 162997 | VASLUI | TĂBĂLĂEȘTI | TĂBĂLĂIEȘTI |
| 176374 | VRANCEA | DEALUL LUNG | DEALU LUNG |
| 173953 | VÂLCEA | BĂLTĂȚENI | BĂLȚĂȚENI |
| 172652 | VÂLCEA | FRĂSINA | FRASINA |
| 171502 | VÂLCEA | IZBĂSEȘTI | IZBĂȘEȘTI |
| 167749 | VÂLCEA | MOȘOROAȘA | MOSOROASA |
| 168531 | VÂLCEA | PREOTEȘTI | PREOȚEȘTI |

One of these names is written in two ways inside the INS file itself: the village GRADIȘTEA (43288, BRĂILA) belongs to the commune that INS writes GRĂDIȘTEA (43279). Both are kept here as INS has them.

**OpenStreetMap has a different form (24 names).** Wikidata has the same form as the INS file.

| SIRUTA | County | Name in the INS file and in this database | Name in OpenStreetMap |
|---|---|---|---|
| 17646 | ARGEȘ | COSTEȘTI-VÂLSAN | COSTEȘTI-VÂSLAN |
| 23822 | BACĂU | FERESTRĂU-OITUZ | FERĂSTRĂU-OITUZ |
| 68422 | DÂMBOVIȚA | DEALU FRUMOS | DEALUL FRUMOS |
| 76825 | GALAȚI | BRANIȘTEA | BRĂNIȘTEA |
| 77518 | GALAȚI | VÂRLEZI | VĂRLEZI |
| 102008 | GIURGIU | NEAJLOVU | NEAJLOV |
| 102017 | GIURGIU | PODU DOAMNEI | PODUL DOAMNEI |
| 106032 | GIURGIU | VÂLCELELE | VÂLCELE |
| 77885 | GORJ | ROMANEȘTI | ROMÂNEȘTI |
| 78757 | GORJ | VOITEȘTII DIN VALE | VOITEȘTII DE VALE |
| 87727 | HUNEDOARA | ȘĂULEȘTI | SĂULEȘTI |
| 97893 | IAȘI | SCHITU HADÂMBULUI | SCHITU HADÂMBU |
| 97223 | IAȘI | SCOPOSENI | SCOPOȘENI |
| 110429 | MEHEDINȚI | RUNCUȘORU | RUNCȘOR |
| 119037 | MUREȘ | COTORINAU | COTORINĂU |
| 121475 | NEAMȚ | BÂRGĂUANI | BÂRGAUANI |
| 132397 | PRAHOVA | GRADIȘTEA | GRĂDIȘTEA |
| 157040 | TIMIȘ | GAVOJDIA | GĂVOJDIA |
| 158993 | TIMIȘ | ICTAR-BUDINȚI | ICTAR-BUDINȚ |
| 156758 | TIMIȘ | VĂLCANI | VALCANI |
| 165755 | VASLUI | DRAXENI | DRĂXENI |
| 168611 | VÂLCEA | BERBEȘTI | BERBESTI |
| 168256 | VÂLCEA | COLTEȘTI | COLȚEȘTI |
| 172064 | VÂLCEA | ȘOLICEȘTI | SOLICEȘTI |

Not listed: the names where OpenStreetMap only leaves out the hyphen (42 names, for example FRASIN-DEAL / FRASIN DEAL), where it still has an INS spelling mistake that is corrected here, or where it uses a different local name.

**Mistakes that are only in the second INS table.** The `siruta.mdb` file of S1 2026 has two tables, `siruta_rez` and `SIR_DIACRITIC`. This database follows `siruta_rez`. `SIR_DIACRITIC` has these different forms, which were not taken over: CIOFLINCENI (105188, correct: CIOFLICENI), ROMĂNEȘTI (107476, correct: ROMÂNEȘTI), GRESU (178144, correct: GREȘU), POPEȘTI LEORDENI (179542, correct: POPEȘTI-LEORDENI). It also still has the old forms BÂLVĂNEȘTII DE JOS (110704) and ABRĂMUT (27178).

**Reported to INS.** The corrected names and the differences between the two INS tables were sent to INS (registraturaINS@insse.ro) on 27.11.2026, with a request to confirm the official forms.

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
