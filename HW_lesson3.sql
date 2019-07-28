#Сделать запрос, в котором мы выберем все данные о городе – регион, страна
SELECT  `_countries`.`title` AS `Страна`, `_regions`.`title` AS  `Область`,`_cities`.`title` AS `Город` FROM `_cities`
RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id`
RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id`
ORDER BY`_countries`.`id`

#Выбрать все города из Московской области.
SELECT  `_countries`.`title` AS `Страна`, `_regions`.`title` AS  `Область`,`_cities`.`title` AS `Город`
FROM `_cities` 
RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id`
RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id`
HAVING `Область` LIKE 'Московская%'
ORDER BY`_countries`.`id`

---------------------------------------------
Ошибка 1248:
SELECT  `_countries`.`title` AS `Страна`, `_regions`.`title` AS  `Область`,`_cities`.`title` AS `Город` 
FROM (SELECT * FROM `_cities` WHERE `_cities`.`region_id` = '1')
RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id`
RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id`
-- HAVING `Область` LIKE 'Московская%'
ORDER BY`_countries`.`id`
----------------------------------

INSERT INTO `depart` (`name`) VALUES ('ИТ'),('Реклама'),('HR'),('Охрана');
INSERT INTO `shtat` 
(`name`,`lastname`,`dep_id`,`salary`) VALUES
('Иван','Прокофьев',1,25000),
('Евгений','Гоменюк',1,35000),
('Елена','Звягинцева',1,45000),
('Владимир','Первоцветов',3,55000),
('Владимир','Путин',4,35000),
('Кристина','Орбакайте',3,225000),
('Иосиф','Кобзон',2,115000),
('Алена','Гурченко',2,45000),
('Владимир','Зеленский',1,55000),
('Антон','Брежнев',1,65000),
('Галина','Пучкова',2,25000),
('Джим','Кери',2,35000),
('Алена','Путятична',3,45000),
('Михаил','Потапов',4,55000),
('Дмитрий','Медведев',4,65000);

#Выбрать среднюю зарплату по отделам.
SELECT `depart`.`name` AS `Отдел`, AVG(`shtat`.`salary`) AS `Средняя ЗП` FROM `shtat` 
LEFT JOIN `depart` ON `shtat`.`dep_id` = `depart`.`id` 
GROUP BY `depart`.`name`;

#Выбрать максимальную зарплату у сотрудника.
SELECT  `shtat`.`name`, `shtat`.`lastname`, `depart`.`name`, `salary` FROM `shtat` 
RIGHT JOIN `depart` ON `shtat`.`dep_id` = `depart`.`id` 
WHERE `shtat`.`salary` = (select MAX(`shtat`.`salary`) from `shtat`) 

#Удалить одного сотрудника, у которого максимальная зарплата.
DELETE FROM `shtat` WHERE `salary` = (select * from (select MAX(`salary`) from `shtat`) AS temp) 

#Посчитать количество сотрудников во всех отделах. (и заоднообщую зарплату)
SELECT count(*) AS `Количество чел`, SUM(`salary`) AS `Денег всего` FROM `shtat` 

#Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
SELECT count(*) AS `Количество чел`, SUM(`salary`) AS `Денег на отдел`, `depart`.`name` AS `Отдел` FROM `shtat` 
LEFT JOIN `depart` ON `shtat`.`dep_id` = `depart`.`id` 
GROUP BY `dep_id`
