docker pull openfpgaduino/openfpgaduino:v1.0
docker run --rm=true --env-file=docker_env --privileged -i -t \
  -v "${PWD}:/home/" \
  -w "/home/" \
  openfpgaduino/openfpgaduino:v1.0
