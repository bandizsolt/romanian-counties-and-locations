## All Romanian counties and locations (with diacritics)
## Toate județele și localitățile din România (cu diacritice)

Conține toate localitățile din România (sate, localități componente și localitățile de reședință ale comunelor, orașelor și municipiilor), precum și sectoarele capitalei, grupate pe județe, cu clasificarea utilizată de **INS** (Institutul Național de Statistică) în **SIRUTA** (Sistemul Informatic al Registrului Unităților Teritorial-Administrative), în format SQL. Din această bază de date sunt eliminate unitățile administrativ-teritoriale ca atare (municipiile, orașele și comunele, care au cod SIRUTA propriu, separat de cel al localității de reședință), deoarece nu avem nevoie de ierarhia dintre localități. Pur și simplu facem legătura dintre județ și localitatea respectivă (fie sat, oraș, municipiu etc., fără a ne interesa rangul). Municipiul București este tratat ca județ, iar localitățile sale sunt cele 6 sectoare.

Registrul SIRUTA este actualizat la fiecare 6 luni, cu modificările legislative apărute în perioada anterioară.


**Updated: 27-11-2026**

Total: **42** counties (41 județe + București) and **13755** locations (SQL format)

Each county also has its official two-letter abbreviation (`county_abbr`, e.g. AB, CJ, B), and each location has its SIRUTA code.

Source:
https://insse.ro/cms/ro/siruta > SIRUTA SEMESTRU (select the latest one)

Checked against SIRUTA S1 2026 (registry last update: 30.06.2026). Some location names are corrected compared to the INS file, see changelog.md.
