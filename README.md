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
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git submodule update --init --recursive
    p10k configure

### Bugs

- I have zsh-autosuggestions in two places....?
  . .zsh/zsh-autosuggestions
  . ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


### Up Next?

- https://www.reddit.com/r/vim/comments/k1ydpn/a_guide_on_how_to_copy_text_from_anywhere/
    - https://github.com/ojroques/vim-oscyank
- https://github.com/dpelle/vim-LanguageTool
- https://www.reddit.com/r/neovim/comments/k5dykf/neovim_makes_a_great_manpager_especially_on_macos/
    - export MANPAGER='nvim +Man!'
    - gO <- killer feature
- https://github.com/dbmrq/vim-dialect
  project specific spell files, e.g. words added with zG and zW
- https://github.com/mitsuhiko/vim-jinja better highlighting for jinja files
- vifm.vim requires vifm
  - Not sure I care for vifm, might nuke it

### Brew

brew tap homebrew/cask-fonts
brew install vimr exa ranger tmux htop pidof vifm
brew install --cask font-bitstream-vera-sans-mono-nerd-font \
    font-dejavu-sans-mono-nerd-font \
    font-fira-code \
    font-fira-mono-nerd-font \
    font-juliamono \
    font-liberation-nerd-font \
    font-sauce-code-pro-nerd-font \
    font-source-code-pro \
    font-inconsolata-nerd-font \
brew install --cask aerial
pylint


### TIL

* `${!foo}` => indirect expansion!
 
### Bookmarks for future projects

- https://askubuntu.com/questions/821157/print-a-256-color-test-pattern-in-the-terminal <- lots of links
- https://news.ycombinator.com/item?id=25564555
    - The whole thread is about dotfiles
    - The idea here seems to be that the dotfiles git repo is not directly in $$HOME but it is in $$HOME/dotfiles
    - With the right git arguments, the files end up in $HOME/whatever
    - https://www.atlassian.com/git/tutorials/dotfiles
    - `https://www.atlassian.com/git/tutorials/dotfiles`
    - `https://news.opensuse.org/2020/03/27/Manage-dotfiles-with-Git/`
- stderr in red https://stackoverflow.com/questions/6841143/how-to-set-font-color-for-stdout-and-stderr/21320645#21320645
- https://typer.tiangolo.com/ CLI apps, uses click, 
- https://github.com/willmcgugan/rich rich text and colours in a terminal
- https://github.com/onelivesleft/PrettyErrors better looking stack traces
- https://github.com/marlonrichert/zsh-hist
- https://www.reddit.com/r/git/comments/ko3tnf/gitcompletion_13_released/ git-completion

### Historical notes

- The powerline module gave me too much trouble, so I'm configuring that manually now, so I don't need the python virtual environment anymore
