To use, follow this advice:

https://stackoverflow.com/a/16811212/1698426

    git init .
    git remote add -t \* -f origin <repository-url>
    git checkout master

Create a python 3 virtual environment:

    $ python3 -m venv ~/.venv
    $ source ~/.venv/bin/activate
    $ pip install --upgrade pip powerline-status

Also, manually install oh-my-zsh and powerlevel10k, and nerd fonts (via brew for mac)

https://github.com/ohmyzsh/ohmyzsh
https://github.com/romkatv/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
