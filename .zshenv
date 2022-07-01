. "$HOME/.cargo/env"

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

texview() {

    latexmk -view=pdf -pdf -pvc $1 &

}

nv() {
    if -z "$1"; then
        neovide .; exit
    else
        neovide $1; exit
    fi
}

#convert latex to pdf
alias tex2pdf="pdflatex" 

#youtube-dl shortcuts
alias yt="youtube-dl"
alias yta="youtube-dl -x -f bestaudio"

# suffix aliases 
alias -s jpg="icat"
alias -s png="icat"
alias -s txt="nvim"
alias -s html="nvim"

