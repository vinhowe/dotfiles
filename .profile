# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

VISUAL=nvim

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.npm-global/bin:$PATH"
