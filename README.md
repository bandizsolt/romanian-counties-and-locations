# Romanian counties and locations (with diacritics)

**English** | [Română](#județele-și-localitățile-din-românia-cu-diacritice)

All Romanian counties and locations in SQL format, with correct diacritics, based on **SIRUTA**, the official register of territorial-administrative units maintained by **INS** (the National Institute of Statistics).

**Updated: 27-11-2026** · **42** counties (41 județe + București) · **13755** locations

## What it contains

- **Counties:** the 41 counties plus the Municipality of Bucharest, which is treated as a county. Each one has its INS county code and its official two-letter abbreviation (AB, CJ, B, ...).
- **Locations:** every village, component locality and seat locality of the communes, towns and municipalities, each with its SIRUTA code and its county.
- **Commune, town or municipality:** each location also has the name and the SIRUTA code of the unit it belongs to. This tells apart the locations that have the same name inside a county.
- **Bucharest:** its locations are the 6 sectors.

The territorial-administrative units themselves (municipalities, towns and communes, which have their own SIRUTA code, separate from that of their seat locality) are not separate rows. The database links each location to its county, whatever its rank, and keeps the unit it belongs to in two columns.

## Files

| File | Content |
|---|---|
| `install.sql` | Table structure |
| `data.sql` | Data, names in upper case (as published by INS) |
| `data_corrected_character_casing.sql` | The same data, names in title case |
| `update.sql` | Update for an existing installation (new columns and corrected names) |
| `changelog.md` | Changes and name corrections |
| `source/` | The original INS archives |

## Tables

**`#__romanian_counties`**

| Column | Description |
|---|---|
| `id` | Primary key |
| `county_code` | INS county code (1-52) |
| `county_abbr` | Official two-letter abbreviation (e.g. `AB`, `CJ`, `B`) |
| `county_name` | County name |

**`#__romanian_locations`**

| Column | Description |
|---|---|
| `id` | Primary key |
| `siruta` | SIRUTA code of the location |
| `county_code` | INS county code, links to `#__romanian_counties.county_code` |
| `location_name` | Location name |
| `uat_siruta` | SIRUTA code of the commune, town or municipality (UAT) the location belongs to |
| `uat_name` | Name of that commune, town or municipality |

## Usage

1. Replace the `#__` table prefix with your own prefix (or remove it).
2. New installation: run `install.sql`, then one of the two data files.
3. Existing installation (data older than 27-11-2026): run `update.sql` once. It keeps your letter case (upper case or title case).

## Locations with the same name

Inside a county, 889 locations share their name with another one (for example, Vâlcea county has 9 locations called Popești). With `uat_name` every location is unique inside its county. To show this in a list, add the name of the commune or town in brackets when it is different from the location name:

```sql
SELECT IF(location_name = uat_name, location_name, CONCAT(location_name, ' (', uat_name, ')')) AS label
FROM `#__romanian_locations`
WHERE county_code = 38
ORDER BY label;
```

This gives `Popești`, `Popești (Fârtățești)`, `Popești (Golești)` and so on.

## Source

https://insse.ro/cms/ro/siruta > SIRUTA SEMESTRU (select the latest one)

The SIRUTA register is updated every 6 months with the legislative changes of the previous period. The data here is checked against SIRUTA S1 2026 (register last updated: 30.06.2026). Some location names are corrected compared to the INS file, see `changelog.md`.

## License

Public domain, see `LICENSE`.

---

# Județele și localitățile din România (cu diacritice)

[English](#romanian-counties-and-locations-with-diacritics) | **Română**

Toate județele și localitățile din România în format SQL, cu diacritice corecte, pe baza **SIRUTA** (Sistemul Informatic al Registrului Unităților Teritorial-Administrative), registrul oficial gestionat de **INS** (Institutul Național de Statistică).

**Actualizat: 27-11-2026** · **42** de județe (41 de județe + București) · **13755** de localități

## Ce conține

- **Județe:** cele 41 de județe și Municipiul București, tratat ca județ. Fiecare are codul de județ INS și abrevierea oficială de două litere (AB, CJ, B, ...).
- **Localități:** toate satele, localitățile componente și localitățile de reședință ale comunelor, orașelor și municipiilor, fiecare cu codul SIRUTA și județul său.
- **Comună, oraș sau municipiu:** fiecare localitate are și denumirea și codul SIRUTA al unității de care aparține. Astfel se pot deosebi localitățile cu aceeași denumire din același județ.
- **București:** localitățile sale sunt cele 6 sectoare.

Unitățile administrativ-teritoriale ca atare (municipiile, orașele și comunele, care au cod SIRUTA propriu, separat de cel al localității de reședință) nu sunt rânduri separate. Baza de date face legătura dintre județ și localitatea respectivă, fără a ne interesa rangul, și păstrează în două coloane unitatea de care aparține localitatea.

## Fișiere

| Fișier | Conținut |
|---|---|
| `install.sql` | Structura tabelelor |
| `data.sql` | Datele, cu denumirile scrise cu majuscule (ca în fișierul INS) |
| `data_corrected_character_casing.sql` | Aceleași date, cu denumirile scrise cu inițială majusculă |
| `update.sql` | Actualizare pentru o instalare existentă (coloanele noi și denumirile corectate) |
| `changelog.md` | Modificări și corecturi de denumiri |
| `source/` | Arhivele originale de la INS |

## Tabele

**`#__romanian_counties`**

| Coloană | Descriere |
|---|---|
| `id` | Cheie primară |
| `county_code` | Codul de județ INS (1-52) |
| `county_abbr` | Abrevierea oficială de două litere (de ex. `AB`, `CJ`, `B`) |
| `county_name` | Denumirea județului |

**`#__romanian_locations`**

| Coloană | Descriere |
|---|---|
| `id` | Cheie primară |
| `siruta` | Codul SIRUTA al localității |
| `county_code` | Codul de județ INS, legătura cu `#__romanian_counties.county_code` |
| `location_name` | Denumirea localității |
| `uat_siruta` | Codul SIRUTA al comunei, orașului sau municipiului (UAT) de care aparține localitatea |
| `uat_name` | Denumirea acelei comune, a acelui oraș sau municipiu |

## Utilizare

1. Înlocuiți prefixul `#__` al tabelelor cu prefixul propriu (sau ștergeți-l).
2. Instalare nouă: rulați `install.sql`, apoi unul dintre cele două fișiere de date.
3. Instalare existentă (date mai vechi de 27-11-2026): rulați `update.sql` o singură dată. Păstrează scrierea folosită (cu majuscule sau cu inițială majusculă).

## Localități cu aceeași denumire

În același județ, 889 de localități au aceeași denumire ca o altă localitate (de exemplu, în județul Vâlcea sunt 9 localități cu numele Popești). Cu `uat_name` fiecare localitate este unică în județul ei. Pentru afișare într-o listă, adăugați în paranteză denumirea comunei sau a orașului, atunci când diferă de denumirea localității:

```sql
SELECT IF(location_name = uat_name, location_name, CONCAT(location_name, ' (', uat_name, ')')) AS label
FROM `#__romanian_locations`
WHERE county_code = 38
ORDER BY label;
```

Rezultatul: `Popești`, `Popești (Fârtățești)`, `Popești (Golești)` și așa mai departe.

## Sursă

https://insse.ro/cms/ro/siruta > SIRUTA SEMESTRU (selectați cel mai recent)

Registrul SIRUTA este actualizat la fiecare 6 luni, cu modificările legislative apărute în perioada anterioară. Datele de aici sunt verificate cu SIRUTA S1 2026 (ultima actualizare a registrului: 30.06.2026). Unele denumiri sunt corectate față de fișierul INS, vezi `changelog.md`.

## Licență

Domeniu public, vezi `LICENSE`.
