FROM ubuntu:xenial
MAINTAINER slanterns <slanterns.w@gmail.com>

RUN apt update
RUN apt upgrade -y
#当心缓存机制

#基本库安装
RUN apt install m2crypto git -y
RUN apt install build-essential -y
ADD libsodium-1.0.10.tar.gz /
RUN cd libsodium-1.0.10 && ./configure && make -j2 && make install && ldconfig
#经验：要记住，上一行的cd对下一行毫无用处，会重新运行上一行所提交的镜像，于是又回到/了

#获取源代码
RUN mkdir shadowsocksR
RUN cd shadowsocksR && git clone -b manyuser https://github.com/breakwa11/shadowsocks.git

#服务端配置
COPY configurer /shadowsocksR/
COPY run.sh /
RUN chmod +x run.sh
EXPOSE 443

CMD ["./run.sh"]

#Thank clowwindy,breakwa11,PeterCxy and all other shadowsocks project maintains.
