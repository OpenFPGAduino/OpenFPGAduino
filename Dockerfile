FROM lizhizhou/openfpgaduino
MAINTAINER Zhizhou Li <lzz@meteroi.com>
RUN  apt-get update && apt-get -y upgrade 
RUN apt-get install -y libcurl4-gnutls-dev
RUN apt-get install -y debootstrap
RUN apt-get install -y qemu
RUN npm install -g gitbook-cli
RUN ln -s /usr/bin/nodejs /usr/bin/node
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/gcc/bin:/altera/12.1sp1/quartus/bin:/altera/12.1sp1/quartus/sopc_builder/bin
RUN rm -rf /var/lib/apt/lists/*
RUN git clone --recursive https://github.com/OpenFPGAduino/OpenFPGAduino.git
RUN cd OpenFPGAduino; ./configure; make clean; make
