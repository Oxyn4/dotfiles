# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

SYSFONTS="/usr/local/share/fonts/"
USERFONTS="~/.local/share/fonts/"

WALLS="~/.config/walls/"

EDITOR="nvim"

VISUAL="nvim"

BROWSER="firefox"

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
export PATH="$PATH"


# kitty shortcuts
alias icat="kitty +kitten icat"

# git shortcuts
alias gad="git add"
alias gin="git init ."
alias gco="git commit"

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

pmf() {
    sudo pacman -Syq $(echo $(cat $1))
}

#latex alias
alias mkpdf="pdflatex"

# pandoc alias 
# pancon file-to-be-converted original-filetype new-filetype
pancon() {
    pandoc $1 -f $2 -t $3 -s -o $4
}

# directory pivot
# cd into a directory in the parent directory
dp() {
    cd ../$1
}

bd(){
    cd ..
}

1bd(){
    cd ..
}

2bd() {
    cd ../..
}

3bd() {
    cd ../../..
}

nmconnect() {
    printf "Connect to the network via nmcli \n"
    printf "please enter your networks ssid: "
    read ssid
    printf "please enter wpa2 password: "
    read pass
    if [ -z $pass ]; then
        sudo nmcli dev wifi connect $ssid
        return
    fi 
    sudo nmcli dev wifi connect $ssid password $pass
}

nmdconnect() {
    printf "Disconnecting from a wifi network via nmcli \n"
    printf "Please enter your ssid: "
    read ssid
    sudo nmcli con down $ssid
}

alias nmscan="nmcli dev wifi list"

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
        neovide $1 --nofork
    else
        nvim $1
    fi
}

gh-ssh-gen() {
    printf "github email: \n"    
    read EMAIL
    ssh-keygen -q -t ed25519 -f ~/.ssh/github -C "$EMAIL"
    ssh-add ~/.ssh/github
    cat ~/.ssh/github.pub
}

#convert latex to pdf
alias tex2pdf="pdflatex" 

#youtube-dl shortcuts
alias yt="yt-dlp"

alias yta="yt-dlp -o '%(uploader)s_%(title)s.%(ext)s' -x --audio-format mp3 --prefer-ffmpeg "
alias ytan="yt-dlp --no-playlist -o '%(uploader)s_%(title)s.%(ext)s' -x --audio-format mp3 --prefer-ffmpeg "


alias mk= 'make -f makefile'

alias school_browser="firefox -p School"

alias weather="curl wttr.in"

alias clearclipboard="bleachbit --overwrite --clean system.clipboard"

alias shis="cat $HOME/.zsh_history | grep "

alias tm="tmux"
