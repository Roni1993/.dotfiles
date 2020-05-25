#!/bin/bash

sudo add-apt-repository -y ppa:lazygit-team/release
sudo add-apt-repository -y ppa:bashtop-monitor/bashtop

sudo apt update && sudo apt full-upgrade -y

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

function bin-install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo curl -L "$2" -o "/usr/local/bin/$1"
    sudo chmod +x "/usr/local/bin/$1"
  else
    echo "Already installed: ${1}"
  fi
}

function tar-install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    curl -L "$2" | sudo tar xfvz - -C "/usr/local/bin" --strip-components=1 --wildcards "*/$1"
    sudo chmod +x "/usr/local/bin/$1"
  else
    echo "Already installed: ${1}"
  fi
}

# Basics
install unzip
install tree
install curl
install httpie
install zsh 
install tmux
install neovim
install bashtop

# cli ux
install fzf
bin-install cheat "https://cht.sh/:cht.sh"
tar-install fasd "https://github.com/clvv/fasd/tarball/1.0.1"

# dev
install git
install lazygit
install jq
bin-install jtc https://github.com/ldn-softdev/jtc/releases/download/LatestBuild/jtc-linux-64.v1.76a

#sdkman  
if [ ! -d "$SDKMAN_DIR" ]; then
  curl -s "https://get.sdkman.io" | bash
  source "/home/rowe/.sdkman/bin/sdkman-init.sh"
fi

# cloud-dev
bin-install odo https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-linux-amd64

# beautiful drop ins
install bat
tar-install lsd "https://github.com/Peltoche/lsd/releases/download/0.17.0/lsd-0.17.0-x86_64-unknown-linux-gnu.tar.gz"
tar-install delta "https://github.com/dandavison/delta/releases/download/0.1.1/delta-0.1.1-x86_64-unknown-linux-gnu.tar.gz"

