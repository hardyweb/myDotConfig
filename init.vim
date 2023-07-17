call plug#begin("~/.local/share/nvim/plugged")

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }
" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
"Plug 'terryma/vim-multiple-cursors'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mattn/emmet-vim'
" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
" Initialize plugin system
" Include Phpactor
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
" Require ncm2 and this plugin
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'phpactor/ncm2-phpactor'
Plug 'reedes/vim-pencil'
Plug 'psliwka/vim-smoothie'
"Plug 'vim-pandoc/vim-pandoc-syntax' :
Plug 'StanAngeloff/php.vim'
Plug 'honza/vim-snippets'
Plug 'Chiel92/vim-autoformat'
Plug 'rstacruz/vim-closer'
"Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'koturn/vim-mplayer'

Plug 'sbdchd/neoformat'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'jwalton512/vim-blade'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mengelbrecht/lightline-bufferline'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
call plug#end()


set number
set relativenumber
set cursorline
set autoindent
set smartindent

filetype indent on
set filetype=html          
colorscheme default
set backspace=indent,eol,start
let g:python3_host_prog = '/usr/bin/python3'
 
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_ll_word_key = '<A-n>'
let g:mulrti_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
set modifiable 
set mouse=a
let g:NERDTreeMouseMode=3
set guifont=Hack:12
let g:user_emmet_leader_key=','
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
 
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  elseif bufname('%')
    exe ":NERDTreeFind"
  else
    exe ":NERDTreeCWD"
  endif
endfunction
" Basic
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" coc-snippets
let g:coc_snippets_next = '<C-n>'
let g:coc_snippets_prev = '<C-e>'
imap <silent> <C-s> <Plug>(coc-snippets-expand)
vmap <silent> <C-j> <Plug>(coc=snippets-select)
" Others
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gk :call <SID>show_documentation()<CR>
xnoremap <leader>a  <Plug>(coc-codeaction-selected)
nnoremap <leader>a  <Plug>(coc-codeaction-selected)
nnoremap <leader>ac <Plug>(coc-codeaction)
nnoremap <leader>qf <Plug>(coc-fix-current)
nmap <leader>FZ :FZF<CR>
nmap <leader>ff :FZF<Space>
