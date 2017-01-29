# OpenFPGAduino
All open source files and projects for OpenFPGAduino project

Official web site includes document and video demo

http://openfpgaduino.github.io

The live demo

http://v.youku.com/v_show/id_XOTQ3MjkxNzU2.html?from=y1.7-1.2

http://v.youku.com/v_show/id_XMTU3MTUzNTM4OA==.html?spm=a2hzp.8253869.0.0

http://v.youku.com/v_show/id_XMTg4MjgyMDU4MA==.html?spm=a2hzp.8253869.0.0

https://www.youtube.com/watch?v=jsjrgsI-3QM

https://www.youtube.com/watch?v=g4E1hoc72DY


Prepare the Build environment

      Install the docker: https://docs.docker.com/installation/#installation

      Pull the view:
      
      git clone --recursive https://github.com/OpenFPGAduino/OpenFPGAduino.git

      Run the script to prepare the build environment
      
      cd OpenFPGAduino
      
      ./start-build-env.sh

Build all:

      In the container build all the source code:

      ./configure

      make



