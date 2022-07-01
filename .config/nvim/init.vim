set number                  " add line numbers to side of screen 
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard
filetype plugin on          " Aloow vim to load filetype plugins 
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set nowrap                  "  make it so long lines do not get spanned across two lines 
set so=999                  " context Scolling 
set colorcolumn=0           " Get rid of weird red bar on screen
set nocompatible            " disables vi compatibility
set mouse=a                 " make mouse usable 
set shell=/usr/bin/zsh

" load lua init file

" Enable 24-bit true colors if your terminal supports it.
if (has("termguicolors"))
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  set termguicolors
endif

" maps ctrl+<arrow key> to move around window panes and splis
map <C-up> <C-w><up> 
map <C-down> <C-w><down>
map <C-left> <C-w><left>
map <C-right> <C-w><right>

function! LaunchIntergratedTerm()
    :vsplit term://zsh
    :set nonumber
    :startinsert  
endfunction

" maps esc to leave terminal mode
:tnoremap <Esc> <C-\><C-n>

" map ctrl-x to open zsh in terminal
nmap <silent><C-X> :call LaunchIntergratedTerm()<CR>

" refresh vim
nmap <F10> :source ~/.config/nvim/init.vim<CR>

" recurively load any .vim file in the ~/.config/vim-plugins-config dir
for f in split(glob('~/.config/nvim/plugins-config/*.vim'), '\n')
    exe 'source' f
endfor

" plug shortcuts
nmap <F11> :PlugInstall<CR>
nmap <F12> :PlugClean<CR>

" automatically install vim plug if missing
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin management

call plug#begin("~/.config/nvim/plugins/")

" Nerdtree plugins
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'        

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " more color in nerdtree

Plug 'neoclide/coc.nvim', {'branch': 'release'} " adds code compelation and error highlighting

Plug 'sonph/onehalf', { 'rtp': 'vim' }          " Colourshceme 

Plug 'preservim/tagbar'                         " view and navigate to methods class and functions 

" git plugins 

Plug 'tpope/vim-fugitive'                       " vim git intergration
Plug 'airblade/vim-gitgutter'                   " show changed lines next to numbers

Plug 'ap/vim-css-color'                         " highlight hex colours in files with the actual  

Plug 'itchyny/lightline.vim'                    " lighline statusbar


call plug#end()

" load colourscheme
colorscheme onehalfdark

function PreviewDoc()

    let FilePath = expand('%:t')

    let FileExtension = &filetype

    if FileExtension == "tex"
        "let FileName = expand('%:t:r')
        ":execute "!pdflatex -no-file-line-error -shell-escape -shell-restricted " . FilePath 
        ":execute "!mupdf " . FileName . ".pdf "
        ":execute "!rm " . FileName . ".pdf"

        :execute ":!latexmk -view=pdf -pdf -pvc " . FilePath . " &"

    endif   

    if FileExtension == "markdown"
        
        :execute "!mdview " . FilePath

    endif

    "echo FilePath

endfunction

" latex autorefresh
nnoremap <C-Z> :call PreviewDoc()<CR> 

" custom submode for resizing windows

nnoremap + :call ToggleResizeMode()<CR>

let s:KeyResizeEnabled = 0

function! ToggleResizeMode()
  if s:KeyResizeEnabled
    call NormalArrowKeys()
    let s:KeyResizeEnabled = 0
  else
    call ResizeArrowKeys()
    let s:KeyResizeEnabled = 1
  endif
endfunction

function! NormalArrowKeys()
  " unmap arrow keys
  echo 'Normal'
  nunmap <Up>
  nunmap <Down>
  nunmap <Left>
  nunmap <Right>
endfunction

function! ResizeArrowKeys()
  " Remap arrow keys to resize window

    function! Up()
        :resize -2
        :echo "Resize"
    endfunction

    function! Down()
        :resize +2
        :echo "Resize"
    endfunction

    function! Left()
        :vertical resize +2
        :echo "Resize"
    endfunction

    function! Right()
        :vertical resize -2
        :echo "Resize"
    endfunction

    nnoremap <silent><Up> :call Up() <CR>
    nnoremap <silent><Down> :call Down() <CR>
    nnoremap <silent><Left> :call Left() <CR>
    nnoremap <silent><Right> :call Right() <CR>
endfunction

" gui and tui specific settings 
if exists("g:neovide")

    let g:neovide_transparency=0.8 " change neovide bg tranparency
    
    let g:neovide_refresh_rate=30 " change neovide refresh rate 

    function CreateKitty()
        if tabpagenr('$') == 1 && winnr('$') == 1 
          :!kitty &
          :q 
        endif
    endfunction
    
    autocmd QuitPre * call CreateKitty()
else
    " modify colourscheme to work with tranparency

    "tramsperant bg behind numbers                                             
    autocmd vimenter * highlight clear LineNr
    "transparent SignColumn
    autocmd vimenter * highlight clear SignColumn
    "transparent bg
    autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
    " For Vim<8, replace EndOfBuffer by NonText
  autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
endif


