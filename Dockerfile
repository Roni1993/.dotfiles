FROM ubuntu:latest

RUN apt-get update && apt install zsh git python3 -y

# # create dev user
# RUN useradd --create-home --shell /usr/bin/zsh -G sudo dev
# USER dev
# WORKDIR /home/dev

# install dotfile defined tools & environment
COPY . .dotfiles/
RUN git config --global --add safe.directory /home/dev/.dotfiles/dotbot/lib/pyyaml && \
    git config --global --add safe.directory /home/dev/.dotfiles/dotbot && \
    git config --global --add safe.directory /home/dev/.dotfiles

RUN .dotfiles/install
