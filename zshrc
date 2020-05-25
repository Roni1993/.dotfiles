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
zinit atload'!source ~/.p10k.zsh' lucid nocd for \
    romkatv/powerlevel10k

zinit light zsh-users/zsh-completions
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

#loading oh my zsh libs
#zinit ice svn multisrc"misc.zsh functions.zsh" pick"/dev/null"
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/directories.zsh
zinit snippet OMZ::lib/completion.zsh

zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/wd/wd.plugin.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/fzf/fzf.plugin.zsh
zinit snippet OMZ::plugins/fasd/fasd.plugin.zsh
zinit snippet OMZ::plugins/gradle/gradle.plugin.zsh
zinit snippet OMZ::plugins/safe-paste/safe-paste.plugin.zsh
zinit snippet OMZ::plugins/sdk/sdk.plugin.zsh
zinit snippet OMZ::plugins/magic-enter/magic-enter.plugin.zsh

zinit light Aloxaf/fzf-tab
zinit light zdharma/fast-syntax-highlighting
zinit ice wait lucid
zinit light wfxr/forgit
zinit light andrewferrier/fzf-z

###################################################################################
# setting up remaining envs
###################################################################################
unset http_proxy https_proxy no_proxy
unset HTTP_PROXY HTTPS_PROXY NO_PROXY

# load all dircolors due to windows madness
alias ls=lsd
#eval $(dircolors -b $HOME/.dircolors)
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# TODO: traceroute proxy -> if available use proxy otherwise not
#export https_proxy="http://proxy:8080/proxy.pac"
#export http_proxy="http://proxy:8080/proxy.pac"
#export HTTPS_PROXY="http://proxy:8080/proxy.pac"
#export HTTP_PROXY="http://proxy:8080/proxy.pac"
#export no_proxy="*.global.gls, *.dc.gls, localhost, 127.0.0.1, *.nst.gls-germany.com"
#export NO_PROXY="*.global.gls, *.dc.gls, localhost, 127.0.0.1, *.nst.gls-germany.com"

source ~/.profile

# setting random plugin/app parameters
PATH=$HOME/.local/bin:$PATH
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180'
MAGIC_ENTER_GIT_COMMAND='git status -u .'
MAGIC_ENTER_OTHER_COMMAND='ls -lh .'

unset ZLE_RPROMPT_INDENT
setopt HIST_IGNORE_ALL_DUPS

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/rowe/.sdkman"
[[ -s "/home/rowe/.sdkman/bin/sdkman-init.sh" ]] && source "/home/rowe/.sdkman/bin/sdkman-init.sh"
