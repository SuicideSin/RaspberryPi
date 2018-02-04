#!/bin/sh

SYSROOT_HOST=raspberrypi

if [ ! -d "sysroot" ]; then
	mkdir sysroot
fi
if [ ! -d "sysroot/usr" ]; then
	mkdir sysroot/usr
fi
if [ ! -d "sysroot/opt" ]; then
	mkdir sysroot/opt
fi

rsync -avz pi@$SYSROOT_HOST:/lib sysroot --delete
rsync -avz pi@$SYSROOT_HOST:/usr/include sysroot/usr --delete
rsync -avz pi@$SYSROOT_HOST:/usr/lib sysroot/usr --delete
rsync -avz pi@$SYSROOT_HOST:/opt/vc sysroot/opt --delete

if [ ! -f "sysroot-relativelinks.py" ]; then
	wget https://raw.githubusercontent.com/riscv/riscv-poky/priv-1.10/scripts/sysroot-relativelinks.py
	chmod +x sysroot-relativelinks.py
	./sysroot-relativelinks.py sysroot
fi
