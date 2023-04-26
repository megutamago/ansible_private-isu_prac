
### SQL ### ######################################################################
・スキーマの書き出し方 → sqlファイルを初期化まで自動化?
・インデックス貼り方　　# https://qiita.com/mamy1326/items/9c5eaee3c986cff65a55#-index-%E3%82%92%E8%BF%BD%E5%8A%A0
・クエリに limit をつける (GET /api/trend)

# MySQLデータベースのパフォーマンスチューニング
・https://qiita.com/mm-Genqiita/items/3ef91f6df6c15c620ec6
# [解説] SQLクエリのN+1問題
・https://qiita.com/muroya2355/items/d4eecbe722a8ddb2568b
# N+1問題がなんもわからんというだけの記事
・https://zenn.dev/kinzal/articles/c5745e7d9a950c

# isucon
・https://isucon.net/archives/55025156.html
MySQL 5.7 では単純に index を貼っても効きません。
MySQL 8 にしても良いのですが、単純に実施してしまうと 設定の違いにより、パフォーマンスが劣化することもあります。
>ミドルウェアのバージョン確認も必要
・不要な行を取得するクエリの改善

# 最強そう↓
# [ISUCON用メモ] MySQL
・https://qiita.com/stomk/items/6265e9fdfdfb4f104a7e

# MySQLパフォーマンスチューニング -my.cnfの見直し-
・https://qiita.com/mamy1326/items/9c5eaee3c986cff65a55

〇Redis, Memcached



### ? ### ######################################################################
・CPU リソースが足りない問題を複数台を使うことで改善
　　1:APサーバ, 2:DBサーバ, 3:余り
　　localhost以外からの接続を受け入れるようにする
　　DBの接続先をDBサーバーに変更する
・CPU リソースが余る問題を改善
　　dropProbability を下げるだけですが、今回は0に設定したときが一番点が高かったため、コード自体を削除する実装にしました。
・アプリ側のログ出力を止める




### Cheet Sheet ### ######################################################################
https://hi120ki.github.io/isucon/
https://gist.github.com/south37/d4a5a8158f49e067237c17d13ecab12a




### カーネルパラメータ ### 神 ######################################################################
Linuxカーネルパラメータのチューニング
https://qiita.com/ryuichi1208/items/3bb7a270fe650b2f7260




### Ref ### ######################################################################
https://github.com/catatsuy/private-isu/tree/master/webapp/ruby
https://github.com/mazrean/isucon-go-tools
https://trap.jp/post/1631/

WordPressを爆速にするnginxのproxyキャッシュを冗長化しても共通で利用できるようにするアーキテクチャ(OpenResty+Redis)のご紹介
https://www.seeds-std.co.jp/blog/creators/2020-04-13-103051/

一歩踏み込んだnginxのプロファイリングをする
https://serinuntius.hatenablog.jp/entry/2018/08/28/213826#%E4%B8%80%E7%95%AA%E6%89%8B%E8%BB%BD%E3%81%A7%E4%B8%87%E8%83%BD%E3%81%AAstrace



### Other ### ######################################################################
・OS情報取得するタスク作る 最初にやる用
　　osバージョン、カーネル、ミドルウェアバージョン、スペックなど。

・アプリケーション側でデータをキャッシュ
query_cache_size
query_cache_type


〇キャッシュなに？
〇チューニング箇所まとめて、よさげな値の設定自動化するかどうか
〇isucon本買う. 電子で。（電子書籍amazonで買うとき注意があった）

〇SQL, Nginx, Kernel, パラメータチューニング自動化手法を調査

　・SQL: MySQL診断ツール (MySQL Tuner)
　　https://github.com/major/MySQLTuner-perl

# ISUCON9 予選の過去問で予選突破スコアを出すまで練習 (スコア時系列)
https://ohbarye.hatenablog.jp/entry/2020/07/24/isucon9-practice


↓あんま見る必要ない。時間の無駄
########## 
# Reference
Kernel: https://github.com/torvalds/linux/tree/v4.15/Documentation/sysctl
Nginx: http://nginx.org/en/docs/
  Module ngx_http_upstream_module: http://nginx.org/en/docs/http/ngx_http_upstream_module.html
MySQL: https://dev.mysql.com/doc/
　MySQL 8.0 リファレンスマニュアル: https://dev.mysql.com/doc/refman/8.0/ja/
　　バーティショニングのタイプ: https://dev.mysql.com/doc/refman/8.0/ja/partitioning-types.html




#### 自分なりまとめ ######################################################################
SQLについては、

Nginxについては、プラグインよくわからん

カーネルについては、何とかなりそう

キャッシュについては、どこに使うかよくわからん

その他については、

〇思うに、大事なのは、負荷がかかるレイヤーに対処していく感じ？ぽい
だいたいmysqlが負荷多い。
sqlの改善すると、他のボトルネックが見えるのかな？？

〇まず初めは、コードを修正する以外を試していこう！

キーワード：インメモリ、インデックス、

〇なんとなく、色々パラメータチューニングしたらそれでも少し伸びそう

