FROM ubuntu:latest

# install linuxbrew
RUN apt-get update && \
    apt-get install sudo build-essential curl file git ruby-full locales zsh python3 ssh --no-install-recommends -y && \
    rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN useradd --create-home --shell /usr/bin/zsh dev && \
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER dev
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
SHELL [ "/usr/bin/zsh", "-c" ]
WORKDIR /home/dev
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

# install main packages to keep docker layer cache
COPY --chown=dev:dev aptinstall.sh .dotfiles/
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    .dotfiles/aptinstall.sh && \
    sudo rm -rf /var/lib/apt/lists/*

# install dotfile defined tools & environment
COPY --chown=dev:dev . .dotfiles/
RUN git config --global --add safe.directory /home/dev/.dotfiles/dotbot/lib/pyyaml && \
    git config --global --add safe.directory /home/dev/.dotfiles/dotbot && \
    git config --global --add safe.directory /home/dev/.dotfiles

RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && .dotfiles/install
RUN zsh -ilc "source ~/.zshrc; zinit update --all"
# RUN nvm install --lts 
# RUN npm install -g pnpm

USER root
CMD /usr/bin/zsh