FROM ubuntu:bionic

RUN apt update
RUN apt install -y clang
RUN apt install -y git
RUN apt install -y cmake
RUN apt install -y wget

RUN wget https://boostorg.jfrog.io/artifactory/main/release/1.77.0/source/boost_1_77_0.tar.bz2
RUN tar -xjf boost_1_77_0.tar.bz2 boost_1_77_0/boost

ENV CC=/usr/bin/clang
ENV CXX=/usr/bin/clang++
ENV BOOST_ROOT=/boost_1_77_0

RUN git clone https://github.com/vcoppe/Continuous-CBS.git
RUN git clone https://github.com/vcoppe/mapf-runner.git

WORKDIR /mapf-runner

CMD ["./launch.sh"]
