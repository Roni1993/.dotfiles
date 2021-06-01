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
install build-essential
install cmake
install file
install zip
install tree
install curl
install httpie
install zsh 
install tmux
install neovim
install bashtop

# Install Homebrew
which brew &> /dev/null
if [ $? -ne 0 ]; then
  echo "Installing: Homebrew..."
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
else
  echo "Already installed: Homebrew"
fi

# cli ux
install fzf
bin-install cheat "https://cht.sh/:cht.sh"
brew install fasd

# dev
brew install watchman
install lazygit
install jq
bin-install jtc https://github.com/ldn-softdev/jtc/releases/download/LatestBuild/jtc-linux-64.v1.76a

# k8s helper
brew install kubectl
brew install kubectx
brew install helm

# beautiful/better drop ins
install ripgrep
install fd
brew install exa
brew install bat
brew install git-delta

