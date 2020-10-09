#!/bin/bash

if [ "$OS" = "Windows_NT" ]; then
 OSNAME=win
 COM_STR=COM4
else
 UNAME_S=`uname -s`
 if [ $UNAME_S = "Darwin" ]; then
  OSNAME=mac
  COM_STR=/dev/cu.SLAB_USBtoUART
 elif [ $UNAME_S = "Linux" ]; then
  OSNAME=linux
  COM_STR=/dev/ttyUSB0
 fi
fi

echo "*** PROGRAMMING TOOL OF TWELTIE STAGE for M5Stack ***"
echo -n "INPUT COM PORT NAME[$COM_STR]: "
read STR
if [ ! -z "$STR" ]; then
  COM_STR=$STR
fi

python esptool-2.3.1/esptool.py --chip esp32 --port $COM_STR --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size detect 0xe000 fw/boot_app0.bin 0x1000 fw/bootloader_qio_80m.bin 0x10000 fw/TWELITE_Stage.ino.bin 0x8000 fw/TWELITE_Stage.ino.partitions.bin 
