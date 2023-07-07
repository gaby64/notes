DIR="$(pwd)"
sudo service klipper stop
cd ~/klipper
#make clean KCONFIG_CONFIG=../linux.config
#make menuconfig KCONFIG_CONFIG=../linux.config
#make KCONFIG_CONFIG=../linux.config
cp ${DIR}/linux.config .config
make clean
make
sudo make flash

#make clean KCONFIG_CONFIG=../ebb42.config
#make menuconfig KCONFIG_CONFIG=../ebb42.config
#make KCONFIG_CONFIG=../ebb42.config
cp ${DIR}/ebb42.config .config
make clean
make
~/klippy-env/bin/python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 3aabd4b7c8bf

#make clean KCONFIG_CONFIG=../skipr.config
#make menuconfig KCONFIG_CONFIG=../skipr.config
#make KCONFIG_CONFIG=../skipr.config
cp ${DIR}/skipr.config .config
make clean
make
~/klippy-env/bin/python3 ~/CanBoot/scripts/flash_can.py -i can0 -u e96cc8663264 -r
sleep 5s
sudo chmod 666 /dev/ttyACM0
~/klippy-env/bin/python3 ~/CanBoot/scripts/flash_can.py -d /dev/ttyACM0


sudo service klipper start
cd  ~
