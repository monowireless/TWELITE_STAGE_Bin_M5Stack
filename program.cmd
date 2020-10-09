@echo off
echo *** PROGRAMMING TOOL OF TWELTIE STAGE for M5Stack ***
set COM_STR=
set /P COM_STR="INPUT COM PORT NAME: "
esptool-2.3.1-win\esptool.exe --chip esp32 --port %COM_STR% --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size detect 0xe000 fw/boot_app0.bin 0x1000 fw/bootloader_qio_80m.bin 0x10000 fw/TWELITE_Stage.ino.bin 0x8000 fw/TWELITE_Stage.ino.partitions.bin 
PAUSE
