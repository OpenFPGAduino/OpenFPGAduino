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
