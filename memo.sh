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
# http://192.168.11.31:1080/
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
| alp ltsv -m '/image/[0-9]+,/posts/[0-9]+' \
--sort avg -r -o count,1xx,2xx,3xx,4xx,5xx,min,max,avg,sum,p99,method,uri



# pt-query-digest
pt-query-digest /var/log/mysql/mysql-slow.sql



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

