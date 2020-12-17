# Arch on Quark

Quark was an HP 15-cs0053cl laptop with an Intel Core
[i5-8250U](https://ark.intel.com/content/www/us/en/ark/products/124967/intel-core-i5-8250u-processor-6m-cache-up-to-3-40-ghz.html)
processor.


## Changelist

I try to cover the major changes I've made, in the order I made them. This excludes:
- Anything that I can track in version control instead (like https://github.com/vinhowe/dotfiles)
- Installing packages that don't require any further intervention. An example of intervention includes enabling a service.

__This list starts after the [ArchWiki installation guide](https://wiki.archlinux.org/index.php/installation_guide).__

Unless specified, the Arch package names for the programs I'm using are just their lowercase names.

- Install NetworkManager and configure network: https://wiki.archlinux.org/index.php/NetworkManager
  - After installing and enabling/starting service: `nmcli device wifi connect <SSID> password <password>`
  - I've heard that this is useful for laptops where Wi-Fi networks switch often, but you might not need it on a desktop because it rarely moves. If you're using a desktop with an ethernet connection, there's no point.
- Install neovim
- Create normal user (mine is "vin") and add them to the "wheel" group for sudo access ([this is the recommended way of doing it](https://wiki.archlinux.org/index.php/sudo#Example_entries))
  ```bash
  useradd -m vin
  passwd vin
  sudo usermod -a -G wheel vin
  ```
- Give user sudo power (as root):
  - Install neovim to use in editing sudoers file
  - `echo "Defaults editor=/usr/bin/nvim" >> /etc/sudoers` 
  - Use `visudo` and uncomment the "%wheel ... NOPASSWD" example
- Install yay AUR helper: https://github.com/Jguer/yay
  - Note that yay acts as a drop-in replacement for pacman in addition to being an easy way to install AUR packages, so _do this early_
- Install rtl8821ce driver (rtl8821ce-dkms-git)--my laptop won't connect without it 
- Install pre-built linux-ck kernel, ck-skylake: https://wiki.archlinux.org/index.php/Unofficial_user_repositories/Repo-ck
  - Make sure to remove Arch linux package _only after_ verifying that linux-ck is available in Grub
- Install fish shell
- Install font packages (do this before installing i3 or nothing will work):
  - `ttf-dejavu`
  - `ttf-jetbrains-mono`
  - `ttf-lato`
  - `ttf-ubuntu-font-family`
  - `ttf-liberation`
  - `ttf-font-awesome`
  - `ttf-inconsolata`
  - `noto-fonts-emoji`
- Install i3: `yay -Syu i3-wm`
  - Install picom compositor
  - See [.config/i3/config](./.config/i3/config)
- Create `~/.local/share/user_logs/{i3,startx}` directories as a convenient XDG-style way of recording logs for i3 and startx without cluttering the home directory
- Setup xorg:
  - `yay -Syu xorg-{server,xinit}`
  - `cp /etc/X11/xinit/xinitrc ~/.xinitrc`
  - Remove everything below `twm &` and replace it with 
    `exec i3 &> ~/.local/share/user_logs/i3/i3.log`
- Changes for Intel integrated graphics (Kaby Lake, in my case)
  - Explicitly set modesetting driver in `/etc/X11/xorg.conf.d/20-intel.conf` (this is recommended for recent Intel integrated graphics):
    ```conf
    Section "Device"
	  Identifier "Intel Graphics"
	  Driver "modesetting"
    EndSection
    ```
  - Follow [Kernel_mode_setting#Early_KMS_start](https://wiki.archlinux.org/index.php/Kernel_mode_setting#Early_KMS_start) i915 module
- Automatically run startx on a successful login to tty1 (see end of [.bash_profile](./.bash_profile))
  - This replaces the functionality of a display manager on a system with one real user without any downsides that I've experienced, except that it's not as pretty
- Start using [YADM](https://yadm.io) for dotfiles management
  - I was using manual symbolic links before and I may yet switch back. Symbolic links to a repository strikes me as a cleaner if slightly less convenient solution than the home-level repository setup that YADM does.
- Create symbolic links for convenience
  - `ln -s /usr/bin/{nvim,vi}`
  - `ln -s /usr/bin/{google-chrome-stable,google-chrome}`
  - `ln -s /usr/bin/{google-chrome-stable,chrome}`
  - `ln -s $HOME/Dropbox/school/semester/f20 $HOME/school` (quick access for fall semester 2020)
- Set up keyboard backlight control
  - https://askubuntu.com/questions/715306/xbacklight-no-outputs-have-backlight-property-no-sys-class-backlight-folder
  - https://wiki.archlinux.org/index.php/Backlight#xbacklight
  - https://wiki.archlinux.org/index.php/Backlight#ACPI: Install acpilight and add udev rule
  - In my case, I ended up with a new udev rule: `/etc/udev/rules.d/90-backlight.rules`
- After adding user to sudoers file, enable NOPASSWD as documented
- (Don't do this) Install PipeWire as a drop-in PulseAudio replacement: https://wiki.archlinux.org/index.php/PipeWire
  - __NOTE__: PipeWire is in active development and will probably break your heart. It was a pain to use with my Bluetooth headphones (Sony WH-1000XM4), and I had to find a hacky script to switch to it after connecting. I switched to PulseAudio and everything works better. Just use PulseAudio.
  - Tips if you want to do this anyway
    - Set up its services:
      ```
      systemctl --user start pipewire.socket
      systemctl --user start pipewire.service
      ```
    - Set up bluetooth sink switching hack: https://gist.github.com/tinywrkb/04e7fd644afa9b92d33a3a99ab07ee9e
- Bluetooth support
  - Install bluez and bluetoothctl: `yay -Syu bluez{,-utils}`
  - Install blueman
  - https://wiki.archlinux.org/index.php/Bluetooth:
  - https://wiki.archlinux.org/index.php/Bluetooth#Auto_power-on_after_boot
  - https://wiki.archlinux.org/index.php/Bluetooth#Discoverable_on_startup
- https://wiki.archlinux.org/index.php/Mouse_acceleration#Persistent_configuration with `/etc/X11/xorg.conf.d/30-touchpad.conf`
- Disable touchscreen: https://unix.stackexchange.com/a/129603/97339
- Potential Wi-Fi speed booster: https://wiki.archlinux.org/index.php/Network_configuration/Wireless#Respecting_the_regulatory_domain
- Install thunar file manager
- Set dark theme for GTK applications
  - To use gsettings, install gsettings-desktop-schemas if it hasn't already been installed
  - `gsettings set org.gnome.desktop.interface gtk-theme Adwaita:dark`
  - Create `~/.config/gtk-3.0/settings.ini` following [my version](./.config/gtk-3.0/settings.ini)
- Install Chrome and configure it
  - Set as default: `xdg-settings set default-web-browser google-chrome.desktop`
  - Disable GPU workarounds (see [.config/chrome-flags.conf][./.config/chrome-flags.conf])
- Set GPG agent to use pinentry-curses: [.gnupg/gpg-agent.conf](./.gnupg/gpg-agent.conf)
- Set up printing: https://wiki.archlinux.org/index.php/CUPS
  - My printer is HP, and I tried just using HPLIP (hp-setup) but I ran into some issue


## Death

Quark, my beloved laptop, died Sunday, December 6, 2020, the week before finals and a day before I developed my first symptoms of COVID-19. An autopsy concluded that the cause of death was likely motherboard failure. It was manufactured sometime around 2018, which means it only stuck around for 2 years.
Whether I have my warranty-voiding hardware modifications or HP's quality control standards to thank, we may never know.


## Migration to Neutron desktop

See [Arch on Neutron](./neutron_notes.md)
