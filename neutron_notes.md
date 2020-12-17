# Arch on Neutron

Neutron is a custom PC build:
- [Intel Core i9-10850k](https://ark.intel.com/content/www/us/en/ark/products/205904/intel-core-i9-10850k-processor-20m-cache-up-to-5-20-ghz.html)
- [ASUS TUF Gaming Z490-PLUS Wi-Fi](https://www.asus.com/Motherboards-Components/Motherboards/All-series/TUF-GAMING-Z490-PLUS-WI-FI/)
- Integrated graphics (I don't play anything more intensive than Minecraft)
- 32GB [Corsair Vengeance RGB Pro Memory](https://www.corsair.com/us/en/vengeance-rgb-pro-memory)
- 1TB [Samsung 970 EVO Plus NVMe](https://www.samsung.com/semiconductor/minisite/ssd/product/consumer/970evoplus/)
- 1TB [Samsung 860 EVO SATA III SSD](https://www.samsung.com/semiconductor/minisite/ssd/product/consumer/970evoplus/) (taken from laptop)
- [LG 27BL65U-W 27" 4K monitor](https://www.lg.com/us/business/desktop-monitors/lg-27BL65U)


## Changelist

I try to cover the major changes I've made, in the order I made them. This excludes:
- Anything that I can track in version control instead (like https://github.com/vinhowe/dotfiles)
- Installing packages that don't require any further intervention. An example of intervention includes enabling a service.

__All changes before this point were made in [Arch on Quark](./quark_notes.md)--I'm using the same SSD.__

Unless specified, the Arch package names for the programs I'm using are just their lowercase names.

- Change hostname to "neutron" because it is a different computer
- Install `pulseaudio`, `pulseaudio-bluetooth` and uninstall uninstall pipewire and pipewire-pulse because they don't
  play well enough with Bluetooth yet
  - Enable service
    ```
    systemctl --user enable pulseaudio.socket
    systemctl --user enable pulseaudio.service
    ```
  - Add `load-module module-switch-on-connect` to `/etc/pulse/default.pa`, right under
    `load-module module-bluetooth-discover`
- Install `etckeeper`, check everything into https://github.com/vinhowe/etc-neutron
- Remove `/etc/X11/xorg.conf.d/{30-touchpad.conf,99-no-touchscreen.conf}`, as I'm using a desktop now
- Uninstall rtl8821ce-dkms-git driver because I don't use that Wi-Fi chip anymore
- Uninstall acpilight because I'm running a monitor over DisplayPort now
- Remove laptop-specific backlight udev rule `/etc/udev/rules.d/90-backlight.rules`
- Remove pipewire-pulse udev rule `/etc/udev/rules.d/pipewire-pulse-bt.rules`
- Install ddcutil for use with [.screenlayout/relative_ddc_brightness.sh](./.screenlayout/relative_ddc_brightness.sh)
