
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



# Recent
・bulk insert、bulk update
・静的ファイルをブラウザで保存
　→Success: [その他ツール] - [デベロッパーツール] - [Network] - [クリック] (右画面 Timeが0になる)
・cookie, sticky (セッション維持)
・index作成すると更新処理に負荷
・explain, explain plan でボトルネックを分析できる (実行計画)
  https://qiita.com/Stuffy86/items/809540b73cacde951997
  https://cosol.jp/techdb/2020/04/how_to_read_oracle_sql_execution_plan/
・複合index
・sharding
・内部結合、外部結合、外部キー
・複合主キー
・ディスクI/Oが高ければ、MySQLのバッファプールを増やしたり、クエリ改善



INSERT や UPDATE などの書き込みがないテーブルをメモリに載せます。 
書き込みがあるテーブルもメモリに載せることは不可能ではありませんが、排他制御が必要になり複雑になります。 
また、DB ではリレーションについても考える必要があります。
https://kotaroooo0-dev.hatenablog.com/entry/onmemory_isucon

https://logmi.jp/tech/articles/326996

https://gihyo.jp/dev/feature/01/redis/0003

# session
https://www.nginx.com/resources/wiki/modules/redis/
https://zenn.dev/ajapa/articles/b5a85592f9fc86
https://github.com/rbcervilla/redisstore
https://yhidetoshi.hatenablog.com/entry/2022/04/02/144714


Webサイトでセッション情報をオンメモリ化する場合、以下のような流れでクライアント間の通信が行われます。
1.ユーザーがWebサイトにアクセスすると、Webサーバーはユーザーのブラウザに一意のセッションIDを割り当てます。このセッションIDは、ブラウザにクッキーとして保存されます。
2.ユーザーがWebサイトを操作すると、ブラウザはWebサーバーに対してHTTPリクエストを送信します。このリクエストには、セッションIDが含まれています。
3.Webサーバーは、セッションIDに基づいて、セッション情報をオンメモリのキャッシュから取得します。
4.Webサーバーは、取得したセッション情報を使用して、リクエストに対するレスポンスを生成します。
5.レスポンスには、必要に応じて新しいセッションIDが含まれる場合があります。これは、セッション情報を更新するために必要な場合です。
6.ブラウザは、受信したレスポンスを解釈し、必要に応じて新しいセッションIDを保存します。また、必要に応じて次のリクエストでセッションIDを使用します。
7.以降、ユーザーがWebサイトを操作するたびに、セッションIDがブラウザからWebサーバーに送信され、Webサーバーはセッション情報をオンメモリのキャッシュから取得して、レスポンスを生成します。
以上のように、セッション情報をオンメモリ化する場合、セッションIDに基づいてセッション情報を取得することが重要になります。また、セッション情報の有効期限を管理することも重要です。