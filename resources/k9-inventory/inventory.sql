CREATE TABLE IF NOT EXISTS `inventory` (
  `identifier` varchar(50) DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `protected` longtext DEFAULT NULL,
  `stash` longtext DEFAULT NULL,
  `hotbar` longtext DEFAULT NULL,
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;