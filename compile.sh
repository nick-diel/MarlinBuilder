#!/bin/bash
#check to make sure there is an argument

#update index and install STM32 package, specify version as command line
arduino-cli core update-index --additional-urls https://github.com/stm32duino/BoardManagerFiles/raw/master/STM32/package_stm_index.json
arduino-cli core install STM32:stm32@$1 --additional-urls https://github.com/stm32duino/BoardManagerFiles/raw/master/STM32/package_stm_index.json

#find and set objcopy
OBJCOPY=$(find $HOME/.arduino15/packages/STM32/tools/arm-none-eabi-gcc -name "objcopy")

#copy src for speed improvement
cp -r /usr/src/marlin/ /tmp/src/marlin

arduino-cli compile --fqbn STM32:stm32:3dprinter:pnum=MALYANM200_F070CB,upload_method=swdMethod,xserial=generic,usb=CDC,xusb=FS,opt=osstd,rtlib=nano --output /tmp/firmware.bin /tmp/src/marlin/Marlin

$OBJCOPY /tmp/firmware.bin.elf -O binary /usr/src/marlin/Firmware/firmware.bin
cp /usr/src/marlin/Firmware/firmware.bin /usr/src/marlin/Firmware/fcupdate.flg