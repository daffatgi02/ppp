CREATE TABLE `ta-matchmaking` (
	`identifier` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`name` VARCHAR(255) NULL DEFAULT 'BQ Workshop' COLLATE 'utf8mb4_general_ci',
	`kills` INT(11) NOT NULL DEFAULT '0',
	`deaths` INT(11) NOT NULL DEFAULT '0',
	`pts` INT(11) NULL DEFAULT '0',
	`totalmatches` INT(11) NOT NULL DEFAULT '0',
	`wins` INT(11) NOT NULL DEFAULT '0',
	`loses` INT(11) NOT NULL DEFAULT '0',
	`rank` VARCHAR(50) NOT NULL DEFAULT 'Unranked' COLLATE 'utf8mb4_general_ci',
	`avatar` LONGTEXT NULL DEFAULT 'https://cdn.discordapp.com/attachments/1040606952352399429/1082432262534070412/Baslksz-2.png' COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`identifier`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
