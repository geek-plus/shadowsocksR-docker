FROM ubuntu:16.04
#激进点的发行版
MAINTAINER slanterns <slanterns.w@gmail.com>

#当心缓存机制
RUN apt update \
    && apt upgrade -y \
    && apt install m2crypto python3 -y


RUN ["mkdir", "shadowsocksR"]

#编译配置文件生成器
COPY configurer.pas /shadowsocksR/
RUN apt install fpc -y \
    && fpc /shadowsocksR/configurer.pas \
    && apt remove fpc -y \
    && apt autoremove -y

#编译libsodium
ADD libsodium-1.0.10.tar.gz /shadowsocksR/
RUN apt install build-essential -y \
    && cd /shadowsocksR/libsodium-1.0.10 \
    && ./configure \
    && make -j2 \
    && make install \
    && ldconfig \
    && apt remove build-essential -y \
    && apt autoremove -y

#获取源代码
RUN apt install git -y \
    && cd shadowsocksR \
    && git clone -b manyuser https://github.com/breakwa11/shadowsocks.git \
    && apt remove git -y \
    && apt autoremove -y

#服务端配置
COPY run.sh /
RUN ["chmod", "+x", "run.sh"]
EXPOSE 443

CMD ./run.sh

#Thank clowwindy,breakwa11 and all other shadowsocks project maintains.
#Thank PeterCxy.
