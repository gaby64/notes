MKS-PI gpio-poweroff




wget https://raw.githubusercontent.com/armbian/build/master/config/bootscripts/boot-rockchip64.cmd
cp boot-rockchip64.cmd /boot/boot.cmd
mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
mv /boot/extlinux/ /boot/~extlinux/

armbian-add-overlay rockchip-rk3328-poweroff-gpio1-24.dts



/boot/armbianEnv.txt
rootdev=/dev/mmcblk1p2
extraargs=console=uart8250,mmio32,0xff130000 console=tty0 rw no_console_suspend consoleblank=0 fsck.fix=yes fsck.repair=yes net.ifnames=0 splash plymouth.ignore-serial-consoles
user_overlays=rockchip-rk3328-poweroff-gpio1-24
usbstoragequirks=0x2537:0x1066:u,0x2537:0x1068:u

