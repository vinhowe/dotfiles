fenv source ~/.profile
fenv source ~/.nvm/nvm.sh

set -Ux EDITOR nvim
setenv EDITOR nvim


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
eval sh $HOME/.config/gotham/gotham.sh

function jour
    builtin cd /home/vin/dev/lifesystem; . venv/bin/activate.fish; python app.py p j; deactivate; cd -
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

function icat
    kitty +kitten icat --align=left $argv
end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/vin/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
function vi
    nvim $argv
end

function til
    builtin cd /home/vin/dev/website/blog/; python til.py $argv
end

set prodlock_cooldown 0

function execute_prodlock
    # set cmd_empty (test -n (string trim --chars=\n\r (commandline)))

    if test $prodlock_cooldown -ge 0; and test -n (string trim --chars=\n\r (commandline))
	set prodlock_cooldown (math $prodlock_cooldown - 1)
    else
	set prodlock_cooldown 10
    end
    set execute 1
    set cmd (commandline)
    if cat ~/.prodlock/profile | string match -rq '^productive'; and test $prodlock_cooldown -le 0
	set execute 0
	reset_return_bindings
	commandline ""
	commandline -f repaint
	echo
	bind -M insert \e ""
	set fish_bind_mode insert
	trap "prodlock_return_bindings; fish_user_key_bindings; bind -e -M insert \e" SIGINT
	read -l -n 1 -P "prodlock on; is this productive? [y/n] " choice
	prodlock_return_bindings
	fish_user_key_bindings
	bind -e -M insert \e
	switch $choice
	    case Y y
		set execute 1
		set prodlock_cooldown 10
	    case '*'
		set prodlock_cooldown 0
	end
    end

    if test $execute -ne 0
	commandline $cmd
	commandline -f repaint
	commandline -f execute
    end
    set fish_bind_mode insert
end

function reset_return_bindings
    for mode in insert default visual
	bind --all -e -M $mode \r
	bind --all -e -M $mode \n
    end
end

function prodlock_return_bindings
    for mode in insert default visual
	bind -M $mode \r execute_prodlock
	bind -M $mode \n execute_prodlock
    end
    bind -M normal :q execute_prodlock
    bind -M normal :wq execute_prodlock
end

prodlock_return_bindings