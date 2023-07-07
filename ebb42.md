Flash EBB42 to CAN mode

WARNING: Always jumper VBus when powering over USB! And dont forget to remove it when done and disconnected.

Once the jumper is in place on vbus, connect EBB42 to your host device with a usb cable.

Hold the BOOT button and press the RST button to enter DFU mode. 


Build klipper for the EBB42:
```
cd klipper
make menuconfig
```
Select the following options:
```
Klipper Firmware Configuration
[*] Enable extra low-level configuration options
    Micro-controller Architecture (STMicroelectronics STM32)  --->
    Processor model (STM32G0B1)  --->
    Bootloader offset (No bootloader)  --->
    Clock Reference (8 MHz crystal)  --->
    Communication interface (CAN bus (on PB0/PB1))  --->
(500000) CAN bus speed
()  GPIO pins to set at micro-controller startup
```
```
make
lsusb
```
Get the id of the ebb42 board, use it in the following command, ex: 0483:df11

`dfu-util -a 0 -D out/klipper.bin --dfuse-address 0x08000000:force:mass-erase:leave -d 0483:df11`

Its normal for it to say this, as long as you see "File downloaded successfully" in there:
```
dfu-util: Invalid DFU suffix signature
dfu-util: A valid DFU suffix will be required in a future dfu-util release!!!
...
File downloaded successfully
dfu-util: Error during download get_status
```

The EBB42 is now flashed and ready to be connected over CAN.

WARNING: You should have removed the jumper on vbus after flashing was completed and the device is disconnected.

sudo nano /etc/network/interfaces.d/can0

allow-hotplug can0
iface can0 can static
        bitrate 500000
        up ifconfig $IFACE txqueuelen 256

sudo ip link set up can0
