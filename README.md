To use, follow this advice:

https://stackoverflow.com/a/16811212/1698426

    git init .
    git remote add -t \* -f origin <repository-url>
    git checkout master

Create a python 3 virtual environment: (powerline-status might need to go away)

    $ python3 -m venv ~/.venv
    $ source ~/.venv/bin/activate
    $ pip install --upgrade pip powerline-status


Also, manually install oh-my-zsh, powerlevel10k, and zsh-autosuggestions:

    $ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    $ git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    $ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


- [oh my zsh](https://github.com/ohmyzsh/ohmyzsh)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)


