fenv source ~/.profile

function l
    command ls -CF $argv
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

bass source '/home/vin/Downloads/google-cloud-sdk/path.bash.inc'

bass source '/home/vin/Downloads/google-cloud-sdk/completion.bash.inc'

set fish_greeting

set -Ux EDITOR vim

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

fish_vi_key_bindings

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/vin/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
