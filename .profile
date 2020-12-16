# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/NX/bin:$PATH"
export PATH="$PATH:$HOME/utils"

if xrandr | grep -q "HDMI1 connected"
then
    export GDK_SCALE=2
    export GDK_DPI_SCALE=0.5
else
    export GDK_SCALE=1
    export GDK_DPI_SCALE=1
fi

# if [ -d "$INITIAL_CONF" ] ; then
#     /home/vin/.screenlayout/home.sh
# fi
# export INITIAL_CONF="y"

~/.config/i3/xmodmap_settings.sh 2>& 1
