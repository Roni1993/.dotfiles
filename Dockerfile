FROM ubuntu:latest

USER dev

RUN ./install
RUN chsh -s $(which zsh)
RUN zsh -c "zi update"

