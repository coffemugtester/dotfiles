# TODO: Try qutebrowser
# TODO: Lazygit, ChatGPT on the CLI https://www.youtube.com/watch?v=5wy2iLU5fs0
# TODO: https://medium.com/aimonks/accessing-chatgpt-from-command-line-d65ba894c08 | https://medium.com/aimonks/accessing-chatgpt-from-command-line-d65ba894c08
# TODO: get script to download, install nvim and put it in path
# TODO: get vim for docs https://chromewebstore.google.com/detail/vim-for-google-docs/aphmodfjbhofkpibocbggkdfnpbpjmpp
# TODO: install docker and try applying nvim setup there -- reference: https://github.com/thomaspttn/nvim-docker/blob/main/install.sh lts nvim wget installed 
# TODO: ChatGPT for Neovim https://www.youtube.com/watch?v=7k0KZsheLP4
# TODO: ansible set up in config repo for the raspberry and the jetson
# TODO: figure out how to use ohmyzsh aliases in nvim
# TODO: create guest terminal user


export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # Load nvm
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # Optional: tab completion

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Terminal should use true color instead of being limited to 256 colors
# export COLORTERM=truecolor

autoload -Uz add-zsh-hook

add-zsh-hook -Uz precmd setup-bindkeys

setup-bindkeys() {
#Insert mode bindings
bindkey -M viins 'ö' forward-char
bindkey -M viins 'ü' up-line-or-search
bindkey -M viins 'ä' menu-complete
bindkey -M viins '^L' backward-kill-word
# bindkey -M viins 'ü' up-line-or-history
# bindkey -M viins 'ä' down-line-or-history

#Normal (command) mode bindings
bindkey -M vicmd 'ö' forward-char
bindkey -M vicmd 'ä' down-line-or-history
bindkey -M vicmd 'ü' history-incremental-search-backward
# bindkey -M vicmd 'ü' up-line-or-history

bindkey 'ä' menu-select
bindkey 'ü' up-line-or-search
  # Only run once
  add-zsh-hook -d precmd setup-bindkeys
}



# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

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
plugins=(git z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Source oh my zsh plugins 
source ./.zsh_plugins

# Starship
eval "$(starship init zsh)"

