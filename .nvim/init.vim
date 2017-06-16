set langmenu=en_US.UTF-8    " sets the language of the menu (gvim)
let $LANG = 'en'

call plug#begin('~/.config/nvim/plugged')

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go'
Plug 'carlitux/deoplete-ternjs'
Plug 'steelsojka/deoplete-flow'

" Utils
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'neomake/neomake'
Plug 'ap/vim-css-color'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'tell-k/vim-autopep8'
Plug 'schickling/vim-bufonly'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'


" Airline and guides
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'

" Languages
Plug 'pangloss/vim-javascript'
Plug 'neovimhaskell/haskell-vim'
Plug 'fatih/vim-go'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'reasonml/vim-reason'

" Syntax
Plug 'mhartington/oceanic-next'


call plug#end()

syntax enable
filetype plugin indent on
colorscheme OceanicNext

if (has("termguicolors"))
    set termguicolors
endif

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.ocaml = '[.\w]+'
let g:deoplete#omni#input_patterns.reason = '[.\w]+'

" nerdtree
map <C-z> :NERDTreeToggle<CR>

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'oceanicnext'

" neoformat
"
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

let g:neoformat_enabled_python = ['yapf']
let g:neoformat_enabled_javascript = ['prettier']

" neomake
let g:neomake_python_python_maker = {
    \ 'exe': 'python3',
    \ }

let g:neomake_logfile=$HOME.'/.dotfiles/.nvim/log/neomake.log'
let g:neomake_javascript_enabled_makers = ['flow']

autocmd! BufWritePost * Neomake

" javascript
"
let g:deoplete#sources#flow#flow_bin = 'flow'

function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

if g:flow_path != 'flow not found'
  let g:deoplete#sources#flow#flow_bin = g:flow_path
endif

" reason

autocmd FileType reason map <buffer> <D-M> :ReasonPrettyPrint<Cr>

let g:neomake_reason_enabled_makers = ['merlin']
let g:vimreason_extra_args_expr_reason = '"--print-width 80"'

" neosnippet

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" git gutter

let g:gitgutter_updatetime = 250

" ctrl p
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|deps\|_build\|\v\.(o|hi)$'

" indent guides
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0

" misc
set clipboard=unnamed
set splitbelow
set splitright
set backupcopy=yes
set termguicolors
set number
set tabstop=4
set shiftwidth=4
set expandtab
set cc=80

" elm
let g:elm_format_autosave = 1
