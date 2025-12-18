# MySQL Backups

**[All Backups](./backups.md)**\
**[IT Admin](../it_admin.md)**\
**[Current Status](../../development/status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## Refences

## old method to backup/restore mysql

Can only use this if the mysql database meets the requirement of mysql InnoDB.  I believe this means the tables have to have a primary key.

```bash
mysql -h127.0.0.1 --port 3306 -uroot -p < ~/src/backups/reports31/mysql/2024-04-09-13:33:19.sql.bak
ERROR 3098 (HY000) at line 1092: The table does not comply with the requirements by an external plugin.

# restore to docker container
mysql -u root -p -P 3306 -h reports-alb < ~/backups/reports31/mysql/2024-07-16-17:57:41.sql.bak

# restore from backup
mysql -u root -p -h reports31 --port=30031 < ~/src/backups/reports31/mysql/2024-04-09-13:33:19.sql.bak

# backup all databases
mysqldump -u root -p -h 10.1.0.118 --port=31008 --column-statistics=0 --add-drop-table --routines --all-databases > /mnt/qnap_avi/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

mysqldump -u root -p -h 10.1.0.118 --port=31008 --column-statistics=0 --add-drop-table --routines --all-databases > /home/brent/src/backups/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

# restore all the databases
mysql -u root -p -h127.0.0.1 --port 3306 < ~/src/backups/reports31/mysql/2023-10-03-17:15:33.sql.bak

mysql -u root -p -h reports31 --port=30031 < ~/src/backups/reports31/mysql/2024-04-09-13:33:19.sql.bak

```

## **[Recommended method to backup/restore mysql](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-backups.html)**
