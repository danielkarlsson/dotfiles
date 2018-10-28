set langmenu=en_US.UTF-8    " sets the language of the menu (gvim)
let $LANG = 'en'

call plug#begin('~/.config/nvim/plugged')

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go'
Plug 'carlitux/deoplete-ternjs'
Plug 'steelsojka/deoplete-flow'
Plug 'HerringtonDarkholme/yats.vim'

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
Plug 'mxw/vim-jsx'
Plug 'vim-scripts/smarty-syntax'
Plug 'mustache/vim-mustache-handlebars'

" Syntax
Plug 'mhartington/oceanic-next'
Plug 'styled-components/vim-styled-components'
Plug 'posva/vim-vue'
Plug 'junegunn/seoul256.vim'

call plug#end()

syntax enable
filetype plugin indent on

let g:seoul256_background = 235
colo seoul256

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
let NERDTreeShowHidden=1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'zenburn'

" neoformat
"
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

let g:neoformat_enabled_python = ['yapf']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_run_all_formatters = 1

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

" vim-jsx

let g:jsx_ext_required = 0

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
set tabstop=2
set shiftwidth=2
set expandtab
set cc=80
set conceallevel=0

" elm
let g:elm_format_autosave = 1

" enable syntastic for javascript files
let g:syntastic_javascript_checkers = ['flow', 'eslint']
let g:syntastic_javascript_flow_exe = 'flow'
let g:syntastic_javascript_eslint_exe = 'eslint --fix'

" Aliases for commonly used commands+lazy shift finger:
command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Write     <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq        <line1>,<line2>wq<bang> <args>
command! -bar                                  -bang Wqall     wqa<bang>
command! -bar -nargs=* -complete=file -range=% -bang We        <line1>,<line2>w<bang> | e <args>
command! -bar -nargs=* -complete=file -count   -bang Wnext     <count>wnext<bang> <args>
command! -bar -nargs=* -complete=file -count   -bang Wprevious <count>wprevious<bang> <args>
command! -bar -nargs=* -complete=file          -bang E         edit<bang> <args>
command! -bar -nargs=* -complete=file          -bang Edit      edit<bang> <args>
command! -bar                                  -bang Q         quit<bang>
command! -bar                                  -bang Quit      quit<bang>
command! -bar                                  -bang Qall      qall<bang>
command! -bar -nargs=? -complete=option              Set       set <args>
command! -bar -nargs=? -complete=help                Help      help <args>
command! -bar -nargs=* -complete=file          -bang Make      make<bang> <args>
command! -bar -nargs=* -complete=buffer        -bang Bdel      bdel<bang> <args>
command! -bar -nargs=* -complete=buffer        -bang Bwipe     bwipe<bang> <args>
command! -bar -nargs=* -complete=file          -bang Mksession mksession<bang> <args>
command! -bar -nargs=* -complete=dir           -bang Cd        cd<bang> <args>
command! -bar                                        Messages  messages
command! -bar -nargs=+ -complete=file          -bang Source    source<bang> <args>
