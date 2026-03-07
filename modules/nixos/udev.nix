{ config, pkgs, ... }:

{
    # udev are setup for controlling the framework 16 laptop's keyboard
    services.udev.extraRules = ''
## https://github.com/qmk/qmk_firmware/blob/master/util/udev/50-qmk.extraRules
## Atmel DFU
#### ATmega16U2
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2fef", TAG+="uaccess"
#### ATmega32U2
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff0", TAG+="uaccess"
#### ATmega16U4
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff3", TAG+="uaccess"
#### ATmega32U4
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff4", TAG+="uaccess"
#### AT90USB64
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff9", TAG+="uaccess"
#### AT90USB162
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ffa", TAG+="uaccess"
#### AT90USB128
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ffb", TAG+="uaccess"
#
## Input Club
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="1c11", ATTRS{idProduct}=="b007", TAG+="uaccess"
#
## STM32duino
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="1eaf", ATTRS{idProduct}=="0003", TAG+="uaccess"
## STM32 DFU
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", TAG+="uaccess"
#
## BootloadHID
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05df", TAG+="uaccess"
#
## USBAspLoader
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05dc", TAG+="uaccess"
#
## USBtinyISP
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="1782", ATTRS{idProduct}=="0c9f", TAG+="uaccess"
#
## ModemManager should ignore the following devices
## Atmel SAM-BA (Massdrop)
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
#
## Caterina (Pro Micro)
### pid.codes shared PID
#### Keyboardio Atreus 2 Bootloader
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2302", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
### Spark Fun Electronics
#### Pro Micro 3V3/8MHz
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9203", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
#### Pro Micro 5V/16MHz
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9205", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
#### LilyPad 3V3/8MHz (and some Pro Micro clones)
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9207", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
### Pololu Electronics
#### A-Star 32U4
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="1ffb", ATTRS{idProduct}=="0101", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
### Arduino SA
#### Leonardo
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0036", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
#### Micro
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0037", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
### Adafruit Industries LLC
#### Feather 32U4
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000c", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
#### ItsyBitsy 32U4 3V3/8MHz
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000d", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
#### ItsyBitsy 32U4 5V/16MHz
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000e", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
### dog hunter AG
#### Leonardo
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="2a03", ATTRS{idProduct}=="0036", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
#### Micro
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="2a03", ATTRS{idProduct}=="0037", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
#
## hid_listen
#KERNEL=="hidraw*", MODE="0660", GROUP="plugdev", TAG+="uaccess", TAG+="udev-acl"
#
## hid bootloaders
### QMK HID
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2067", TAG+="uaccess"
### PJRC's HalfKay
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="0478", TAG+="uaccess"
#
## APM32 DFU
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="314b", ATTRS{idProduct}=="0106", TAG+="uaccess"
#
## GD32V DFU
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="28e9", ATTRS{idProduct}=="0189", TAG+="uaccess"
#
## WB32 DFU
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="342d", ATTRS{idProduct}=="dfa0", TAG+="uaccess"
#
## AT32 DFU
#      SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e3c", ATTRS{idProduct}=="df11", TAG+="uaccess"


# and # https://community.frame.work/t/guide-updated-after-firmware-updates-udev-rules-for-https-keyboard-frame-work/78708
     
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0010", TAG+="uaccess"
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0012", TAG+="uaccess"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0013", TAG+="uaccess"
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0014", TAG+="uaccess"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0018", TAG+="uaccess"
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0019", TAG+="uaccess"




#    USB [VendorID]:[ProductID] “[Manufacturer][Product name]”
#    32ac:0012 “Framework Laptop 16 Keyboard Module - ANSI”
#    32ac:0013 “Framework Laptop 16 RGB Macropad”
#    32ac:0014 “Framework Laptop 16 Numpad Module”
#    32ac:0018 “Framework Laptop 16 Keyboard Module - ISO”
#    32ac:0019 “Framework Laptop 16 Keyboard Module - JIS”


##https://github.com/ublue-os/config/blob/main/files/etc/udev/rules.d/50-framework16.rules
## Audio Expansion Card
#ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="32ac", ATTR{idProduct}=="0010", ATTR{power/autosuspend}="10", ATTR{power/control}="auto", GOTO="rules_end"
#
## Framework Laptop 16 Keyboard Module - ANSI
#ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="32ac", ATTR{idProduct}=="0012", ATTR{power/autosuspend}="-1", ATTR{power/control}="on", ATTR{power/wakeup}="disabled", GOTO="rules_end"
#
## Framework Laptop 16 RGB Macropad
#
## Framework Laptop 16 Numpad Module
#ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="32ac", ATTR{idProduct}=="0014", ATTR{power/autosuspend}="-1", ATTR{power/control}="on", ATTR{power/wakeup}="disabled", GOTO="rules_end"
#
## Framework Laptop 16 Keyboard Module
#ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="32ac", ATTR{idProduct}=="0018", ATTR{power/autosuspend}="-1", ATTR{power/control}="on", ATTR{power/wakeup}="disabled", GOTO="rules_end"
#
#LABEL="rules_end"

'';
}
