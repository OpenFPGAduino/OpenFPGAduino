#docker pull openfpgaduino/openfpgaduino
docker run --rm=true --env-file=docker_env --privileged -i -t \
  -v "${PWD}:/home/" \
  -w "/home/" \
  openfpgaduino/openfpgaduino
