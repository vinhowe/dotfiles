fenv source ~/.profile
fenv source ~/.nvm/nvm.sh

eval sh $HOME/.config/gotham/gotham.sh

set fish_greeting

set -Ux EDITOR vim

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

fish_vi_key_bindings

function per
    builtin cd /home/vinhowe/dev/lifesystem; . venv/bin/activate.fish; python app.py s; deactivate
end

# Thanks http://christopherroach.com/articles/jupyterlab-desktop-app/
# I can finally use ctrl + w
function jupyterlab-app
    google-chrome --app="http://0.0.0.0:8888/lab?token=$argv"
end

function icat
    kitty +kitten icat --align=left $argv
end

function vi
    nvim $argv
end

function jour
    builtin cd /home/vinhowe/dev/lifesystem; . venv/bin/activate.fish; python app.py p j; deactivate
end

function plan 
    builtin cd /home/vinhowe/dev/lifesystem; . venv/bin/activate.fish; python app.py p $argv; deactivate
end

function til
    builtin cd /home/vinhowe/dev/website/; python til.py $argv
end
