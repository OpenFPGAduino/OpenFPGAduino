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
	@for module in `ls -l | grep ^d | awk '{ print $$NF }' | sed 's/linux//g' | sed 's/bigdata//g' | sed 's/sdn//g'`; do \
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
	rsync -ar boot/boot.bin sdcard/boot/
	rsync -ar boot/kcmd.txt sdcard/boot/
	rsync -ar linux/arch/arm/boot/zImage sdcard/boot/
	rsync -ar fpga/output/grid.rbf sdcard/boot/
	#linux partition
	cd linux; sudo env PATH=$(PATH) make INSTALL_MOD_PATH=../rootfs/fs modules_install; cd ..;
	sudo mkdir -p rootfs/fs/lib/modules/3.4.18+/openfpgaduino
	sudo rsync -ar driver/openfpgaduino.ko rootfs/fs/lib/modules/3.4.18+/openfpgaduino/
	sudo bash -c "echo openfpgaduino >> rootfs/fs/etc/modules"
	sudo depmod -b rootfs/fs/ 3.4.18+
	#sudo rsync -ar node/out/Release/node rootfs/fs/bin/
	cd node; sudo env PATH=$(PATH) make install; cd ..;
	##Hack for nodejs path issue
	sudo sed -i 's/\.\.\/rootfs\/fs\//\//g' rootfs/fs/lib/node_modules/npm/bin/npm-cli.js
	sudo sed -i 's/\.\.\/rootfs\/fs\//\//g' rootfs/fs/include/node/config.gypi	
	sudo rsync -ar ArduinoIDE rootfs/fs/home/openfpgaduino/
	sudo rsync -ar FPGAdesigner rootfs/fs/home/openfpgaduino/
	sudo rsync -ar libAduino/lib/libaduino.a rootfs/fs/home/openfpgaduino/ArduinoIDE/api/
	sudo rsync -ar libAduino/lib/libaduino.so rootfs/fs/lib/
	sudo rsync -ar libAduino/lib/openfpgaduino.h rootfs/fs/home/openfpgaduino/ArduinoIDE/api/
	sudo rsync -ar Arduinojs rootfs/fs/home/openfpgaduino/
	sudo rsync -ar ArduinojsIDE rootfs/fs/home/openfpgaduino/Arduinojs/page/jside
	sudo rsync -ar BlocklyIDE/blocklyide rootfs/fs/home/openfpgaduino/Arduinojs/page/
	sudo rsync -ar MobileApp/ionic/ionic/www rootfs/fs/home/openfpgaduino/Arduinojs/page/mobile
	sudo rsync -ar docs/_book rootfs/fs/home/openfpgaduino/ArduinoIDE/docs
	sudo rsync -ar script/cide.service rootfs/fs/lib/systemd/system/
	sudo rsync -ar script/fpgaide.service rootfs/fs/lib/systemd/system/
	sudo rsync -ar script/arduino.service rootfs/fs/lib/systemd/system/
	sudo chroot rootfs/fs/ systemctl enable cide
	sudo chroot rootfs/fs/ systemctl enable fpgaide
	sudo chroot rootfs/fs/ systemctl enable arduino
	sudo rsync -ar script/fpga_config.sh rootfs/fs/home/openfpgaduino/ArduinoIDE/
	sudo rsync -ar script/fpga_config.sh rootfs/fs/home/openfpgaduino/Arduinojs/
	sudo chroot rootfs/fs chown -R openfpgaduino /home/openfpgaduino/
	cd sdcard; sudo env PATH=$(PATH) make image; cd ..

web:
	rsync -ar docs/_book/ OpenFPGAduino.github.io/docs
	rsync -ar BlocklyIDE/blocklyide OpenFPGAduino.github.io/

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
