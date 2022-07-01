set ignorecase " ignore case when searching
set number " adds numbers to the right side of the screen
set shiftwidth=4 
set hlsearch 
set showmatch
set noswapfile
set expandtab
set encoding=UTF-8 " set the encoding to UTF=8 
set nocompatible " disable vi compat that can cause issues
set ttyfast " faster scrolling
set nowrap
set tabstop=4
set sidescroll=1
set so=999

" Enable 24-bit true colors if your terminal supports it.
if (has("termguicolors"))
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  set termguicolors
endif

" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

syntax on " syntax highlighting
filetype on " vim recognises file types
filetype plugin on " load plugin filetpye reconisations
filetype indent on " load plugin indent files

" moving between windows
map <C-up> <C-w><up>
map <C-down> <C-w><down>
map <C-left> <C-w><left>
map <C-right> <C-w><right>

"resize mode function
"nnoremap <up> :res +5<CR><up>
"nnoremap <down> :res -5<CR><down>


" use ctrl q to force quit
nnoremap <C-Q> :q!<CR><C-Q>

function PreviewDoc()

    let FilePath = expand('%:t')
           
    let FileExtension = &filetype

    if FileExtension == "markdown"

        let FileName = expand('%:t:r')
    
        :execute "term md2pdf " . FilePath

        ":execute "term mdview " . FileName . ".pdf"

    endif    

endfunction

" latex autorefresh
nnoremap <C-X> :call PreviewDoc()<CR><C-X> 

" intergrated terminal config
" escape terminal with escape key
set termwinkey=<esc>

"nnoremap <C-X> :term<CR><C-X>

"set cursor as a line in insert
:autocmd InsertEnter,InsertLeave * set cul!

" make cursor line hightlighting transperant
:hi CursorLine cterm=underline term=underline ctermbg=NONE guibg=NONE

" recurively load any .vim file in the ~/.config/vim-plugins-config dir
for f in split(glob('~/.config/vim-plugins-config/*.vim'), '\n')
    exe 'source' f
endfor

call plug#begin("~/.vim/plugged")

    Plug 'preservim/nerdtree' " adds a file explorer 
    Plug 'ryanoasis/vim-devicons' " adds icons to the nerd tree file explorer 
    Plug 'ap/vim-css-color' " highlights hex colour codes in the actual colour
    Plug 'vim-scripts/taglist.vim' " adds an outline feature allowing you to jump to class and function defs
    Plug 'preservim/nerdcommenter' " adds convient commenting shortcuts 
    Plug 'sonph/onehalf', { 'rtp': 'vim' }
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'

"tramsperant bg behind numbers
autocmd vimenter * highlight clear LineNr
"transparent SignColumn
autocmd vimenter * highlight clear SignColumn
" transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
" For Vim<8, replace EndOfBuffer by NonText
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
