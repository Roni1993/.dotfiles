# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# define FZF params
export COLORTERM="base16"
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180'
export BAT_THEME="OneHalfLight"
export FZF_BASE=/usr/bin/fzf
export FZF_DEFAULT_OPTS=' --color=light '
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# load homebrew
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew/Homebrew";
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Homebrew/Cellar";
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew";
export PATH="/home/linuxbrew/.linuxbrew/Homebrew/bin:/home/linuxbrew/.linuxbrew/Homebrew/sbin${PATH+:$PATH}";
export MANPATH="/home/linuxbrew/.linuxbrew/Homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/home/linuxbrew/.linuxbrew/Homebrew/share/info${INFOPATH+:$INFOPATH}";

# other system Envs
export WSL_HOST_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')

###################################################################################
# zinit (plugin manager)
###################################################################################
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma-continuum/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
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

# load sdkman with zinit
zinit ice wait lucid as"program" pick"$HOME/.sdkman/bin/sdk" id-as'sdkman' run-atpull \
    atclone"wget https://get.sdkman.io -O scr.sh; SDKMAN_DIR=$HOME/.sdkman bash scr.sh" \
    atpull"SDKMAN_DIR=$HOME/.sdkman sdk selfupdate" atinit". $HOME/.sdkman/bin/sdkman-init.sh"
zinit light zdharma-continuum/null
zinit ice wait lucid; zinit light nobeans/zsh-sdkman

zinit snippet OMZL::history.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::completion.zsh

zinit snippet OMZP::git
zinit snippet OMZP::wd
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::fasd
zinit snippet OMZP::safe-paste
zinit snippet OMZP::sdk
zinit snippet OMZP::fzf

#load k3d completion
zinit light-mode lucid wait has"k3d" for \
  id-as"k3d_completion" as"completion" \
  atclone"k3d completion zsh > _k3d" \
  atpull"%atclone" run-atpull zdharma-continuum/null

zinit ice wait lucid atload'base16_summerfruit-light'; zinit light chriskempson/base16-shell
zinit ice wait lucid; zinit light djui/alias-tips
zinit ice wait lucid; zinit light wfxr/forgit
zinit ice wait lucid; zinit light lukechilds/zsh-nvm
#zinit ice wait lucid; zinit light SukkaW/zsh-proxy # disable proxy for now
zinit ice wait lucid; zinit light nnao45/zsh-kubectl-completion
zinit ice wait lucid; zinit light zdharma-continuum/history-search-multi-word
#zinit ice wait lucid; zinit light andrewferrier/fzf-z

#adding auto suggestion stuff
zinit ice wait lucid atinit"zicompinit"; zinit light Aloxaf/fzf-tab
zinit ice wait lucid atload'_zsh_autosuggest_start'; zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid; zinit light micha/resty
###################################################################################
# setting up remaining envs
###################################################################################

# load all dircolors due to windows madness
alias ls="exa --icons"
alias k="kubectl"
alias kw="watch kubectl"
alias vi=nvim
alias vim=nvim

source ~/.profile

# load kubectl plugins
export PATH="${PATH}:${HOME}/.krew/bin"

# setting random plugin/app parameters
PATH="${PATH}:${HOME}/.krew/bin"
PATH=$HOME/.local/bin:$PATH

unset ZLE_RPROMPT_INDENT
setopt HIST_IGNORE_ALL_DUPS

