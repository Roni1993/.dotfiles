# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# define FZF params
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

zinit snippet OMZL::history.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::completion.zsh

zinit snippet OMZP::git
zinit snippet OMZP::wd
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::fasd
zinit snippet OMZP::safe-paste
zinit snippet OMZP::magic-enter
zinit snippet OMZP::sdk
zinit snippet OMZP::fzf

zinit ice wait lucid; zinit light wfxr/forgit
#zinit ice wait lucid; zinit light andrewferrier/fzf-z
zinit ice wait lucid; zinit light SukkaW/zsh-proxy

#adding auto suggestion stuff
zinit ice wait lucid atinit"zicompinit"
zinit light Aloxaf/fzf-tab
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light zdharma/fast-syntax-highlighting

# load sdkman with zinit
zinit ice wait lucid as"program" pick"$HOME/.sdkman/bin/sdk" id-as'sdkman' run-atpull \
    atclone"wget https://get.sdkman.io -O scr.sh; SDKMAN_DIR=$HOME/.sdkman bash scr.sh" \
    atpull"SDKMAN_DIR=$HOME/.sdkman sdk selfupdate"
zinit light zdharma/null
###################################################################################
# setting up remaining envs
###################################################################################

# load all dircolors due to windows madness
alias ls=lsd
#eval $(dircolors -b $HOME/.dircolors)
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

source ~/.profile

# setting random plugin/app parameters
PATH=$HOME/.local/bin:$PATH
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180'
MAGIC_ENTER_GIT_COMMAND='git status -u .'
MAGIC_ENTER_OTHER_COMMAND='ls -lh .'

unset ZLE_RPROMPT_INDENT
setopt HIST_IGNORE_ALL_DUPS
