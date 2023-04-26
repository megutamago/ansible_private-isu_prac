##### pprof #####

# Graph requirements ?????
apt install -y graphviz

# trace
curl -o trace.out http://localhost:6060/debug/pprof/trace?seconds=60
go tool trace -http=localhost:1080 trace.out

# profile
#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\
curl -o cpu.pprof http://localhost:6060/debug/pprof/profile?seconds=60
go tool pprof -http localhost:1080 cpu.pprof
#(go tool pprof -http localhost:1080 cpu.pprof) &   # bg
#kill -9 $(ps aux | grep 'go tool pprof -http localhost:1080 cpu.pprof' | grep -v grep | awk '{print $2}')
http://192.168.11.31:1080/
#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\


# 名前	意味
#
# Flat	関数の処理時間
# Flat%	各Flatの全体に対する割合
# Sum%	スタック履歴からの累計Flat%
# Cum	待ち時間も含めた処理時間
# Cum%	各Cumの全体に対する割合
# Name	関数の名前




