# OpenFPGAduino
All open source files and projects for OpenFPGAduino project

Official web site includes document and video demo

      http://openfpgaduino.github.io

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

