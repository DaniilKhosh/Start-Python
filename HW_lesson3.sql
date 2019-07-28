#������� ������, � ������� �� ������� ��� ������ � ������ � ������, ������
SELECT  `_countries`.`title` AS `������`, `_regions`.`title` AS  `�������`,`_cities`.`title` AS `�����` FROM `_cities`
RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id`
RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id`
ORDER BY`_countries`.`id`

#������� ��� ������ �� ���������� �������.
SELECT  `_countries`.`title` AS `������`, `_regions`.`title` AS  `�������`,`_cities`.`title` AS `�����`
FROM `_cities` 
RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id`
RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id`
HAVING `�������` LIKE '����������%'
ORDER BY`_countries`.`id`

---------------------------------------------
������ 1248:
SELECT  `_countries`.`title` AS `������`, `_regions`.`title` AS  `�������`,`_cities`.`title` AS `�����` 
FROM (SELECT * FROM `_cities` WHERE `_cities`.`region_id` = '1')
RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id`
RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id`
-- HAVING `�������` LIKE '����������%'
ORDER BY`_countries`.`id`
----------------------------------

INSERT INTO `depart` (`name`) VALUES ('��'),('�������'),('HR'),('������');
INSERT INTO `shtat` 
(`name`,`lastname`,`dep_id`,`salary`) VALUES
('����','���������',1,25000),
('�������','�������',1,35000),
('�����','����������',1,45000),
('��������','�����������',3,55000),
('��������','�����',4,35000),
('��������','���������',3,225000),
('�����','������',2,115000),
('�����','��������',2,45000),
('��������','���������',1,55000),
('�����','�������',1,65000),
('������','�������',2,25000),
('����','����',2,35000),
('�����','���������',3,45000),
('������','�������',4,55000),
('�������','��������',4,65000);

#������� ������� �������� �� �������.
SELECT `depart`.`name` AS `�����`, AVG(`shtat`.`salary`) AS `������� ��` FROM `shtat` 
LEFT JOIN `depart` ON `shtat`.`dep_id` = `depart`.`id` 
GROUP BY `depart`.`name`;

#������� ������������ �������� � ����������.
SELECT  `shtat`.`name`, `shtat`.`lastname`, `depart`.`name`, `salary` FROM `shtat` 
RIGHT JOIN `depart` ON `shtat`.`dep_id` = `depart`.`id` 
WHERE `shtat`.`salary` = (select MAX(`shtat`.`salary`) from `shtat`) 

#������� ������ ����������, � �������� ������������ ��������.
DELETE FROM `shtat` WHERE `salary` = (select * from (select MAX(`salary`) from `shtat`) AS temp) 

#��������� ���������� ����������� �� ���� �������. (� ����������� ��������)
SELECT count(*) AS `���������� ���`, SUM(`salary`) AS `����� �����` FROM `shtat` 

#����� ���������� ����������� � ������� � ����������, ������� ����� ����� �������� �����.
SELECT count(*) AS `���������� ���`, SUM(`salary`) AS `����� �� �����`, `depart`.`name` AS `�����` FROM `shtat` 
LEFT JOIN `depart` ON `shtat`.`dep_id` = `depart`.`id` 
GROUP BY `dep_id`
