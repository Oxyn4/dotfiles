# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

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
plugins=(git zsh-syntax-highlighting)

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

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# add chess arena to path so Dmenu can find it
export PATH="$HOME/Downloads/arena/:$PATH"

# config shortcuts
# loads config files in nvim
alias zshconfig="nvim ~/.zshrc"
alias vimconfig="nvim ~/.vimrc"
alias kittyconfig="nvim ~/.config/kitty/kitty.conf"
alias xinitconfig="nvim ~/.xinitrc"
alias bashrcconfig="nvim ~/.bashrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias dmenuconfig="nvim ~/.config/demnu"
alias i3config="nvim ~/.config/i3/config"
alias i3statusconfig="nvim ~/.config/i3status/config"
alias picomconfig="nvim ~/.config/picom/picom.conf"

# kitty shortcuts
alias icat="kitty +kitten icat"

# git shortcuts
alias gad="git add"
alias gin="git init ."
alias gco="git commit"

# saves login token for github
alias cache-git="git config --global credential.helper cache"
alias clear-cache-git="git config --global --unset credential.helper;git config --system --unset credential.helper"

# vim aliases
alias vim="nvim"
alias vi="nvim"

# general shortcuts
alias cl="clear"
alias untar="tar -xvf"

# pacman shortcuts
alias pm="pacman"
alias pmi="sudo pacman -S"
alias pmr="sudo pacman -R"
alias pmu="sudo pacman -Syu"

#latex alias
alias mkpdf="pdflatex"

# pandoc alias 
# pancon file-to-be-converted original-filetype new-filetype
pancon() {
    pandoc $1 -f $2 -t $3 -s -o $4
}

# markdown to pdf conversion
md2pdf() {

    # get name without .md 
    FileName=$(echo $1 | cut -f 1 -d '.')
    
    pancon $1 markdown pdf "$FileName.pdf"
}

md2html() {
    FileName=$(echo $1 | cut -f 1 -d '.')

    pancon $1 markdown html "$FileName.html"
}

# preview markdown
mdview() {
    #convert to pdf
    md2pdf $1

    FileName=$(echo $1 | cut -f 1 -d '.')

    # launch mu with newly generated pdf file\
    LaunchMu() {
        mupdf "$1.pdf"
        rm "$1.pdf"
    }
    
    # launch mu in background 
    LaunchMu $FileName & 
}

nv() {
    # if graphical enviroment
    if [ -n "$DISPLAY" ]; then
        # if first argument empty 
        if -z "$1"; then
            neovide .; exit
        else
            neovide $1; exit
        fi
    else
        if -z "$1"; then
            nvim .; exit
        else
            nvim $1; exit
        fi
    fi
}

#convert latex to pdf
alias tex2pdf="pdflatex" 

#youtube-dl shortcuts
alias yt="youtube-dl"
alias yta="youtube-dl -x -f bestaudio"

alias con='git --git-dir=$HOME/dotfiles --work-tree=$HOME'

# suffix aliases 
alias -s jpg="icat"
alias -s png="icat"
alias -s txt="nvim"
alias -s html="nvim"
alias -s pdf="mupdf"
