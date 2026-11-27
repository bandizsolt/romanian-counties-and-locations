## All Romanian counties and locations (with diacritics)
## Toate județele și localitățile din România (cu diacritice)

Conține toate localitățile din România (sate, localități componente și localitățile de reședință ale comunelor, orașelor și municipiilor), precum și sectoarele capitalei, grupate pe județe, cu clasificarea utilizată de **INS** (Institutul Național de Statistică) în **SIRUTA** (Sistemul Informatic al Registrului Unităților Teritorial-Administrative), în format SQL. Din această bază de date sunt eliminate unitățile administrativ-teritoriale ca atare (municipiile, orașele și comunele, care au cod SIRUTA propriu, separat de cel al localității de reședință), deoarece nu avem nevoie de ierarhia dintre localități. Pur și simplu facem legătura dintre județ și localitatea respectivă (fie sat, oraș, municipiu etc., fără a ne interesa rangul). Municipiul București este tratat ca județ, iar localitățile sale sunt cele 6 sectoare.

Registrul SIRUTA este actualizat la fiecare 6 luni, cu modificările legislative apărute în perioada anterioară.


**Updated: 05-03-2024**

Total: **42** counties (41 județe + București) and **13755** locations (SQL format)

Source:
https://insse.ro/cms/ro > Baze de date și metadate statistice > Nomenclatoare statistice > http://80.96.186.4:81/senin/ > View Classification Data > SIRUTA > select the latest year if exist

"siruta.mdb" file last modification: 16.10.2023
