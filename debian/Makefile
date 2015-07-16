MODULES = liblog libcutils libzipfile adb fastboot

build: $(MODULES)

$(MODULES):
	make -C $@ -f ../../debian/$@.mk

clean:
	$(foreach module, $(MODULES), make clean -C $(module) -f ../../debian/$(module).mk)