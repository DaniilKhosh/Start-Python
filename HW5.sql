# ������� ������� ������� ��������� ������ � ���� ����������� ���������� �� ������
DELETE TRIGGER `welcome`
CREATE TRIGGER `welcomel1`
AFTER INSERT ON `shtat`
FOR EACH ROW
INSERT INTO `salary` (`id_stuff`,`bonus`) VALUES (NEW.id, 10000);

INSERT INTO `shtat` (`name`,`lastname`,`dep_id`,`salary`) VALUES ('�����','�������',1,35000);


# ������� ������� ������� ������� ���-�� ����������� �� id ������

CREATE FUNCTION `call_stuff2` (_name CHAR(20), _lastname CHAR(30))
RETURNS INT DETERMINISTIC
READS SQL DATA
RETURN (SELECT `id` FROM `shtat` WHERE `name` = _name and `lastname` = _lastname);

# ��������� �������
SELECT call_stuff2('�������','��������');

-----------------
#����������

SET transaction_isolation = SERIALIZABLE;
BEGIN;
set @y := '��������';
SET @x := 68;
INSERT INTO `Book` (`Name`,`Zayavka`,`Sclad`) values (@y,'����������� �� ������','2');
set @z := (select `Sclad` from `Book` where `Name` like @y) ; 
set @v := (select `id` from `Book` where `Name` like @y) ;
insert into `Sclad` (`Sclad_id`, `Book_id`, `Ostatok`) VALUES (@z, @v, @x);
COMMIT;

---------------------------------------------------------
#explain

mysql> use Areas;
Database changed
mysql> SELECT  `_countries`.`title` AS `������`, `_regions`.`title` AS  `�������`,`_cities`.`title` AS `�����` FROM `_cities`
    -> RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id`
    -> RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id`
    -> ORDER BY`_countries`.`id`;
+----------------------+-------------------------------------------+------------ ---------------+
| ������               | �������                                   | �����                      |
+----------------------+-------------------------------------------+----------------------------+
| ������               | ���������� �������                        | ������                     |
| ������               | ���������� �������                        | ������                     |
| ������               | ���������� �������                        | �������                    |
| ������               | �������� �������                          | ����                       |
| ������               | �������� �������                          | �������                    |
| ����������           | ����������� �������                       | �������                    |
| ����������           | ������� �������                           | �����                      |
| ���������            | ������������ �������                      | ������                     |
| ���������            | ��������������� �����                     | �������������              |
| ���������            | �������������� �����                      | ����������                 |
| ������               | ��������� �����                           | �����                      |
| ������               | ��������� �����                           | �����                      |
| �������              | ��������� �����                           | ���-������                 |
| �������              | ��������� �����                           | �����-�����                |
+----------------------+-------------------------------------------+----------------------------+
14 rows in set (0,00 sec)


mysql> explain SELECT  `_countries`.`title` AS `������`, `_regions`.`title` AS  `�������`,`_cities`.`title` AS `�����` FROM `_cities` RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id` RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id` ORDER BY`_countries`.`id`;
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
|  2 | ����������           |
|  3 | ���������            |
|  1 | ������               |
|  5 | �������              |
|  4 | ������               |
+----+----------------------+
5 rows in set (0,00 sec)

mysql> select * from `_regions`;
+----+-------------------------------------------+------------+
| id | title                                     | country_id |
+----+-------------------------------------------+------------+
|  1 | ���������� �������                        |          1 |
|  2 | �������� �������                          |          1 |
|  3 | ����������� �������                       |          2 |
|  4 | ������� �������                           |          2 |
|  5 | ������������ �������                      |          3 |
|  6 | ��������������� �����                     |          3 |
|  7 | �������������� �����                      |          3 |
|  8 | ��������� �����                           |          4 |
|  9 | ��������� �����                           |          5 |
+----+-------------------------------------------+------------+
9 rows in set (0,00 sec)

mysql> select * from `_countries`;
+----+----------------------+
| id | title                |
+----+----------------------+
|  2 | ����������           |
|  3 | ���������            |
|  1 | ������               |
|  5 | �������              |
|  4 | ������               |
+----+----------------------+
5 rows in set (0,00 sec)


mysql> select * from `_cities`;
+----+-----------+------------+----------------------------+---------+
| id | region_id | country_id | title                      | num_car |
+----+-----------+------------+----------------------------+---------+
|  1 |         1 |          1 | ������                     |     777 |
|  2 |         1 |          1 | ������                     |     750 |
|  3 |         1 |          1 | �������                    |     750 |
|  4 |         2 |          1 | ����                       |     736 |
|  5 |         2 |          1 | �������                    |     546 |
|  6 |         3 |          2 | �������                    |     341 |
|  7 |         4 |          2 | �����                      |     300 |
|  8 |         5 |          3 | ������                     |      11 |
|  9 |         6 |          3 | �������������              |      12 |
| 10 |         7 |          3 | ����������                 |     112 |
| 11 |         8 |          4 | �����                      |     337 |
| 12 |         8 |          4 | �����                      |     435 |
| 13 |         9 |          5 | ���-������                 |     540 |
| 14 |         9 |          5 | �����-�����                |     544 |
+----+-----------+------------+----------------------------+---------+
14 rows in set (0,00 sec)


mysql> explain SELECT  `_countries`.`title` AS `������`, `_regions`.`title` AS  `�������`,`_cities`.`title` AS `�����` FROM `_cities` RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id` RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id` ORDER BY`_countries`.`id`;
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
| id | select_type | table      | partitions | type   | possible_keys            | key          | key_len | ref                     | rows | filtered | Extra |
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
|  1 | SIMPLE      | _countries | NULL       | index  | NULL                     | PRIMARY      | 4       | NULL                    |    5 |   100.00 | NULL  |
|  1 | SIMPLE      | _cities    | NULL       | ref    | fx_country_1,fx_region_1 | fx_country_1 | 4       | Areas._countries.id     |    2 |   100.00 | NULL  |
|  1 | SIMPLE      | _regions   | NULL       | eq_ref | PRIMARY                  | PRIMARY      | 4       | Areas._cities.region_id |    1 |   100.00 | NULL  |
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
3 rows in set, 1 warning (0,01 sec)

mysql> explain SELECT  `_countries`.`title` AS `������`, `_regions`.`title` AS  `�������`,`_cities`.`title` AS `�����`
    -> FROM `_cities`
    -> RIGHT JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id`
    -> RIGHT JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id`
    -> HAVING `�������` LIKE '����������%'
    -> ORDER BY`_countries`.`id`;
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
| id | select_type | table      | partitions | type   | possible_keys            | key          | key_len | ref                     | rows | filtered | Extra |
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
|  1 | SIMPLE      | _countries | NULL       | index  | NULL                     | PRIMARY      | 4       | NULL                    |    5 |   100.00 | NULL  |
|  1 | SIMPLE      | _cities    | NULL       | ref    | fx_country_1,fx_region_1 | fx_country_1 | 4       | Areas._countries.id     |    2 |   100.00 | NULL  |
|  1 | SIMPLE      | _regions   | NULL       | eq_ref | PRIMARY                  | PRIMARY      | 4       | Areas._cities.region_id |    1 |   100.00 | NULL  |
+----+-------------+------------+------------+--------+--------------------------+--------------+---------+-------------------------+------+----------+-------+
3 rows in set, 1 warning (0,00 sec)


mysql> explain select * from `_countries` where `title`='������';
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
|  2 |         1 |          1 | ������         |     750 |
|  3 |         1 |          1 | �������        |     750 |
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






