# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source $(which virtualenvwrapper.sh)

function _get_account() {
    for arg in $@; do [[ "$arg" =~ ^account_* ]] && break; done
    arg="${arg%%/*}" && echo "${arg#*account_}"
}
function a() { AWS_PROFILE="$(_get_account $@)" ansible "$@" --vault-password-file scripts/vault.sh; }
function ap() { AWS_PROFILE="$(_get_account $@)" ansible-playbook "$@" --vault-password-file scripts/vault.sh; }
function av() { ansible-vault $@ --vault-password-file scripts/vault.sh; }

alias vpn="sudo openvpn --config ~/blockchyp.ovpn"
eval `ssh-agent`
ssh-add
