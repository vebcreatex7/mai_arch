FROM ubuntu:20.04
ENV TZ=Europe/Moscow

RUN apt-get clean && apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install \
    tzdata git sudo build-essential autoconf libtool libssl-dev zlib1g-dev librdkafka-dev pkg-config cmake gcc git g++ mysql-client libmysqlclient-dev libboost-all-dev libssl-dev && \
    apt-get clean

RUN git clone -b master https://github.com/pocoproject/poco.git && \
    mkdir poco/cmake-build && \
    cd poco/cmake-build && \
    cmake .. && \
    make -j$(( $(nproc) - 1 )) && \
    sudo make install && \
    cd ../..

RUN git clone https://github.com/tdv/redis-cpp.git && \
    mkdir redis-cpp/build && \
    cd redis-cpp/build && \
    cmake .. && \
    make && \
    sudo make install && \
    cd ../..

RUN git clone https://github.com/edenhill/librdkafka.git && cd librdkafka && ./configure && make && sudo make install && cd ..
RUN git clone https://github.com/mfontanini/cppkafka && cd cppkafka && mkdir build && cd build && cmake .. && make && sudo make install && cd .. && cd ..

WORKDIR /app
COPY ./ ./

RUN ldconfig
RUN mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(( $(nproc) - 1 ))

ENTRYPOINT [ "/app/build/auth_service" ]
