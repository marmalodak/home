# Who wrote this file? `brew install fzf`?
# Setup fzf
# ---------
# fzf is already in the path, no need to munge it
# if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
#   PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
# fi

if [[ $- == *i* ]]; then
  if command -v brew; then
    brew_path=$(brew --prefix)
    if [[ ${brew_path} == "/opt/homebrew" ]]; then
      source "${brew_path}/opt/fzf/shell/completion.zsh" 2> /dev/null
    else
      completion_path=$(fd completion.zsh ${brew_path})
      source ${completion_path} 2> /dev/null
    fi
  fi
  [[ -f /usr/share/zsh/site-functions/fzf/completion.zsh ]] && source /usr/share/zsh/site-functions/fzf/completion.zsh
fi

if [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
  source /usr/share/fzf/shell/key-bindings.zsh
elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then # ubuntu
  source /usr/share/doc/fzf/examples/key-bindings.zsh
else
  key_bindings=$(fd key-bindings.zsh $(brew --prefix))
  source ${key_bindings}
fi
