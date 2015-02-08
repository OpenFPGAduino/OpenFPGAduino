FROM lizhizhou/openfpgaduino
MAINTAINER Zhizhou Li
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/gcc/bin:/altera/12.1sp1/quartus/bin:/altera/12.1sp1/quartus/sopc_builder/bin
RUN git clone --recursive https://github.com/OpenFPGAduino/OpenFPGAduino.git
RUN cd OpenFPGAduino; ./configure; make clean; make