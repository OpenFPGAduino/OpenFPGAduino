docker pull openfpgaduino/openfpgaduino
docker run --rm=true --privileged -i -t \
  -v "${PWD}:/home/" \
  -w "/home/" \
  openfpgaduino/openfpgaduino
