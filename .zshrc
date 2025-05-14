# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
export PATH=$PATH:/usr/local/go/bin
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

#export PATH=$PATH:"/home/porcelain/.local/bin"
#export PATH=$PATH:"/snap/bin/"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Changing "ls" to "exa"
alias ls='eza --icons --color=always --group-directories-first'
alias ll='eza -alF --icons --color=always --group-directories-first'
alias la='eza -a --icons --color=always --group-directories-first'
alias l='eza -F --icons --color=always --group-directories-first'
alias l.='eza -a | egrep "^\."'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ========================
# 🚀 Zsh + p10k 強化版
# ========================

# 1. 增強自動補齊顯示 (你已經有 zsh-autosuggestions，我幫你加漂亮顏色)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'  # 自動補齊提示字設定成柔和灰色

# 2. 智能歷史搜尋（上下鍵快速補指令）
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# 3. 加強 Ctrl+R 搜尋歷史（如果你有裝 fzf，會更強）
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi

# 4. 指令錯誤高亮提示（看錯字一眼就知道）
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'

# 5. 把補齊列表變超帥（分組 + 直排）
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*' list-colors ''

# 6. 加速 zsh 啟動（compinit快取）
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache

# ========================
# ========================
# 🚀 fzf 超神版設定
# ========================

# 1. fzf 基本環境設定
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 2. Ctrl+R 搜尋歷史紀錄強化版
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" 2> /dev/null || find . -type f'
export FZF_CTRL_R_OPTS='
  --reverse
  --prompt="History> "
  --preview="echo {}"
  --preview-window=down:3:wrap
  --bind=ctrl-j:down,ctrl-k:up
  --color=prompt:6,marker:1,spinner:2
'

# 3. Ctrl+T 搜尋檔案強化版
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='
  --preview="bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {}"
  --preview-window=right:60%
'

# 4. Alt+C 搜尋資料夾強化版
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS='
  --preview="tree -C {} | head -200"
  --preview-window=right:50%
'

# 5. 顏色主題 (讓fuzzy時的選取超清楚)
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --info=inline
  --marker="*"
  --color=fg:#d0d0d0,bg:#1b1b1b,hl:#ff79c6
  --color=fg+:#ffffff,bg+:#303030,hl+:#8be9fd
  --color=info:#bd93f9,prompt:#ff79c6,pointer:#ffb86c
  --color=marker:#50fa7b,spinner:#f1fa8c,header:#6272a4
'

# ========================
git-switch() {
  local branch
  branch=$(git branch --all --color=always | grep -v HEAD | fzf --ansi --multi --tac --preview="git log --oneline --graph --color=always --pretty=format:'%C(auto)%h%d %s %C(black)%C(bold)%cr' $(echo {} | sed 's/.* //' )" --preview-window=right:70%)
  branch=$(echo $branch | sed 's/.* //' | sed 's#remotes/[^/]*/##')
  if [[ -n "$branch" ]]; then
    git checkout "$branch"
  fi
}
