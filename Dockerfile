FROM ubuntu:xenial
MAINTAINER slanterns <slanterns.w@gmail.com>

RUN apt update
RUN apt upgrade -y
#当心缓存机制

#基本库安装
RUN apt install m2crypto git -y
RUN apt install build-essential -y
ADD https://github.com/jedisct1/libsodium/releases/download/1.0.10/libsodium-1.0.10.tar.gz /
RUN cd libsodium-1.0.10
RUN ./configure && make -j2 && make install
RUN ldconfig

#获取源代码
RUN cd ..
RUN mkdir shadowsocksR && cd shadowsockR
RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git

#服务端配置
COPY configurer run.sh /shadowsocksR/
RUN chmod +x run.sh

CMD ["./run.sh"]

#Thank clowwindy,breakwa11,PeterCxy and all shadowsocks project maintains.
