var
password,method,protocol,obfs,redirect,dns_ipv6:string;
begin
assign(output,'/shadowsocksR/shadowsocks/shadowsocks/shadowsocks.json');
rewrite(output);      //1、防止反复在文件尾写入；2、防止环境变量更改后配置文件不改变；
//以下均不能读入空串！（输入一个空串=未输入）
readln(password);     //e.g. mypassword
readln(method);       //e.g. aes-256-cfb
readln(protocol);     //e.g. auth_sha1
readln(obfs);         //e.g. tls1.2_ticket_auth
readln(redirect);     //e.g. 值为空字符串或一个列表，若为列表示例如"redirect":["bing.com", "cloudflare.com:443"],示例:"bing.com", "cloudflare.com:443"或"";作用是在连接方的数据不正确的时候，把数据重定向到列表中的其中一个地址和端口（不写端口则视为80），以伪装为目标服务器。即使不使用重定向，也要填写""
readln(dns_ipv6);     //e.g. true or false
writeln('{');
writeln('    "server": "0.0.0.0",');
writeln('    "server_ipv6": "::",');
writeln('    "server_port": 443,');
writeln('    "local_address": "127.0.0.1",');
writeln('    "local_port": 1080,');
writeln('    "password": "',password,'",');
writeln('    "timeout": 120,');
writeln('    "method": "',method,'",');
writeln('    "protocol": "',protocol,'",');
writeln('    "protocol_param": "",');
writeln('    "obfs": "',obfs,'",');
writeln('    "obfs_param": "",');
writeln('    "redirect": ',redirect,',');
writeln('    "dns_ipv6": ',dns_ipv6,',');
writeln('    "fast_open": false,');
writeln('    "workers": 1');
write('}');
end.
