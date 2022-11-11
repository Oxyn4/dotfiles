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
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard
filetype plugin on          " Aloow vim to load filetype plugins 
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set nowrap                  "  make it so long lines do not get spanned across two lines 
set so=999                  " context Scolling 
set colorcolumn=0           " Get rid of weird red bar on screen
set nocompatible            " disables vi compatibility
set shell=/usr/bin/zsh
"set spell

" map leader 
nnoremap <SPACE> <Nop>
let g:mapleader=' '

" Enable 24-bit true colors if your terminal supports it.
if (has("termguicolors"))
    " https://github.com/vim/vim/issues/993#issuecomment-255651605
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    set termguicolors
endif

" highlights yanked text
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" enables hybrid numbers in normal 
" but absolute in insert
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" maps ctrl+<arrow key> to move around window panes and splis
map <C-up> <C-w><up> 
map <C-down> <C-w><down>
map <C-left> <C-w><left>
map <C-right> <C-w><right>

function! LaunchIntergratedTerm()
    :terminal zsh
    :set nonumber
    :startinsert 
endfunction

" maps esc to leave terminal mode
:tnoremap <Esc> <C-\><C-n>

" map ctrl-x to open zsh in terminal
nmap <silent><C-x> :call LaunchIntergratedTerm()<CR>

" refresh vim
" nmap <F10> :source ~/.config/nvim/init.vim<CR>

function! Test()
    :NvimTreeOpen
    let nvid=win_getid()
    wincmd p
    :AerialToggle
    let soid=win_getid()
    call win_splitmove(soid, nvid, {"rightbelow": v:true})
    res -30
endfunction

function! PlugInstallOxyn()
    :NvimTreeClose
    :PlugInstall
endfunction

function! PlugCleanOxyn()
    :NvimTreeclose
    :PlugClean
endfunction

" plug shortcuts
nmap <F10> :Mason<CR>
nmap <F11> :call PlugInstallOxyn()<CR>
nmap <F12> :call PlugCleanOxyn()<CR>

" automatically install vim plug if missing
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin management

call plug#begin("~/.config/nvim/plugins/")

" Nerdtree plugins
" Plug 'preservim/nerdtree' |
"            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
"            \ Plug 'ryanoasis/vim-devicons'



"Plug 'vwxyutarooo/nerdtree-devicons-syntax'

" broken in neovim 0.8.0
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " more color in nerdtree

Plug 'lewis6991/impatient.nvim' " speed up loading with a cache for lua

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " treesitter, syntax hightlighting
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" neovim library 
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'

"Plug 'neoclide/coc.nvim', {'branch': 'release'} " adds code compelation and error highlighting

"Plug 'sonph/onehalf', { 'rtp': 'vim' }          " Colourshceme 
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
" Plug 'catppuccin/nvim'

"Plug 'preservim/tagbar'                         " view and navigate to methods class and functions 
"Plug 'liuchengxu/vista.vim'                       " view and navigate to methods class and functions 
"Plug 'simrat39/symbols-outline.nvim'  " view and navigate to methods class and functions 
Plug 'stevearc/aerial.nvim' " view and navigate to methods class and functions  

" fzf plugins 
" needs ripgrep executable https://github.com/BurntSushi/ripgrep
if executable("rg")
    Plug 'nvim-telescope/telescope.nvim' " search for things
    " a C language algorithm for sorting results of telescope
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    Plug 'nvim-telescope/telescope-project.nvim' " project manager for telescope 
endif

" lsp plugins
" lsp installation and configuation
Plug 'williamboman/mason.nvim' " easily install lsp servers
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig' " configure lsp servers

" lsp completion engine
Plug 'hrsh7th/nvim-cmp' " general completion menu
Plug 'hrsh7th/cmp-nvim-lsp' " completion for lsp
Plug 'hrsh7th/cmp-buffer' 
Plug 'hrsh7th/cmp-path' " file path completion
Plug 'hrsh7th/cmp-cmdline' " completion for the command line

" formatters 
" Plug 'jose-elias-alvarez/null-ls.nvim'

" adds completion type icons to nvim-cmp
" Plug 'onsails/lspkind.nvim'

" comment plugin 
Plug 'terrortylor/nvim-comment'

" snippet plugins
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" git plugins 
if executable("git")
    Plug 'tpope/vim-fugitive' " vim git intergration
    Plug 'airblade/vim-gitgutter' " show changed lines next to toggle_numbers
endif

Plug 'lervag/vimtex' " adds latex support


Plug 'rcarriga/nvim-notify' " adds pretty notifications 

Plug 'lukas-reineke/indent-blankline.nvim' " indentation guides

" Plug 'sindrets/winshift.nvim' " 

Plug 'norcalli/nvim-colorizer.lua' " highlights hex colours in vim with the correct colour 

Plug 'moll/vim-bbye' " better buffer removing 

" statusbar
Plug 'nvim-lualine/lualine.nvim'
"Plug 'itchyny/lightline.vim' " lighline statusbar

" buffer line 
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

" custom modes  
Plug 'anuvyklack/hydra.nvim' 

" makes buffers belong to tabs
Plug 'tiagovla/scope.nvim'

" pair plugin
Plug 'windwp/nvim-autopairs'

Plug '~/.config/nvim/plugins/oxyn'

call plug#end()

" recurively load any .lua or .vim file in the ~/.config/vim-plugins-config dir
for f in split(glob('~/.config/nvim/plugins-config/*'), '\n')
    exe 'source' . f
endfor

" set esc to :noh which disables highlighting 
nnoremap <silent> <esc> :noh<cr><esc>

" load colourscheme
"colorscheme onehalfdark
"colorscheme tokyonight-night
colorscheme tokyonight-moon

" lua << EOF
" require("catppuccin").setup {
    " flavour = "macchiato" -- mocha, macchiato, frappe, latte
" }
" EOF
" colorscheme catppuccin

" gui and tui specific settings 
if exists("g:neovide")

    let g:neovide_transparency=0.8 " change neovide bg tranparency
    
    let g:neovide_refresh_rate=30 " change neovide refresh rate 
    
    let g:neovide_cursor_antialiasing=v:true
else
    " modify colourscheme to work with tranparency

    "tramsperant bg behind numbers                                             
    "autocmd vimenter * highlight clear LineNr
    "transparent SignColumn
    "autocmd vimenter * highlight clear SignColumn
    "transparent bg
    "autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
    " For Vim<8, replace EndOfBuffer by NonText
    "autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
endif


" load initialize.lua and do lua stuff
luafile ~/.config/nvim/initialize.lua
