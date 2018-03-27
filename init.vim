set nocompatible              
filetype off

call plug#begin("~/.config/nvim/bundle")
" general
Plug 'ervandew/supertab'
Plug 'w0rp/ale' 
Plug 'Townk/vim-autoclose'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" airline stuff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

"snippets engine and snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" autocomplete
Plug 'Valloric/YouCompleteMe'

" tagbar
Plug 'majutsushi/tagbar'

" tmux
Plug 'christoomey/vim-tmux-navigator'

" colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'fatih/molokai'
Plug 'bluz71/vim-moonfly-colors'

" live markdown preview & syntax
Plug 'shime/vim-livedown', {'for':  'markdown'}
Plug 'plasticboy/vim-markdown', {'for':  'markdown'}

"c++
Plug 'rhysd/vim-clang-format', {'for': 'cpp'}
Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}
Plug 'vhdirk/vim-cmake', {'for': 'cpp'}
Plug 'uplus/vim-clang-rename', {'for': 'cpp'}


" python
Plug 'klen/python-mode', {'for': 'python'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}

"javascript
"Plug 'mxw/vim-jsx'
"Plug 'elzr/vim-json'
"Plug 'walm/jshint.vim'
"Plug 'marijnh/tern_for_vim'
"Plug 'pangloss/vim-javascript'
"Plug 'jelera/vim-javascript-syntax'


" go 
Plug 'fatih/vim-go', {'for':'go'}
Plug 'AndrewRadev/splitjoin.vim'

"toml syntax hightligh
Plug 'cespare/vim-toml' 

call plug#end()

" general
"
:cd /home/carlo/Dropbox/go" default startup directory change


colo moonfly
set background=dark
syntax on
filetype plugin indent on
set number
set cursorline
set colorcolumn=100 
set encoding=UTF-8

" Persistence undo
set undodir=~/.vim/undodir 
set undofile

" Appereance
"let g:Guifont=DroidSansMono\ Nerd\ Font\ 12
"set g:Guifont=Go\ Mono\ Regular\ Powerline\ 12
let g:Guifont="Fira Code:h12"
set laststatus=2
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8
set timeoutlen=100 ttimeoutlen=1

" leader key remap
let mapleader = ","
"airline colorscheme
let g:airline_theme='cool'
let g:airline_powerline_fonts = 1

" golang stuff
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" golang function text objects
let g:go_textobj_include_function_doc = 1

" golang camelcase fmt
let g:go_addtags_transform = "camelcase"	
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
" linting on save
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

"cd to the current directory for newtab i.e. terminal
" doesn't work on normal vim
"function! OnTabEnter(path)
"  if isdirectory(a:path)
"    let dirname = a:path
"  else
"    let dirname = fnamemodify(a:path, ":h")
"  endif
"  execute "tcd ". dirname
"endfunction()

"autocmd TabNewEntered * call OnTabEnter(expand("<amatch>"))

"cppbase download and change name
function! NewCppProjectGit(dirname)
  execute "!git clone https://github.com/ub1985/cppbase"
  execute "!mv  cppbase " . a:dirname
  execute "!sed -i s/cppbase/" . a:dirname . "/ " . a:dirname . "/CMakeLists.txt" 
endfunction()

command! -nargs=1 NewCppProject call NewCppProjectGit(<f-args>)


" Tabs spaces 
autocmd FileType css setlocal tabstop=2
autocmd FileType html,markdown setlocal  tabstop=2
autocmd FileType javascript setlocal  tabstop=2
autocmd FileType python setlocal tabstop=2 
autocmd FileType go setlocal tabstop=4
autocmd FileType cpp setlocal tabstop=2

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType go setlocal omnifunc=go#complete#Complete
autocmd FileType cpp setlocal omnifunc=cppcomplete#CompleteTags

" ctags generation
noremap <c-c> :!ctags -R --exclude='.git' . <CR>
set tags=./tags,tags; " where to look for the tags file

"ale linter
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '<<'
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {'cpp': ['clang','clangtidy']}
let g:ale_cpp_clang_options = '-std=c++1z -Wall -pedantic'
let g:ale_cpp_gcc_options = '-std=c++1z -Wall -pedantic'
let g:ale_cpp_clangtidy_options = '-std=c++1z'
let g:ale_cpp_clangtidy_checks = ['modernize-*,readability-*,cppcoreguidelines-*,misc-*']
"ale error navigation
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"tagbar keybinding
nmap <c-s> :TagbarToggle<CR>

"nerdtree keybinding
map <F5> :NERDTreeToggle<CR>
let g:NERDTreeHijackNetrw = 0

"ultisnip trigger
let g:UltiSnipsExpandTrigger="<c-u>"

"C++ run and build, rename, fix-include remaps
au filetype cpp nmap <buffer><silent> <s-r> <Plug>(clang_rename-current)
autocmd filetype cpp nnoremap <silent> <c-i> :!clang-include-fixer -db=yaml % <CR>
autocmd filetype cpp nnoremap <silent> <c-c> :!clang++ -std=c++1z % -o %:r <CR>
autocmd filetype cpp nnoremap <c-x> :!clang++ -std=c++1z % -o %:r && ./%:r <CR>

"YouCompleteMe configuration
let g:ycm_global_ycm_extra_conf= '~/.config/nvim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" C++ autoformat
let g:clang_format#code_style = "google"
let g:clang_format#command = "/usr/bin/clang-format"
let g:clang_format#auto_format = 1

if has ('gui_running')
	highlight Pmenu guibg=#cccccc gui=bold
endif

