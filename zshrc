# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load zsh plugins via antibody
export FZF_DEFAULT_OPTS=' --color=light '
export ZSH="/home/rowe/.oh-my-zsh"
source <(antibody init)
antibody bundle < ~/.zsh_plugins

unset http_proxy https_proxy no_proxy
unset HTTP_PROXY HTTPS_PROXY NO_PROXY

# load all dircolors due to windows madness
alias ls=lsd
#eval $(dircolors -b $HOME/.dircolors)
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

cd ~
# TODO: traceroute proxy -> if available use proxy otherwise not
#export https_proxy="http://proxy:8080/proxy.pac"
#export http_proxy="http://proxy:8080/proxy.pac"
#export HTTPS_PROXY="http://proxy:8080/proxy.pac"
#export HTTP_PROXY="http://proxy:8080/proxy.pac"
#export no_proxy="*.global.gls, *.dc.gls, localhost, 127.0.0.1, *.nst.gls-germany.com"
#export NO_PROXY="*.global.gls, *.dc.gls, localhost, 127.0.0.1, *.nst.gls-germany.com"

source ~/.profile

PATH=$HOME/.local/bin:$PATH
FZF_BASE=/usr/bin/fzf
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180'

unset ZLE_RPROMPT_INDENT
setopt HIST_IGNORE_ALL_DUPS

autoload -U compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fpath=(~/.zsh.d/ $fpath)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/rowe/.sdkman"
[[ -s "/home/rowe/.sdkman/bin/sdkman-init.sh" ]] && source "/home/rowe/.sdkman/bin/sdkman-init.sh"
