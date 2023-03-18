FROM ubuntu:latest

RUN apt-get update && apt install zsh -y

# create dev user
RUN useradd --create-home --shell /usr/bin/zsh -G sudo dev
USER dev
WORKDIR /home/dev

# install dotfile defined tools & environment
COPY . .dotfiles/
RUN .dotfiles/install
