FROM openfpgaduino/openfpgaduino
MAINTAINER Zhizhou Li <lzz@meteroi.com>
RUN  apt-get update && apt-get -y upgrade 
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN rm -rf /var/lib/apt/lists/*
RUN git clone --recursive https://github.com/OpenFPGAduino/OpenFPGAduino.git
RUN cd OpenFPGAduino; ./configure; make clean; make
