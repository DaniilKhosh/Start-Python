use Geologic
ALTER TABLE `Country` if exists RENAME TO `_countries`;
ALTER TABLE `_countries` CHANGE COLUMN `id` `id` INT NOT NULL AUTO_INCREMENT;
ALTER TABLE `_countries` CHANGE COLUMN `CountryName` `title` VARCHAR(150) COLLATE 'utf8mb4_bin' NOT NULL; 
ALTER TABLE `_countries` ADD PRIMARY KEY (`id`);_
ALTER TABLE `_countries` ADD INDEX `country_idx` (`title` ASC);



ALTER TABLE `Region` RENAME TO `_regions` ;
ALTER TABLE `_regions`  CHANGE COLUMN `id` `id` INT NOT NULL AUTO_INCREMENT ;
ALTER TABLE `_regions` CHANGE COLUMN `Region` `title` VARCHAR(150) COLLATE 'utf8mb4_bin' NOT NULL ;
ALTER TABLE `_regions`  CHANGE COLUMN `Id_Region` `country_id` INT NOT NULL ;
ALTER TABLE `_regions` ADD PRIMARY KEY (`id`);
ALTER TABLE `_regions` ADD INDEX `region_idx` (`title` ASC);
#add foreign index
ALTER TABLE `_regions` ADD CONSTRAINT `fk_region_1` FOREIGN KEY (`country_id`) REFERENCES `_countries`(id);


ALTER TABLE `City` RENAME TO `_cities` ;
ALTER TABLE `_cities` ADD COLUMN `id` INT NOT NULL ;
ALTER TABLE `_cities` ADD PRIMARY KEY (`id`);
ALTER TABLE `_cities` DROP INDEX `Id_Region_UNIQUE`;
ALTER TABLE `_cities`  CHANGE COLUMN `id` `id` INT NOT NULL AUTO_INCREMENT ;
ALTER TABLE `_cities` ADD COLUMN `important` tinyint(1) NOT NULL;
ALTER TABLE `_cities` CHANGE COLUMN `Id_Region` `region_id` INT NOT NULL;
ALTER TABLE `_cities`  CHANGE COLUMN `Id_District` `country_id` INT NOT NULL ;
ALTER TABLE `_cities` CHANGE COLUMN `City` `title` VARCHAR(150) COLLATE 'utf8mb4_bin' NOT NULL ;

ALTER TABLE `_cities` ADD INDEX `city_idx` (`title` ASC);
#add foreign indexes
ALTER TABLE `_cities` ADD CONSTRAINT `fx_country_1` FOREIGN KEY (`country_id`) REFERENCES `_countries`(id);
ALTER TABLE `_cities` ADD CONSTRAINT `fx_region_1` FOREIGN KEY (`region_id`) REFERENCES `_regions`(id);
  
 drop table `District`;