#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 ]]; then
	exec startx &> ~/.local/share/user_logs/startx/startx.log
fi
