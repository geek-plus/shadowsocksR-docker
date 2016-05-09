#!/bin/bash

echo -e "$password\n$method\n$protocol\n$obfs" | /shadowsocksR/configurer
#此实现：每一项后换行，在程序中使用readln(); readln();...readln(); 读入；
#另一种实现：每一项后空格，程序中使用read()；读入一个长字符串，再根据空格处理出每一项。

python /shadowsocksR/shadowsocks/shadowsocks/server.py -c /shadowsocksR/shadowsocks/shadowsocks/shadowsocks.json
