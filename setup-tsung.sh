#!/bin/bash
sudo apt-get update && \
    sudo apt-get -y install wget \
    build-essential debhelper \
    erlang-nox erlang-dev \
    python-matplotlib gnuplot \
    libtemplate-perl \
    autoconf
git clone https://github.com/processone/tsung.git \
    cd tsung && ./configure && make && sudo make install

mkdir /tmp/consul
sudo mkdir /etc/consul.d
