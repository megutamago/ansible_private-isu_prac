
◆◆◆◆◆◆◆◆
※超重要
su - isucon
  ->カレントディレクトリや環境変数は変更したユーザーの初期値に設定される
su isuon
  ->カレントディレクトリも環境変数も元のユーザーのものが引き継がれる
◆◆◆◆◆◆◆◆

### ssh port foward ###

#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\
ssh -fN -L 0.0.0.0:8080:192.168.11.41:80 192.168.11.44
ssh -fN -L 0.0.0.0:1080:localhost:1080 192.168.11.41
#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\

ssh -fN -L 0.0.0.0:8080:192.168.11.41:80 192.168.11.44  # test port trans
ssh -fN -L 0.0.0.0:19999:192.168.11.41:19999 192.168.11.44  # netdata
ssh -fN -L 0.0.0.0:1080:localhost:1080 192.168.11.41  # pprof
ssh -fN -L 0.0.0.0:9100:192.168.11.41:9100 192.168.11.41  # node_exporter
ssh -fN -L 0.0.0.0:3100:192.168.11.41:3100 192.168.11.41  # fluent-bit
ps aux | grep ssh

# grafana port 変換
curl http://localhost:8080/
# pprof
curl http://127.0.0.1:1080/
# http://192.168.11.21:1080/
kill <PID>

### wipe ps
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:8080:192.168.11.41:80 192.168.11.44' | grep -v grep | awk '{print $2}')
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:19999:192.168.11.41:19999 192.168.11.44' | grep -v grep | awk '{print $2}')
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:1080:localhost:1080 192.168.11.41' | grep -v grep | awk '{print $2}')
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:9100:192.168.11.41:9100 192.168.11.41' | grep -v grep | awk '{print $2}')
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:3100:192.168.11.41:3100 192.168.11.41' | grep -v grep | awk '{print $2}')
ps aux | grep ssh



# alp
cat /var/log/nginx/access.log \
| alp ltsv -m '/image/[0-9]+,/posts/[0-9]+,/@\w' \
--sort avg -r -o count,1xx,2xx,3xx,4xx,5xx,min,max,avg,sum,p99,method,uri



# pt-query-digest
cat /var/log/mysql/mysql-slow.sql | grep -v "INSERT INTO \`posts\`" > /var/log/mysql/mysql-slow-tmp.sql
#pt-query-digest /var/log/mysql/mysql-slow.sql
pt-query-digest /var/log/mysql/mysql-slow-tmp.sql




##### systemd #####
# ※./files/pattern.sh
# systemctl list-units --all --type=service | grep -v inactive > systemd-extract.txt 
# systemctl list-units --all --type=service | grep -v inactive \
# | sed '1d' | sed '$d' | sed '$d' | sed '$d' | sed '$d' | sed '$d' \
# | awk '{print $1}' > pattern.txt
# 
# grep -vf pattern.txt systemd-extract.txt | tee r.txt
# grep -vf pattern.txt systemd-extract.txt | awk '{print $1}'



##### unarchive ##### 
rm -rf ../test-private_isu/webapp/ && \
tar zxvfp ./files/fetch/webapp.tar.gz -C ../test-private_isu/ && \
mv ../test-private_isu/home/isucon/private_isu/webapp ../test-private_isu/ && \
rm -rf ../test-private_isu/home/



#### log list ####
# pt-query-digest
SELECT * FROM `comments` WHERE `post_id` = 9989 ORDER BY `created_at` DESC LIMIT 3\G
SELECT * FROM `comments` WHERE `post_id` = 2847 ORDER BY `created_at` DESC\G

# app.go
func makePosts(
	for _, p := range results {
		err := db.Get(&p.CommentCount, "SELECT COUNT(*) AS `count` FROM `comments` WHERE `post_id` = ?", p.ID)

		query := "SELECT * FROM `comments` WHERE `post_id` = ? ORDER BY `created_at` DESC"
		if !allComments {
			query += " LIMIT 3"
		}
# > SELECT COUNT(*) AS `count` FROM `comments` WHERE `post_id` = ?
# > SELECT * FROM `comments` WHERE `post_id` = ? ORDER BY `created_at` DESC
### ? は、変数のようなもので、クエスチョン・パラメタと呼ばれ、標準SQLでも規定されている
### prepareし、実行時はexecute文で値を入れる。


vmstat -S M


### bench result memo ###

### pprof
# getImage: Get
# getIndex: Select

### netdata
# "score": 34156,
# cpu: About 95%
# mem: About 75%
# cpu:
#   sql: About 50%, 
#   other: About 50%
# mem:
#   sql: About 70%

### slow query log
# Rank Query ID                       Response time Calls R/Call V/M   Ite
# ==== ============================== ============= ===== ====== ===== ===
#    1 0x4858CF4D8CAA743E839C127C7... 34.7091 58.7%  1193 0.0291  0.01 SELECT posts
SELECT `id`, `user_id`, `body`, `mime`, `created_at` FROM `posts` ORDER BY `created_at` DESC\G

mysql --defaults-file=/etc/mysql/my.cnf -h 127.0.0.1 -P 3306 isuconp
SELECT count(id), count(user_id), count(body), count(mime), count(created_at) FROM `posts` ORDER BY `created_at` DESC\G

mysql> SELECT count(id) FROM posts;
+-----------+
| count(id) |
+-----------+
|     10113 |
+-----------+

mysql> SELECT count(id) FROM comments;
+-----------+
| count(id) |
+-----------+
|    100142 |
+-----------+



# prompt

「MySQLに格納しておきながらもCache上にも持たせてページ表示のときはCacheのデータを見る」
の実装を教えて

※以下、条件とする
・キャッシュするクエリは以下とする
"SELECT `id`, `user_id`, `body`, `mime`, `created_at` FROM `posts` ORDER BY `created_at` DESC"
・Go言語を使用
・Redisを使用
・ソースコードのみを提示
・構造体"Post"は以下とする。
type Post struct {
	ID           int       `db:"id"`
	UserID       int       `db:"user_id"`
	Imgdata      []byte    `db:"imgdata"`
	Body         string    `db:"body"`
	Mime         string    `db:"mime"`
	CreatedAt    time.Time `db:"created_at"`
	CommentCount int
	Comments     []Comment
	User         User
	CSRFToken    string
}


# Go言語　落とし穴　まとめ
https://qiita.com/tutuz/items/fedb8e3a1137d046f418


# mysql on mem
https://dev.mysql.com/doc/refman/8.0/ja/memory-use.html




redis実装できた
スコアは落ちた
redis-cli --stat

# レイテンシ測定
redis-cli --latency -h `localhost` -p `6379`



https://qiita.com/Fea/items/4d628d7ab31150809502

https://smot93516.hatenablog.jp/entry/2021/08/04/132454



# N+1 （かなりスコアに関わるよう）
# 参考おすすめ
https://scrapbox.io/mkizka/isucon%E7%B7%B4%E7%BF%92%E8%A8%98_private-isu
https://qiita.com/muroya2355/items/d4eecbe722a8ddb2568b
https://tech.classi.jp/entry/2021/12/23/133000


# er 
# SchemaSpy ローカルで用意
https://bmf-tech.com/posts/DB%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88%EF%BC%88ER%E5%9B%B3%E3%81%AA%E3%81%A9%EF%BC%89%E3%82%92%E8%87%AA%E5%8B%95%E7%94%9F%E6%88%90%E3%81%97%E3%81%A6%E3%81%8F%E3%82%8C%E3%82%8B%E3%83%84%E3%83%BC%E3%83%AB%E3%83%BCschemaspy,%20tbls
https://qiita.com/zackey2/items/b6d637eff56dfaca1ec6
https://zenn.dev/onozaty/articles/schema-spy-er


データ分析　データの種類
# データ型の比較記事
https://meetsmore.com/product-services/databases/media/99426
# データの基本
https://www.stat.go.jp/naruhodo/4_graph/data.html



必要最低限のデータを取得、保存
結局スコアに響くのはデータ処理の改善
https://isucon.net/archives/56082639.html
・limit   不要な行を取得するクエリの改善
・levelカラムの追加   不要な行を取得するクエリの改善
・N+1
・index
・created_at, DESC
・アプリ側のログ出力コードを排除


帯域幅確認: ifstat

# TASK
ネットワーク, DISK I/O
◆k6, ab
計測CLIツール色々インストール perf ifstat dstat .etc



#
・bulk insert、bulk update
・静的ファイルをブラウザで保存
・cookie, sticky (セッション維持)
・index作成すると更新処理に負荷
・explain, plan で高速化を分析できる
・複合index
・sharding
・内部結合、外部結合、外部キー
・複合主キー

