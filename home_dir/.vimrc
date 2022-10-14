" key mapping

let mapleader = "\<Space>"
let maplocalleader = "\\"

filetype plugin indent on
syntax enable
set conceallevel=0

" colormap
colorscheme pablo

" file exprole
noremap <leader>d   :E %:h<CR>
noremap <leader>n   :Ve %:h<CR>
noremap <leader>fr  :browse ol<CR>
noremap <leader>fc  q?
nnoremap st         :tab sp<CR>:Explore %:h<CR>

function! s:Netrw_mymap()
  nmap <buffer> h -
  nmap <buffer> l <CR>
endfunction

" move to the end of a text after copying/pasting it
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Space+something to move to an end
noremap <Space>h ^
noremap <Space>l $
noremap <Space>k gg
noremap <Space>j G

" unmap s,space
nnoremap s <Nop>
nnoremap <Space> <Nop>
" window control
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>
" st is used by defx
nnoremap sc :tab sp<CR>
nnoremap sC :-tab sp<CR>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sZ :top terminal ++rows=35<CR>
nnoremap sz :bo terminal ++rows=10<CR>
nnoremap sx :tab terminal<CR>
nnoremap sn gt
nnoremap sp gT
nnoremap s= <C-w>=
nnoremap sO <C-w>=
nnoremap so <C-w>_<C-w>\|
nnoremap sq :<C-u>tabc<CR>

" move by display line
noremap j  gj
noremap k  gk
noremap gj j
noremap gk k

" add space
inoremap , ,<Space>

" do not copy when deleting by x
nnoremap x "_x

" quit by q
tnoremap <silent> <Space>q  <C-\><C-n>:q<CR>
nnoremap <silent> <Space>q  :q<CR>
nnoremap <silent> <Space>wq :qa<CR>
nnoremap <silent> <Space>Q  :qa<CR>

" center cursor when jumped
nnoremap m jzz
nnoremap M kzz

" increase and decrease by plus/minus
nnoremap +  <C-a>
nnoremap -  <C-x>
vmap     g+ g<C-a>
vmap     g- g<C-x>


" save with <C-g> in insert mode
inoremap <C-g> <ESC>:update<CR>a

"save by <Space>s
nnoremap <silent> <Space>s :w<CR>

"reload init.vim
nnoremap <silent> <leader>r :<C-u>so ~/.vimrc<CR>

" one push to add/remove tabs
nnoremap > >>
nnoremap < <<
" select again after tab action
vnoremap > >gv
vnoremap < <gv

inoremap <silent>jj <ESC>
nnoremap O ko<ESC>

" settings

syntax on

" if you can't type quickly, change this.
set timeoutlen=400

" update quickly
set updatetime=100

" show cursor line
set cursorline

" do not include buffer info in session
set sessionoptions-=buffers

" file encoding
set encoding=utf-8 fileencodings=utf-8,ios-2022-jp,euc-jp,sjis,cp932

set nf=alpha,octal,hex,bin

" search settings
set ignorecase
set smartcase
set incsearch
set nohlsearch
set nowrapscan

" line number settings
" set number
set relativenumber

" always show finetabline,statusline
set showtabline=2 laststatus=2

" tab settings
" set tabstop=4 shiftwidth=4
set tabstop=2 shiftwidth=2
set smarttab smartindent expandtab

setlocal formatoptions+=mM

" don't fold by default
set foldlevel=99
" reserve two columns for fold
set foldcolumn=2

" listchar settings
set list listchars=tab:»-,trail:~,extends:»,precedes:«,nbsp:%

" show double width characters properly
set ambiwidth=double

augroup fileType
  autocmd!
  autocmd filetype           python   setlocal tabstop=4 shiftwidth=4 foldmethod=syntax expandtab
  autocmd filetype           c,cpp    setlocal tabstop=2 shiftwidth=2 foldmethod=syntax expandtab
  autocmd filetype           go       setlocal tabstop=4 shiftwidth=4 expandtab | set formatoptions+=r
  autocmd filetype           tex      setlocal tabstop=2 shiftwidth=2 foldmethod=syntax expandtab wrap conceallevel=0
  autocmd filetype           html     setlocal tabstop=2 shiftwidth=2 expandtab nowrap
  autocmd filetype           css      setlocal tabstop=2 shiftwidth=2 expandtab nowrap
  autocmd filetype           vim      setlocal tabstop=2 shiftwidth=2 expandtab nowrap
  autocmd filetype           csv      setlocal tabstop=4 shiftwidth=4 nowrap noexpandtab
  autocmd filetype           text     setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd filetype           help     setlocal listchars=tab:\ \  noet
  autocmd filetype           markdown setlocal tabstop=4 shiftwidth=4 expandtab wrap
  autocmd BufNewFile,BufRead *.grg    setlocal nowrap
  autocmd BufNewFile,BufRead *.jl     setf julia
  autocmd BufNewFile,BufRead *.plt    setfiletype gnuplot
  autocmd BufNewFile,BufRead *.m      setfiletype matlab
  autocmd BufNewFile,BufRead *.csv    setfiletype csv
  autocmd BufNewFile,BufRead *.toml   setfiletype conf
  autocmd filetype           netrw    call s:Netrw_mymap()
augroup END

augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1

    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif

    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif

    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

augroup pcap
    au!
    au BufReadPre  *.pcap let &bin=1

    au BufReadPost *.pcap if &bin | %!xxd
    au BufReadPost *.pcap set ft=xxd | endif

    au BufWritePre *.pcap if &bin | %!xxd -r
    au BufWritePre *.pcap endif

    au BufWritePost *.pcap if &bin | %!xxd
    au BufWritePost *.pcap set nomod | endif
augroup END


set backspace=eol,indent,start

set wildmenu
set wildmode=list:full
set wildignore=*.o,*.obj,*.pyc,*.so,*.dll

let g:python_highlight_all = 1

set clipboard+=unnamedplus

" use termdebug
packadd termdebug

set mouse=a

set splitbelow
set splitright

" word border
set iskeyword+=-

" no sound
set belloff=all

let g:netrw_liststyle=1
" let g:netrw_banner=0
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1


" netrw mapping
function! NetrwMapping_sh(islocal) abort
  return "normal! \<C-w>h"
endfunction

function! NetrwMapping_sl(islocal) abort
  return "normal! \<C-w>l"
endfunction

function! NetrwMapping_sj(islocal) abort
  return "normal! \<C-w>j"
endfunction

function! NetrwMapping_sk(islocal) abort
  return "normal! \<C-w>k"
endfunction

function! NetrwMapping_sH(islocal) abort
  return "normal! \<C-w>H"
endfunction

function! NetrwMapping_sL(islocal) abort
  return "normal! \<C-w>L"
endfunction

function! NetrwMapping_sJ(islocal) abort
  return "normal! \<C-w>J"
endfunction

function! NetrwMapping_sK(islocal) abort
  return "normal! \<C-w>K"
endfunction

let g:Netrw_UserMaps = [
  \ ['sh', 'NetrwMapping_sh'],
  \ ['sl', 'NetrwMapping_sl'],
  \ ['sj', 'NetrwMapping_sj'],
  \ ['sk', 'NetrwMapping_sk'],
  \ ['sH', 'NetrwMapping_sH'],
  \ ['sL', 'NetrwMapping_sL'],
  \ ['sJ', 'NetrwMapping_sJ'],
  \ ['sK', 'NetrwMapping_sK'],
  \ ]
