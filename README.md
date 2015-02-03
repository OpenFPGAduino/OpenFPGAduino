# OpenFPGAduino
All open source file and project for OpenFPGAduino project
Prepare the Build environment
      Install the docker: https://docs.docker.com/installation/#installation
      Download the Build environment: 
	sudo docker pull lizhizhou/openfpgaduino
      Run the environment and open the shell:
	sudo docker run -i -t lizhizhou/openfpgaduino
      Pull the view:
	git clone --recursive https://github.com/OpenFPGAduino/OpenFPGAduino.git

Build all:
      ./configure
      make 
