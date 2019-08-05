# создаем триггер который вставляет запись о дате поступления сотрудника на работу
DELETE TRIGGER `welcome`
CREATE TRIGGER `welcomel1`
AFTER INSERT ON `shtat`
FOR EACH ROW
INSERT INTO `salary` (`id_stuff`,`bonus`) VALUES (NEW.id, 10000);

INSERT INTO `shtat` (`name`,`lastname`,`dep_id`,`salary`) VALUES ('Денис','Сусанин',1,35000);


# создаем функцию которая выводит кол-во сотрудников по id отдела

CREATE FUNCTION `call_stuff2` (_name CHAR(20), _lastname CHAR(30))
RETURNS INT DETERMINISTIC
READS SQL DATA
RETURN (SELECT `id` FROM `shtat` WHERE `name` = _name and `lastname` = _lastname);

# запускаем функцию
SELECT call_stuff2('Дмитрий','Медведев');

-----------------
#Транзакция

SET transaction_isolation = SERIALIZABLE;
BEGIN;
set @y := 'Аминзаде';
SET @x := 68;
INSERT INTO `Book` (`Name`,`Zayavka`,`Sclad`) values (@y,'Поступление по заказу','2');
set @z := (select `Sclad` from `Book` where `Name` like @y) ; 
set @v := (select `id` from `Book` where `Name` like @y) ;
insert into `Sclad` (`Sclad_id`, `Book_id`, `Ostatok`) VALUES (@z, @v, @x);
COMMIT;

---------------------------------------------------------
#explain

mysql> use Areas;
Database changed
mysql> SELECT  `_countries`.`title` AS `Страна`, `_regions`.`title` AS  `Область`,`_cities`.`title` AS `Город` FROM `_cities`
    -> RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id`
    -> RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id`
    -> ORDER BY`_countries`.`id`;
+----------------------+-------------------------------------------+------------ ---------------+
| Страна               | Область                                   | Город                      |
+----------------------+-------------------------------------------+----------------------------+
| Россия               | Московская область                        | Москва                     |
| Россия               | Московская область                        | Мытищи                     |
| Россия               | Московская область                        | Королев                    |
| Россия               | Тульская область                          | Тула                       |
| Россия               | Тульская область                          | Воринск                    |
| Белоруссия           | Могилевская область                       | Могилев                    |
| Белоруссия           | Минская область                           | Минск                      |
| Казахстан            | Алмаатинская область                      | Алматы                     |
| Казахстан            | Семипалатинский район                     | Семипалатинск              |
| Казахстан            | Джезказганский район                      | Джезказган                 |
| Япония               | Токийский округ                           | Шибуя                      |
| Япония               | Токийский округ                           | Токио                      |
| Франция              | Парижский округ                           | Сен-Жермен                 |
| Франция              | Парижский округ                           | Ларош-Рояль                |
+----------------------+-------------------------------------------+----------------------------+
14 rows in set (0,00 sec)


mysql> explain SELECT  `_countries`.`title` AS `Страна`, `_regions`.`title` AS  `Область`,`_cities`.`title` AS `Город` FROM `_cities` RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id` RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id` ORDER BY`_countries`.`id`;
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
| id | select_type | table      | partitions | type   | possible_keys            | key          | key_len | ref                     | rows | filtered | Extra |
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
|  1 | SIMPLE      | _countries | NULL       | index  | NULL                     | PRIMARY      | 4       | NULL                    |    5 |   100.00 | NULL  |
|  1 | SIMPLE      | _cities    | NULL       | ref    | fx_country_1,fx_region_1 | fx_country_1 | 4       | Areas._countries.id     |    2 |   100.00 | NULL  |
|  1 | SIMPLE      | _regions   | NULL       | eq_ref | PRIMARY                  | PRIMARY      | 4       | Areas._cities.region_id |    1 |   100.00 | NULL  |
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
3 rows in set, 1 warning (0,00 sec)

mysql> select * from `_countries`;
+----+----------------------+
| id | title                |
+----+----------------------+
|  2 | Белоруссия           |
|  3 | Казахстан            |
|  1 | Россия               |
|  5 | Франция              |
|  4 | Япония               |
+----+----------------------+
5 rows in set (0,00 sec)

mysql> select * from `_regions`;
+----+-------------------------------------------+------------+
| id | title                                     | country_id |
+----+-------------------------------------------+------------+
|  1 | Московская область                        |          1 |
|  2 | Тульская область                          |          1 |
|  3 | Могилевская область                       |          2 |
|  4 | Минская область                           |          2 |
|  5 | Алмаатинская область                      |          3 |
|  6 | Семипалатинский район                     |          3 |
|  7 | Джезказганский район                      |          3 |
|  8 | Токийский округ                           |          4 |
|  9 | Парижский округ                           |          5 |
+----+-------------------------------------------+------------+
9 rows in set (0,00 sec)

mysql> select * from `_countries`;
+----+----------------------+
| id | title                |
+----+----------------------+
|  2 | Белоруссия           |
|  3 | Казахстан            |
|  1 | Россия               |
|  5 | Франция              |
|  4 | Япония               |
+----+----------------------+
5 rows in set (0,00 sec)


mysql> select * from `_cities`;
+----+-----------+------------+----------------------------+---------+
| id | region_id | country_id | title                      | num_car |
+----+-----------+------------+----------------------------+---------+
|  1 |         1 |          1 | Москва                     |     777 |
|  2 |         1 |          1 | Мытищи                     |     750 |
|  3 |         1 |          1 | Королев                    |     750 |
|  4 |         2 |          1 | Тула                       |     736 |
|  5 |         2 |          1 | Воринск                    |     546 |
|  6 |         3 |          2 | Могилев                    |     341 |
|  7 |         4 |          2 | Минск                      |     300 |
|  8 |         5 |          3 | Алматы                     |      11 |
|  9 |         6 |          3 | Семипалатинск              |      12 |
| 10 |         7 |          3 | Джезказган                 |     112 |
| 11 |         8 |          4 | Токио                      |     337 |
| 12 |         8 |          4 | Шибуя                      |     435 |
| 13 |         9 |          5 | Сен-Жермен                 |     540 |
| 14 |         9 |          5 | Ларош-Рояль                |     544 |
+----+-----------+------------+----------------------------+---------+
14 rows in set (0,00 sec)


mysql> explain SELECT  `_countries`.`title` AS `Страна`, `_regions`.`title` AS  `Область`,`_cities`.`title` AS `Город` FROM `_cities` RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id` RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id` ORDER BY`_countries`.`id`;
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
| id | select_type | table      | partitions | type   | possible_keys            | key          | key_len | ref                     | rows | filtered | Extra |
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
|  1 | SIMPLE      | _countries | NULL       | index  | NULL                     | PRIMARY      | 4       | NULL                    |    5 |   100.00 | NULL  |
|  1 | SIMPLE      | _cities    | NULL       | ref    | fx_country_1,fx_region_1 | fx_country_1 | 4       | Areas._countries.id     |    2 |   100.00 | NULL  |
|  1 | SIMPLE      | _regions   | NULL       | eq_ref | PRIMARY                  | PRIMARY      | 4       | Areas._cities.region_id |    1 |   100.00 | NULL  |
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
3 rows in set, 1 warning (0,01 sec)

mysql> explain SELECT  `_countries`.`title` AS `Страна`, `_regions`.`title` AS  `Область`,`_cities`.`title` AS `Город`
    -> FROM `_cities`
    -> RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id`
    -> RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id`
    -> HAVING `Область` LIKE 'Московская%'
    -> ORDER BY`_countries`.`id`;
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
| id | select_type | table      | partitions | type   | possible_keys            | key          | key_len | ref                     | rows | filtered | Extra |
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
|  1 | SIMPLE      | _countries | NULL       | index  | NULL                     | PRIMARY      | 4       | NULL                    |    5 |   100.00 | NULL  |
|  1 | SIMPLE      | _cities    | NULL       | ref    | fx_country_1,fx_region_1 | fx_country_1 | 4       | Areas._countries.id     |    2 |   100.00 | NULL  |
|  1 | SIMPLE      | _regions   | NULL       | eq_ref | PRIMARY                  | PRIMARY      | 4       | Areas._cities.region_id |    1 |   100.00 | NULL  |
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
3 rows in set, 1 warning (0,00 sec)


mysql> explain select * from `_countries` where `title`='Россия';
+----+-------------+------------+------------+-------+---------------+--------------+---------+-------+------+----------+-------------+
| id | select_type | table      | partitions | type  | possible_keys | key          | key_len | ref   | rows | filtered | Extra       |
+----+-------------+------------+------------+-------+---------------+--------------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | _countries | NULL       | const | title_UNIQUE  | title_UNIQUE | 602     | const |    1 |   100.00 | Using index |
+----+-------------+------------+------------+-------+---------------+--------------+---------+-------+------+----------+-------------+
1 row in set, 1 warning (0,00 sec)

mysql> explain `_countries`;
+-------+--------------+------+-----+---------+----------------+
| Field | Type         | Null | Key | Default | Extra          |
+-------+--------------+------+-----+---------+----------------+
| id    | int(11)      | NO   | PRI | NULL    | auto_increment |
| title | varchar(150) | NO   | UNI | NULL    |                |
+-------+--------------+------+-----+---------+----------------+
2 rows in set (0,00 sec)

mysql> explain `_regions`;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | int(11)      | NO   | PRI | NULL    | auto_increment |
| title      | varchar(150) | NO   |     | NULL    |                |
| country_id | int(11)      | NO   | MUL | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
3 rows in set (0,00 sec)

mysql> explain `_cities`;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | int(11)      | NO   | PRI | NULL    | auto_increment |
| region_id  | int(11)      | NO   | MUL | NULL    |                |
| country_id | int(11)      | NO   | MUL | NULL    |                |
| title      | varchar(150) | NO   |     | NULL    |                |
| num_car    | int(3)       | YES  |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
5 rows in set (0,00 sec)


mysql> select * from `_cities` where `num_car`='750';
+----+-----------+------------+----------------+---------+
| id | region_id | country_id | title          | num_car |
+----+-----------+------------+----------------+---------+
|  2 |         1 |          1 | Мытищи         |     750 |
|  3 |         1 |          1 | Королев        |     750 |
+----+-----------+------------+----------------+---------+
2 rows in set (0,00 sec)

mysql> explain select * from `_cities` where `num_car`='750';
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table   | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | _cities | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   14 |    10.00 | Using where |
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0,00 sec)

mysql> alter table `_cities` add index `_nc` (`num_car` ASC);
Query OK, 0 rows affected (0,09 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> explain select * from `_cities` where `num_car`='750';
+----+-------------+---------+------------+------+---------------+------+---------+-------+------+----------+-------+
| id | select_type | table   | partitions | type | possible_keys | key  | key_len | ref   | rows | filtered | Extra |
+----+-------------+---------+------------+------+---------------+------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | _cities | NULL       | ref  | _nc           | _nc  | 5       | const |    2 |   100.00 | NULL  |
+----+-------------+---------+------------+------+---------------+------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0,00 sec)






