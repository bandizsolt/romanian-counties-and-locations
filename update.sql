--
-- Update script for an existing installation (data older than 27.11.2026).
-- Run it once. New installations do not need it: use install.sql and one of the data files.
-- It works with both data files: upper case names stay upper case, title case names stay title case.
--

SET NAMES utf8mb4;

--
-- New column: official two-letter county abbreviation
--

ALTER TABLE `#__romanian_counties` ADD COLUMN `county_abbr` varchar(2) NOT NULL DEFAULT '' AFTER `county_code`;

UPDATE `#__romanian_counties` SET `county_abbr` = 'AB' WHERE `county_code` = 1;
UPDATE `#__romanian_counties` SET `county_abbr` = 'AR' WHERE `county_code` = 2;
UPDATE `#__romanian_counties` SET `county_abbr` = 'AG' WHERE `county_code` = 3;
UPDATE `#__romanian_counties` SET `county_abbr` = 'BC' WHERE `county_code` = 4;
UPDATE `#__romanian_counties` SET `county_abbr` = 'BH' WHERE `county_code` = 5;
UPDATE `#__romanian_counties` SET `county_abbr` = 'BN' WHERE `county_code` = 6;
UPDATE `#__romanian_counties` SET `county_abbr` = 'BT' WHERE `county_code` = 7;
UPDATE `#__romanian_counties` SET `county_abbr` = 'BV' WHERE `county_code` = 8;
UPDATE `#__romanian_counties` SET `county_abbr` = 'BR' WHERE `county_code` = 9;
UPDATE `#__romanian_counties` SET `county_abbr` = 'BZ' WHERE `county_code` = 10;
UPDATE `#__romanian_counties` SET `county_abbr` = 'CS' WHERE `county_code` = 11;
UPDATE `#__romanian_counties` SET `county_abbr` = 'CL' WHERE `county_code` = 51;
UPDATE `#__romanian_counties` SET `county_abbr` = 'CJ' WHERE `county_code` = 12;
UPDATE `#__romanian_counties` SET `county_abbr` = 'CT' WHERE `county_code` = 13;
UPDATE `#__romanian_counties` SET `county_abbr` = 'CV' WHERE `county_code` = 14;
UPDATE `#__romanian_counties` SET `county_abbr` = 'DB' WHERE `county_code` = 15;
UPDATE `#__romanian_counties` SET `county_abbr` = 'DJ' WHERE `county_code` = 16;
UPDATE `#__romanian_counties` SET `county_abbr` = 'GL' WHERE `county_code` = 17;
UPDATE `#__romanian_counties` SET `county_abbr` = 'GR' WHERE `county_code` = 52;
UPDATE `#__romanian_counties` SET `county_abbr` = 'GJ' WHERE `county_code` = 18;
UPDATE `#__romanian_counties` SET `county_abbr` = 'HR' WHERE `county_code` = 19;
UPDATE `#__romanian_counties` SET `county_abbr` = 'HD' WHERE `county_code` = 20;
UPDATE `#__romanian_counties` SET `county_abbr` = 'IL' WHERE `county_code` = 21;
UPDATE `#__romanian_counties` SET `county_abbr` = 'IS' WHERE `county_code` = 22;
UPDATE `#__romanian_counties` SET `county_abbr` = 'IF' WHERE `county_code` = 23;
UPDATE `#__romanian_counties` SET `county_abbr` = 'MM' WHERE `county_code` = 24;
UPDATE `#__romanian_counties` SET `county_abbr` = 'MH' WHERE `county_code` = 25;
UPDATE `#__romanian_counties` SET `county_abbr` = 'MS' WHERE `county_code` = 26;
UPDATE `#__romanian_counties` SET `county_abbr` = 'NT' WHERE `county_code` = 27;
UPDATE `#__romanian_counties` SET `county_abbr` = 'OT' WHERE `county_code` = 28;
UPDATE `#__romanian_counties` SET `county_abbr` = 'PH' WHERE `county_code` = 29;
UPDATE `#__romanian_counties` SET `county_abbr` = 'SM' WHERE `county_code` = 30;
UPDATE `#__romanian_counties` SET `county_abbr` = 'SJ' WHERE `county_code` = 31;
UPDATE `#__romanian_counties` SET `county_abbr` = 'SB' WHERE `county_code` = 32;
UPDATE `#__romanian_counties` SET `county_abbr` = 'SV' WHERE `county_code` = 33;
UPDATE `#__romanian_counties` SET `county_abbr` = 'TR' WHERE `county_code` = 34;
UPDATE `#__romanian_counties` SET `county_abbr` = 'TM' WHERE `county_code` = 35;
UPDATE `#__romanian_counties` SET `county_abbr` = 'TL' WHERE `county_code` = 36;
UPDATE `#__romanian_counties` SET `county_abbr` = 'VS' WHERE `county_code` = 37;
UPDATE `#__romanian_counties` SET `county_abbr` = 'VL' WHERE `county_code` = 38;
UPDATE `#__romanian_counties` SET `county_abbr` = 'VN' WHERE `county_code` = 39;
UPDATE `#__romanian_counties` SET `county_abbr` = 'B' WHERE `county_code` = 40;

ALTER TABLE `#__romanian_counties` ADD UNIQUE KEY `county_abbr` (`county_abbr`);

--
-- Corrected location names (see changelog.md)
--

UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'CRĂCIUNELU DE SUS', 'Crăciunelu de Sus') WHERE `siruta` = 3976;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'HĂNĂȘEȘTI', 'Hănășești') WHERE `siruta` = 4605;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'DUPĂ DEAL', 'După Deal') WHERE `siruta` = 6413;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'VALE ÎN JOS', 'Vale în Jos') WHERE `siruta` = 6459;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ROȘIA DE SECAȘ', 'Roșia de Secaș') WHERE `siruta` = 6949;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'NĂDAB', 'Nădab') WHERE `siruta` = 9477;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'CĂPÂLNAȘ', 'Căpâlnaș') WHERE `siruta` = 10024;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'VIRIȘMORT', 'Virișmort') WHERE `siruta` = 10042;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'COVĂSÂNȚ', 'Covăsânț') WHERE `siruta` = 10523;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ALBEȘTII PĂMÂNTENI', 'Albeștii Pământeni') WHERE `siruta` = 13828;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'OEȘTII PĂMÂNTENI', 'Oeștii Pământeni') WHERE `siruta` = 15787;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'MUȘĂTEȘTI', 'Mușătești') WHERE `siruta` = 17655;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'LUNCA GÂRȚII', 'Lunca Gârții') WHERE `siruta` = 18894;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ȘTEFĂNEȘTI', 'Ștefănești') WHERE `siruta` = 19098;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'HĂINEALA', 'Hăineala') WHERE `siruta` = 24392;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ABRĂMUȚ', 'Abrămuț') WHERE `siruta` = 27178;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'SĂLIȘTE DE POMEZEU', 'Săliște de Pomezeu') WHERE `siruta` = 30693;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ILVA MICĂ', 'Ilva Mică') WHERE `siruta` = 33373;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'DUPĂ DEAL', 'După Deal') WHERE `siruta` = 33916;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'SILIVAȘU DE CÂMPIE', 'Silivașu de Câmpie') WHERE `siruta` = 34431;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'LUNCA SĂTEASCĂ', 'Lunca Sătească') WHERE `siruta` = 35214;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'SĂRATA-BASARAB', 'Sărata-Basarab') WHERE `siruta` = 37654;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'SĂRATA', 'Sărata') WHERE `siruta` = 38303;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'COMĂNA DE JOS', 'Comăna de Jos') WHERE `siruta` = 40866;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'COMĂNA DE SUS', 'Comăna de Sus') WHERE `siruta` = 40875;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'LUNCA CÂLNICULUI', 'Lunca Câlnicului') WHERE `siruta` = 41685;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'BĂRCUȚ', 'Bărcuț') WHERE `siruta` = 41961;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'CĂLDĂRUȘANCA', 'Căldărușanca') WHERE `siruta` = 46885;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'LACU CU ANINI', 'Lacu cu Anini') WHERE `siruta` = 48254;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'SĂSENII PE VALE', 'Săsenii pe Vale') WHERE `siruta` = 50193;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'SINOE', 'Sinoe') WHERE `siruta` = 62271;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ȚEPEȘ VODĂ', 'Țepeș Vodă') WHERE `siruta` = 62976;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'MALU CU FLORI', 'Malu cu Flori') WHERE `siruta` = 67951;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'DRĂGĂEȘTI-PĂMÂNTENI', 'Drăgăești-Pământeni') WHERE `siruta` = 68020;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'DRĂGĂEȘTI-UNGURENI', 'Drăgăești-Ungureni') WHERE `siruta` = 68039;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'PUȚU CU SALCIE', 'Puțu cu Salcie') WHERE `siruta` = 68100;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'VALEA LUNGĂ-GORGOTA', 'Valea Lungă-Gorgota') WHERE `siruta` = 69143;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'VALEA LUNGĂ-OGREA', 'Valea Lungă-Ogrea') WHERE `siruta` = 69152;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'GEMENEA-BRĂTULEȘTI', 'Gemenea-Brătulești') WHERE `siruta` = 69544;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'VELEȘTI', 'Velești') WHERE `siruta` = 73451;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'VALEA CU APĂ', 'Valea cu Apă') WHERE `siruta` = 80356;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'GĂLĂUȚAȘ-PÂRĂU', 'Gălăuțaș-Pârău') WHERE `siruta` = 84497;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'CAȘINU NOU', 'Cașinu Nou') WHERE `siruta` = 85305;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'OHABA DE SUB PIATRĂ', 'Ohaba de sub Piatră') WHERE `siruta` = 91161;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ȘOROGARI', 'Șorogari') WHERE `siruta` = 95783;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'POIANA CU CETATE', 'Poiana cu Cetate') WHERE `siruta` = 97303;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'CHIROIU-PĂMÂNTENI', 'Chiroiu-Pământeni') WHERE `siruta` = 102669;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'BĂIȚA DE SUB CODRU', 'Băița de sub Codru') WHERE `siruta` = 107127;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'LUNCA LA TISA', 'Lunca la Tisa') WHERE `siruta` = 107387;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'CÂMPULUNG LA TISA', 'Câmpulung la Tisa') WHERE `siruta` = 107724;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'REMEȚI PE SOMEȘ', 'Remeți pe Someș') WHERE `siruta` = 108311;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'POIENILE DE SUB MUNTE', 'Poienile de sub Munte') WHERE `siruta` = 108482;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ȘIȘEȘTI', 'Șișești') WHERE `siruta` = 109103;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'BĂSEȘTI', 'Băsești') WHERE `siruta` = 110704;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ȚÂNȚARU', 'Țânțaru') WHERE `siruta` = 111088;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'DELENI', 'Deleni') WHERE `siruta` = 115593;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'SĂRMAȘU', 'Sărmașu') WHERE `siruta` = 119251;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'VAIDACUTA', 'Vaidacuta') WHERE `siruta` = 119714;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'DUMBRAVA-DEAL', 'Dumbrava-Deal') WHERE `siruta` = 120842;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'VĂRATEC', 'Văratec') WHERE `siruta` = 121144;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'POTCOAVA-FĂLCOENI', 'Potcoava-Fălcoeni') WHERE `siruta` = 128392;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'RĂSTOLȚU DEȘERT', 'Răstolțu Deșert') WHERE `siruta` = 139964;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'TĂMAȘA', 'Tămașa') WHERE `siruta` = 140949;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ȘAROȘ PE TÂRNAVE', 'Șaroș pe Târnave') WHERE `siruta` = 143833;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ROȘIORI DE VEDE', 'Roșiori de Vede') WHERE `siruta` = 151889;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'CĂLUGĂRU', 'Călugăru') WHERE `siruta` = 152190;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'MĂGURA CU LILIAC', 'Măgura cu Liliac') WHERE `siruta` = 152886;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'VITĂNEȘTI', 'Vitănești') WHERE `siruta` = 153785;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'CHARLOTTENBURG', 'Charlottenburg') WHERE `siruta` = 156071;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'DRĂGȘINEȘTI', 'Drăgșinești') WHERE `siruta` = 156945;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'GLADNA ROMÂNĂ', 'Gladna Română') WHERE `siruta` = 156963;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'GRABAȚ', 'Grabaț') WHERE `siruta` = 157488;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'VISAG', 'Visag') WHERE `siruta` = 159320;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'LINIA PE VALE', 'Linia pe Vale') WHERE `siruta` = 169510;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'PĂUȘEȘTI-OTĂSĂU', 'Păușești-Otăsău') WHERE `siruta` = 172046;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'PLEȘEȘTI', 'Pleșești') WHERE `siruta` = 172778;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ROMANEȘTI', 'Romanești') WHERE `siruta` = 172796;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'VITĂNEȘTII DE SUB MĂGURĂ', 'Vităneștii de sub Măgură') WHERE `siruta` = 175420;
UPDATE `#__romanian_locations` SET `location_name` = IF(BINARY `location_name` = BINARY UPPER(`location_name`), 'ROMÂNEȘTI', 'Românești') WHERE `siruta` = 177067;
