# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

VISUAL=nvim

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

PATH="$PATH:$HOME/dev/flutter/bin"
PATH="$PATH:$HOME/Android/Sdk/platform-tools"
PATH="/usr/local/cuda-11.0/bin${PATH:+:${PATH}}"
PATH="$HOME/.cargo/bin:$PATH"
