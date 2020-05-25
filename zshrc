# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load zsh plugins via antibody
export FZF_BASE=/usr/bin/fzf
export FZF_DEFAULT_OPTS=' --color=light '

###################################################################################
# zinit (plugin manager)
###################################################################################
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

##########################################
# setting up oh my zsh and all misc plugins
#######################################
zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-autosuggestions

#loading oh my zsh libs
#zinit ice svn multisrc"misc.zsh functions.zsh" pick"/dev/null"
zinit snippet OMZ::lib/history.zsh

zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/wd/wd.plugin.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/fzf/fzf.plugin.zsh

zinit load Aloxaf/fzf-tab
zinit load zdharma/fast-syntax-highlighting
zinit load wfxr/forgit

###################################################################################
# setting up remaining envs
###################################################################################
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
