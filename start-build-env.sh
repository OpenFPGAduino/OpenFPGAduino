docker pull openfpgaduino/openfpgaduino:v2.0
docker run --rm=true --env-file=docker_env --privileged -i -t \
  -v "${PWD}:/home/" \
  -w "/home/" \
  --dns=114.114.114.114 \
  openfpgaduino/openfpgaduino:v2.0
