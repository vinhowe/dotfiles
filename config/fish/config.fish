fenv source ~/.profile

function l
    command ls --color -CF $argv
end

function ..
    builtin cd $argv ..
end

function lj
	builtin cd /home/vin/dev/lifesystem/journal; . ../venv/bin/activate.fish; python lj.py $argv; deactivate; cd -
end

function sj
	builtin cd /home/vin/dev/lifesystem/spec; . ../venv/bin/activate.fish; python sj.py $argv; deactivate; cd -
end

function per
    builtin cd /home/vin/dev/lifesystem; . venv/bin/activate.fish; python app.py s; deactivate; cd -
end

function jour
    builtin cd /home/vin/dev/lifesystem; . venv/bin/activate.fish; python app.py p j; deactivate; cd -
end

# Thanks http://christopherroach.com/articles/jupyterlab-desktop-app/
# I can finally use ctrl + w
function jupyterlab-app
    google-chrome --app="http://0.0.0.0:8888/lab?token=$argv"
end

function plan 
    builtin cd /home/vin/dev/lifesystem; . venv/bin/activate.fish; python app.py p $argv; deactivate; cd -
end

function log 
    builtin cd /home/vin/dev/lifesystem; . venv/bin/activate.fish; python log_app.py; deactivate; cd -
end

function cl
    setxkbmap -option caps:swapescape
    xdotool key Caps_Lock
end

function rules
    lj -d rules
end

function cms
	builtin cd /home/vin/dev/website/blog; gatsby develop; cd -
end

function python
    command python3 $argv
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

function db
    command ~/disconnect_bluetooth.sh
end

function cb
    command ~/u8i_connect.sh
end

bass source '/home/vin/Downloads/google-cloud-sdk/path.bash.inc'

bass source '/home/vin/Downloads/google-cloud-sdk/completion.bash.inc'

set fish_greeting

set -Ux EDITOR vim

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end

    fish_default_key_bindings -M default

    fish_vi_key_bindings default
end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/vin/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
