FROM ubuntu:latest

# install linuxbrew
RUN apt-get update && \
    apt-get install sudo build-essential curl file git ruby-full locales --no-install-recommends -y && \
    rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN useradd -m -s /bin/bash linuxbrew && \
    echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER linuxbrew
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

USER root

RUN apt-get update && apt-get install zsh git python3 -y

# create dev user
RUN useradd --create-home --shell /usr/bin/zsh -G sudo dev && \
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
USER dev
WORKDIR /home/dev
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

# install dotfile defined tools & environment
COPY --chown=dev:dev . .dotfiles/
RUN git config --global --add safe.directory /home/dev/.dotfiles/dotbot/lib/pyyaml && \
    git config --global --add safe.directory /home/dev/.dotfiles/dotbot && \
    git config --global --add safe.directory /home/dev/.dotfiles

RUN bash -c 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && .dotfiles/install'
