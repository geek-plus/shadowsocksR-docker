FROM ubuntu:16.04
MAINTAINER slanterns <slanterns.w@gmail.com>

RUN apt update \
    && apt upgrade -y \
    && apt install m2crypto -y

#编译配置文件生成器
#编译libsodium
RUN ["mkdir", "shadowsocksR"]
COPY configurer.pas /shadowsocksR/
ADD libsodium-1.0.10.tar.gz /shadowsocksR/
RUN apt install fpc build-essential -y \
    && fpc /shadowsocksR/configurer.pas \
    && cd /shadowsocksR/libsodium-1.0.10 \
    && ./configure \
    && make -j2 \
    && make install \
    && ldconfig \
    && apt remove fpc build-essential -y \
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
