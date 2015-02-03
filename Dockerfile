FROM lizhizhou/openfpgaduino
MAINTAINER Zhizhou Li

RUN git clone --recursive https://github.com/OpenFPGAduino/OpenFPGAduino.git
#ADD app.js /var/www/app.js
RUN cd OpenFPGAduino
RUN ./configure
RUN make

