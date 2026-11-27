--
-- Table structure for table `#__romanian_counties`
--

CREATE TABLE IF NOT EXISTS `#__romanian_counties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `county_code` int(2) unsigned NOT NULL DEFAULT 0,
  `county_abbr` varchar(2) NOT NULL DEFAULT '',
  `county_name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `county_code` (`county_code`),
  UNIQUE KEY `county_abbr` (`county_abbr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `#__romanian_locations`
--

CREATE TABLE IF NOT EXISTS `#__romanian_locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `siruta` int(6) unsigned NOT NULL DEFAULT 0,
  `county_code` int(2) unsigned NOT NULL DEFAULT 0,
  `location_name` varchar(50) NOT NULL DEFAULT '',
  `uat_siruta` int(6) unsigned NOT NULL DEFAULT 0,
  `uat_name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `county_code` (`county_code`),
  KEY `uat_siruta` (`uat_siruta`),
  UNIQUE KEY `siruta` (`siruta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;
