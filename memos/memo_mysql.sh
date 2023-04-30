
### mysql ###
mysql
mysql -u root -p  # password nothing
mysql -u isuconp -pisuconp
# > isuconp
SHOW DATABASES;
use isuconp;
SELECT database();
SHOW TABLES;
# システム変数
SHOW VARIABLES;
# テーブル構造の確認
SHOW CREATE TABLE comments \G
SHOW CREATE TABLE posts \G
SHOW CREATE TABLE users \G
# index確認
show index from comments\G

mysql --defaults-file=/dev/null -h 127.0.0.1 -P 3306 -u isuconp -pisuconp isuconp
vim /etc/mysql/my.cnf
# ------------ #
[client]
user = isuconp
password = isuconp
# ------------ #
mysql --defaults-file=/etc/mysql/my.cnf -h 127.0.0.1 -P 3306 isuconp -e "show index from comments\G"
mysql --defaults-file=/etc/mysql/my.cnf -h 127.0.0.1 -P 3306 isuconp -e "alter table comments add index post_index(post_id);"
mysql --defaults-file=/etc/mysql/my.cnf -h 127.0.0.1 -P 3306 isuconp -e "show variables like 'slow_query%';"
mysql --defaults-file=/etc/mysql/my.cnf -h 127.0.0.1 -P 3306 isuconp -e "show variables like 'long%';"
mysql --defaults-file=/etc/mysql/my.cnf -h 127.0.0.1 -P 3306 isuconp -e "SHOW VARIABLES;" | grep query

cat /var/log/mysql/mysql-slow.sql | grep "INSERT INTO" | wc -l
# grep: (standard input): binary file matches
# 35
cat /var/log/mysql/mysql-slow.sql | grep -a "INSERT INTO" | wc -l
#148

# INSERT INTO `posts` (`user_id`, `mime`, `imgdata`, `body`) VALUES (655,'image/jpeg','ÿ\Ø...
cat /var/log/mysql/mysql-slow.sql | grep -a "INSERT INTO \`posts\`" | wc -l
cat /var/log/mysql/mysql-slow.sql | grep -v "INSERT INTO \`posts\`" > /var/log/mysql/mysql-slow-tmp.sql





### mysqldump ###
sudo apt -y install pv # progressbar
mysqldump -u isuconp -pisuconp -h localhost isuconp | gzip > hoge.dump.sql.gz
gzip -d db_name.dump.sql.gz
mysql -u isuconp -pisuconp -h localhost isuconp < hoge.dump.sql
# 実績　↑４つ

mysqldump -u isuconp -pisuconp -h localhost isuconp | gzip | pv --progress db_name.dump.sql(or --size 10g) -t -e -r -a > hoge.dump.sql.gz

# １つのデータベース
$ mysqldump -u isuconp -pisuconp -h localhost isuconp | gzip > hoge.dump.sql.gz
# １つのテーブル
$ mysqldump -u isuconp -pisuconp -h localhost DB_NAME TABLE_NAME | gzip > db_name.dump.sql.gz
# 全てのデータベース
$ mysqldump -u isuconp -pisuconp -h localhost -A | gzip > db_name.dump.sql.gz
# 解凍
gzip -d db_name.dump.sql.gz | pv --progress --size 1.4g -t -e -r -a

# recovery
pv hoge.dump.sql.gz --progress -t -e -r -a | mysql -u isuconp -pisuconp -h localhost isuconp < hoge.dump.sql
pv db_name.dump.sql | mysql -u root -pPASSWORD < testdatabase




#################### DBパフォーマンスチューニング ####################
#### DBスキーマを書き出す

# ↓　indexを貼るは嘘で、複合キーを使う。
https://github.com/Nagarei/isucon11-qualify-test/commit/f2776bb9b44234bdcf8b46f83473db0fe0eea06c

https://qiita.com/ichi_zamurai/items/fdbe3872a505c22ee431

https://oreno-it.info/archives/7
https://oreno-it.info/archives/530

https://blog.utgw.net/entry/2017/09/10/181130
https://kazeburo.hatenablog.com/entry/2014/10/14/170129

