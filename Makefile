export HOST:=arm-none-linux-gnueabi
export CPP:="$(HOST)-gcc -E" 
export STRIP:="$(HOST)-strip" 
export OBJCOPY:="$(HOST)-objcopy" 
export AR:="$(HOST)-ar" 
export RANLIB:="$(HOST)-ranlib" 
export LD:="$(HOST)-ld" 
export OBJDUMP:="$(HOST)-objdump" 
export CC:="$(HOST)-gcc" 
export CXX:="$(HOST)-g++" 
export NM:="$(HOST)-nm" 
export AS:="$(HOST)-as"
all:build image web
build:
	echo "Build submodule linux";     	
	cd linux; make ; cd ..;
	@for module in `ls -l | grep ^d | awk '{ print $$NF }' | sed 's/linux//g'`; do \
	echo "Build submodule "$$module;                                               \
	cd $$module; make; cd .. ;                                                     \
	done
clean:
	@for module in `ls -l | grep ^d | awk '{ print $$NF }'`; do                    \
	echo "Clean submodule "$$module;                                               \
	cd $$module; make clean ; cd .. ;                                              \
	done

format:
	@for module in `ls -l | grep ^d | awk '{ print $$NF }'`; do                    \
	echo "Format submodule "$$module;                                              \
	cd $$module; make format ; cd .. ;                                             \
	done

image:
	#boot partition
	cp -rpf boot/boot.bin sdcard/boot/
	cp -rpf boot/kcmd.txt sdcard/boot/
	cp -rpf linux/arch/arm/boot/zImage sdcard/boot/
	cp -rpf fpga/output/grid.rbf sdcard/boot/
	#linux partition
	cd linux; sudo make INSTALL_MOD_PATH=../rootfs/fs modules_install; cd ..;
	sudo mkdir -p rootfs/fs/lib/modules/3.4.18+/openfpgaduino
	sudo cp -rpf driver/openfpgaduino.ko rootfs/fs/lib/modules/3.4.18+/openfpgaduino/
	sudo bash -c "echo openfpgaduino >> rootfs/fs/etc/modules"
	sudo depmod -b rootfs/fs/ 3.4.18+
	#sudo cp -rpf node/out/Release/node rootfs/fs/bin/
	cd node; make install; cd ..;
	##Hack for nodejs path issue
	sudo grep -rl --binary-files=without-match '../rootfs/fs/' ./rootfs/fs/ | xargs sed -i 's/\.\.\/rootfs\/fs\//\//g'
	sudo cp -rpf ArduinoIDE rootfs/fs/home/openfpgaduino/
	sudo cp -rpf FPGAdesigner rootfs/fs/home/openfpgaduino/
	sudo cp -rpf libAduino/lib/libaduino.a rootfs/fs/home/openfpgaduino/ArduinoIDE/api/
	sudo cp -rpf libAduino/lib/libaduino.so rootfs/fs/lib/
	sudo cp -rpf libAduino/lib/openfpgaduino.h rootfs/fs/home/openfpgaduino/ArduinoIDE/api/
	sudo cp -rpf Arduinojs rootfs/fs/home/openfpgaduino/Arduinojs
	sudo cp -rpf docs/_book rootfs/fs/home/openfpgaduino/ArduinoIDE/docs
	sudo cp -rpf script/cide.service rootfs/fs/lib/systemd/system/
	sudo cp -rpf script/fpgaide.service rootfs/fs/lib/systemd/system/
	sudo cp -rpf script/arduino.service rootfs/fs/lib/systemd/system/
	sudo chroot rootfs/fs/ systemctl enable cide
	sudo chroot rootfs/fs/ systemctl enable fpgaide
	sudo chroot rootfs/fs/ systemctl enable arduino
	sudo cp -rpf script/fpga_config.sh rootfs/fs/home/openfpgaduino/ArduinoIDE/
	sudo cp -rpf script/fpga_config.sh rootfs/fs/home/openfpgaduino/Arduinojs/
	sudo chroot rootfs/fs chown -R openfpgaduino /home/openfpgaduino

web:
	cp -rf docs/_book OpenFPGAduino.github.io/docs

update:
	git pull --recurse-submodules
	@for module in `ls -l | grep ^d | awk '{ print $$NF }'`; do                    \
	echo "Update submodule "$$module;                                              \
	git submodule update $$module;                                                 \
	cd $$module; git pull ; cd .. ;                           \
	done

master:
	@for module in `ls -l | grep ^d | awk '{ print $$NF }' | sed 's/node//g'`; do  \
	echo "Checkout master"$$module;                                                \
	cd $$module; git checkout master; git pull ; cd .. ;                           \
	done
