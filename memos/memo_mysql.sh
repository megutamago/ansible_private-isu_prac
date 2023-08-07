
### mysql ###
mysql
mysql -u root -p  # password nothing
mysql -u isuconp -pisuconp
# > isuconp
SHOW DATABASES;
use isuconp;
SELECT database();
SHOW TABLES;
DESCRIBE table_name;
# システム変数
SHOW VARIABLES;
# テーブル構造の確認
SHOW CREATE TABLE comments \G
SHOW CREATE TABLE posts \G
SHOW CREATE TABLE users \G
# index確認
show index from comments\G
show index from posts\G

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

# 公開設定
※MySQLは、次のファイルに指定された順番に起動オプションを読み取っていきます。
上から順番に読み込んでいき、下のファイルを読み込んでいく中で同じ項目の設定があると、上書きされて下の方のファイルに設定されている内容が有効になります。

### 以下エラー問題が浮上
user: isucon
  -> mysql -u root -pisuconp
  err
user : root
  -> mysql -u root -pisuconp
  ok
# 対処法
rootユーザーでなく、isuconユーザーでmysqlのユーザーを作成する.
-> ansible実装


◆◆◆◆◆◆◆◆
 app.go の使用ユーザーは、
 "root"ではなく"isuconp"だった
 813行辺り
 os環境変数から取得
◆◆◆◆◆◆◆◆

# drop user 'root'@'%';
# drop user 'isuconp'@'%';

# mysql -u root -pisuconp
# select user, host from mysql.user;
# CREATE USER 'root'@'%' IDENTIFIED BY 'isuconp';
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
# show grants for 'root'@'%';
# flush privileges;
# vim /etc/mysql/my.cnf  # ファイル読み込みコメントアウト
#   bind-address            = 0.0.0.0
#   mysqlx-bind-address     = 0.0.0.0
# systemctl restart mysql
# ss -ant | grep 3306
# mysql -h 192.168.11.42 -P 3306 -u root isuconp

select user, host from mysql.user;

mysql -u isuconp -pisuconp
CREATE USER 'isuconp'@'%' IDENTIFIED BY 'isuconp';
GRANT ALL PRIVILEGES ON *.* TO 'isuconp'@'%' WITH GRANT OPTION;
show grants for 'isuconp'@'%';
flush privileges;
mysql -h 192.168.11.42 -P 3306 -u isuconp isuconp


初めは一般userでrootログインができなかったはず。
↓↓↓これ実行すると、一般userでrootログインができる。たしかそう。
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '{PW}';
mysql> FLUSH PRIVILEGES;




###
CREATE USER 'hoge'@'%' IDENTIFIED BY 'isuconp';
GRANT ALL PRIVILEGES ON *.* TO 'hoge'@'%' WITH GRANT OPTION;
show grants for 'hoge'@'%';
flush privileges;
systemctl restart mysql
ss -ant | grep 3306

CREATE USER 'hoge'@'192.168.11.41' IDENTIFIED BY 'isuconp';
GRANT ALL PRIVILEGES ON *.* TO 'hoge'@'192.168.11.41' WITH GRANT OPTION;
show grants for 'hoge'@'%';
flush privileges;
systemctl restart mysql
ss -ant | grep 3306


RENAME USER 'root'@'localhost' TO 'root'@'%';


# mysql8でrootユーザーを削除した場合に再作成する方法
systemctl stop mysql
mkdir /var/run/mysqld
chown mysql:mysql /run/mysqld
mysqld_safe --skip-grant-tables --skip-networking &
mysql -u root
drop user 'root'@'localhost';
CREATE USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'isuconp';
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
show grants for 'root'@'localhost';
kill 48566
ps aux | grep 48566
systemctl start mysql



MySQL 8.0: クエリ キャッシュのサポート終了
https://dev.mysql.com/blog-archive/mysql-8-0-retiring-support-for-the-query-cache/


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
gzip -dk db_name.dump.sql.gz | pv --progress --size 1.4g -t -e -r -a

# recovery
pv hoge.dump.sql.gz --progress -t -e -r -a | mysql -u isuconp -pisuconp -h localhost isuconp < hoge.dump.sql
pv db_name.dump.sql | mysql -u root -pPASSWORD < testdatabase


create database testdatabase;
gzip -dk isuconp.dump.gz | pv --progress --size 1.4g -t -e -r -a
pv isuconp.dump | mysql -u root testdatabase2



#################### DBパフォーマンスチューニング ####################
#### DBスキーマを書き出す

# ↓　indexを貼るは嘘で、複合キーを使う。
https://github.com/Nagarei/isucon11-qualify-test/commit/f2776bb9b44234bdcf8b46f83473db0fe0eea06c

https://qiita.com/ichi_zamurai/items/fdbe3872a505c22ee431

https://oreno-it.info/archives/7
https://oreno-it.info/archives/530

https://blog.utgw.net/entry/2017/09/10/181130
https://kazeburo.hatenablog.com/entry/2014/10/14/170129



### これおすすめ
https://qiita.com/fururun02/items/e143ae87ec8a1c3884eb
・スレッドバッファのチューニング
show global status like 'Sort%';
・内部一時テーブルに関するメモリチューニング
show global status like 'Created_tmp%tables';
・バッファプール用メモリのチューニング
show global status like 'innodb_buffer%';
・バッファプールヒット率
show engine innodb status\G
・コネクションに関わるチューニング
show global status like 'Threads_created';


//////////
・テーブル/インデックス再編成
InnoDB では、更新を繰り返していると、断片化（フラグメンテーション）という現象が発生する。
フラグメンテーションが発生すると、本来読み取らなくて良い場所まで無駄に読み取る形になるため、クエリ処理が遅くなる可能性がある。
例えば、極端な例でいうと10000000行あるテーブルの内、5000000行を delete した状態だと、
データとしては 5000000 行しかない一方でテーブルが占有している領域としては 10000000 行使っている状態になる
・フラグメンテーションの発生状況
SELECT table_schema, table_name, data_free, table_rows 
FROM information_schema.tables 
WHERE table_schema = 'db01';

・共有ロック(S)と排他ロック(X)
・ギャップロック
例1 (#TX1 - REPEATABLE READ)
例2 (#TX1 - READ COMMITED)
//////////


### MySQLTuner
https://github.com/major/MySQLTuner-perl
wget http://mysqltuner.pl/ -O mysqltuner.pl
wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/basic_passwords.txt -O basic_passwords.txt
wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/vulnerabilities.csv -O vulnerabilities.csv


https://www.rosehosting.com/blog/install-and-use-mysqltuner-on-ubuntu-14-04/
apt -y install mysqltuner
cd /opt/
wget http://mysqltuner.pl/ -O mysqltuner.pl
chmod +x mysqltuner.pl
./mysqltuner.pl



https://qiita.com/mamy1326/items/9c5eaee3c986cff65a55#-index-%E3%82%92%E8%BF%BD%E5%8A%A0




typeを確認
  const・・・PRIMARY KEYまたはUNIQUEインデックスのルックアップによるアクセス。最速。
  eq_ref・・・JOINにおいてPRIARY KEYまたはUNIQUE KEYが利用される時のアクセスタイプ。constと似ているがJOINで用いられるところが違う。
  ref・・・ユニーク（PRIMARY or UNIQUE）でないインデックスを使って等価検索（WHERE key = value）を行った時に使われるアクセスタイプ。
  range・・・インデックスを用いた範囲検索。
  index・・・フルインデックススキャン。インデックス全体をスキャンする必要があるのでとても遅い。
  ALL・・・フルテーブルスキャン。インデックスがまったく利用されていないことを示す。OLTP系の処理では改善必須。
※indexまたはALLを見かけたらすかさずクエリをチューニングしよう。

↓rangeになる場合、ならない場合
https://zenn.dev/m_yamashii/articles/mysql-index-cardinality

その他
  possible_keys: SQLを実行する上で利用可能なINDEXとして候補にあがったINDEX
  key: 実際に選択されたINDEX
  Extra: 追加情報 Using filesortやUsing temporaryが出たら赤信号
Using filesortとUsing temporaryは最悪な組み合わせ
Using filesortはソートに必要な領域がメモリ上に乗り切らずに物理ファイルに書き出しソートを行う。
Using temporaryはクエリを実行するのにテンポラリテーブルが作られる。
リアルタイム処理を行うようなシステムの場合はUsing filesortとUsing temporaryが表示されたら改善必須


# Where狙いのキー、order by狙いのキー
https://www.konosumi.net/entry/2020/03/15/234810
https://gihyo.jp/dev/serial/01/mysql-road-construction-news/0097#:~:text=%E3%81%97%E3%81%A6%E3%81%84%E3%81%BE%E3%81%99%E3%80%82-,STRAIGHT_JOIN,INNER%20JOIN%E3%82%92%E8%A1%8C%E3%81%84%E3%81%BE%E3%81%99%E3%80%82
