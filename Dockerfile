FROM ubuntu:latest

RUN ./install

# create dev user
RUN useradd --create-home --shell /usr/bin/zsh -G sudo dev
USER dev

RUN zsh -c "zi update"

