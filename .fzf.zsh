# Setup fzf
# ---------
if [[ ! "$PATH" == */home/porcelain_/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/porcelain_/.fzf/bin"
fi

source <(fzf --zsh)
