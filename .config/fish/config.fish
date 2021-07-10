bass BASH_VERSION= source ~/.profile

# https://github.com/fish-shell/fish-shell/issues/6643#issuecomment-590045287
set -gx GPG_TTY (tty)

function l
    command ls --color -CF $argv
end

# TODO: Move this into ~/.local/bin/
# Thanks http://christopherroach.com/articles/jupyterlab-desktop-app/
# I can finally use ctrl + w
function jupyterlab-app
    set -q argv[1]; or set argv[1] "0.0.0.0"
    google-chrome --app="http://$argv[2]:8888/lab?token=$argv[1]"
end

function cms
    builtin cd /home/vin/dev/website/blog/; gatsby develop; cd -
end

function emacs
    command emacs -nw $argv
end

function til
    builtin cd /home/vin/dev/website/blog/; python til.py $argv
end

function fish_greeting
    echo
    echo "👋 welcome to neutron"
    echo
end

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end

    fish_default_key_bindings -M default

    fish_vi_key_bindings default
end
