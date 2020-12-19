bass BASH_VERSION= source ~/.profile

set -Ux EDITOR nvim
setenv EDITOR nvim

eval sh $HOME/.config/gotham/gotham.sh

# https://github.com/fish-shell/fish-shell/issues/6643#issuecomment-590045287
set -gx GPG_TTY (tty)

function l
    command ls --color -CF $argv
end

function ..
    builtin cd $argv ..
end

function per
    builtin cd /home/vin/dev/lifesystem; . venv/bin/activate.fish; python app.py s; deactivate; cd -
end

function plan
    builtin cd /home/vin/dev/lifesystem; . venv/bin/activate.fish; python app.py p $argv; deactivate; cd -
end

# Thanks http://christopherroach.com/articles/jupyterlab-desktop-app/
# I can finally use ctrl + w
function jupyterlab-app
    set -q argv[1]; or set argv[1] "0.0.0.0"
    google-chrome --app="http://$argv[2]:8888/lab?token=$argv[1]"
end

function icat
    kitty +kitten icat --align=left $argv
end

function cl
    setxkbmap -option caps:swapescape
    xdotool key Caps_Lock
end

function cms
    builtin cd /home/vin/dev/website/blog; gatsby develop; cd -
end

function emacs
    command emacs -nw $argv
end

function te
    command touch $argv; typora $argv
end

function brb
    command fish -c "cd ~/dev/berightback/; ./fullscreen_lock.sh"
end

set fish_greeting

set -Ux EDITOR vim

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end

    fish_default_key_bindings -M default

    fish_vi_key_bindings default
end

function icat
    kitty +kitten icat --align=left $argv
end

function til
    builtin cd /home/vin/dev/website/blog/; python til.py $argv
end
