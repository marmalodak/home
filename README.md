To use, follow this advice:

https://stackoverflow.com/a/16811212/1698426

    git init .
    git remote add -t \* -f origin <repository-url>
    git checkout master

Also, manually install oh-my-zsh, powerlevel10k, ~zsh-autosuggestions~, and nerd fonts (via brew for mac)

    $ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    $ git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    ~$ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions~

`zsh-autosuggestions` is a submodule now

- [oh my zsh](https://github.com/ohmyzsh/ohmyzsh)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

On a new installation, I usually want:

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    ~git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions~
    git submodule update --init --recursive
    p10k configure

### Historical notes

- The powerline module gave me too much trouble, so I'm configuring that manually now, so I don't need the python virtual environment anymore
- zsh-autosuggestions is now a submodule
