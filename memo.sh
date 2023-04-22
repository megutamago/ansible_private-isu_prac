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
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:8080:192.168.11.41:80 192.168.11.44' | awk '{print $2}' | sed '$d')
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:19999:192.168.11.41:19999 192.168.11.44' | awk '{print $2}' | sed '$d')
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:1080:localhost:1080 192.168.11.41' | awk '{print $2}' | sed '$d')
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:9100:192.168.11.41:9100 192.168.11.41' | awk '{print $2}' | sed '$d')
kill $(ps aux | grep 'ssh -fN -L 0.0.0.0:3100:192.168.11.41:3100 192.168.11.41' | awk '{print $2}' | sed '$d')
ps aux | grep ssh




##### pprof #####

# Graph requirements ?????
apt install -y graphviz

# trace
curl -o trace.out http://localhost:6060/debug/pprof/trace?seconds=60
go tool trace -http=localhost:1080 trace.out
# profile
#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\
curl -o cpu.pprof http://localhost:6060/debug/pprof/profile?seconds=60
go tool pprof -http=localhost:1080 cpu.pprof
http://192.168.11.31:1080/
#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\




### mysql ###
mysql -u isuconp -pisuconp
# > isuconp
SHOW DATABASES;
use isuconp;
use mysql;
SHOW TABLES;



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



# alp
cat /var/log/nginx/access.log | alp ltsv -m '/image/[0-9]+,/posts/[0-9]+' --sort avg -r -o count,1xx,2xx,3xx,4xx,5xx,min,max,avg,sum,p99,method,uri



##### systemd #####

※./files/pattern.sh
systemctl list-units --all --type=service | grep -v inactive > systemd-extract.txt 
systemctl list-units --all --type=service | grep -v inactive \
| sed '1d' | sed '$d' | sed '$d' | sed '$d' | sed '$d' | sed '$d' \
| awk '{print $1}' > pattern.txt

grep -vf pattern.txt systemd-extract.txt | tee r.txt
grep -vf pattern.txt systemd-extract.txt | awk '{print $1}'



##### unarchive ##### 
rm -rf ../test-private_isu/webapp/ && \
tar zxvfp ./files/fetch/webapp.tar.gz -C ../test-private_isu/ && \
mv ../test-private_isu/home/isucon/private_isu/webapp ../test-private_isu/ && \
rm -rf ../test-private_isu/home/
