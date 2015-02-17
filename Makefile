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
all:
	echo "Build submodule linux";     	
	cd linux; make zImage; cd ..;
	@for module in `ls -l | grep ^d | awk '{ print $$NF }' | sed 's/linux//g'`; do \
	echo "Build submodule "$$module;                                               \
	cd $$module; make; cd .. ;                                                     \
	done
clean:
	@for module in `ls -l | grep ^d | awk '{ print $$NF }'`; do                    \
	echo "Build submodule "$$module;                                               \
	cd $$module; make clean ; cd .. ;                                              \
	done

image:
	#boot partition
	cp -rf boot/ sdcard/boot
	cp -rf linux/arch/arm/boot/zImage sdcard/boot
	cp -rf fpga/ouput/grid.rbf sdcard/boot
	#linux partition
	cp -rf driver/openfpgaduino.ko rootfs/fs/home/
	cp -rf node/node rootfs/fs/bin/
	cp -rf ArduinoIDE rootfs/fs/home/
	cp -rf libAduino/libaduino.a rootfs/fs/home/ArduinoIDE/api/
	cp -rf libAduino/api/openfpgaduino.h rootfs/fs/home/ArduinoIDE/api/
	cp -rf Arduinojs/build/Release/openfpgaduino rootfs/fs/home/ArduinoIDE/
	cp 

