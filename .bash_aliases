alias ..="cd .."
# alias lj="(cd /home/vin/dev/lifesystem/journal; . ../venv/bin/activate; python lj.py)" 
# alias sj="(cd /home/vin/dev/lifesystem/spec; . ../venv/bin/activate; python sj.py)" 

function lj() {
	(cd /home/vin/dev/lifesystem/journal; . ../venv/bin/activate; python lj.py "$@")
}

function sj() {
	(cd /home/vin/dev/lifesystem/spec; . ../venv/bin/activate; python sj.py "$@")
}

alias rules="lj -d rules"
