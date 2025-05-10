if filereadable($HOME . "/.vimrc_private")
    so ~/.vimrc_private
endif

syntax on
set cindent
set ts=4
set sw=4
set expandtab
set backspace=indent,start
set laststatus=2
set nohlsearch
set noswapfile
set modeline
set smarttab
set cursorline
set ai
map Q gq

set vb t_vb=

set nowrap
set ss=5
set is
set scs
set ru

hi Cursor guibg=yellow

set nocompatible              " be iMproved, required
filetype off                  " required

" Disable terminus plugin in GUI environment.
if has("gui_running")
    let g:TerminusLoaded=1
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'rust-lang/rust.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'preservim/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'mxw/vim-hg'
"Plugin 'kergoth/vim-bitbake'
Plugin 'sophacles/vim-bundle-mako'
Plugin 'wincent/terminus'
Plugin 'itchyny/lightline.vim'
Plugin 'arrufat/vala.vim'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

augroup filetypedetect
" Octave syntax
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
  au! BufRead,BufNewFile SConstruct,SConscript set filetype=python
augroup END

augroup spelling
    au FileType gitcommit,markdown,txt set spell
augroup END

au BufRead,BufNewFile */libopencm3/*.h,*/libopencm3/*.c set noexpandtab
au BufRead,BufNewFile */unicore-mx/*.h,*/unicore-mx/*.c set noexpandtab

colorscheme ron

" Better Marks
nnoremap ' `

au FileType perl,python set foldlevel=0
au FileType perl,python set fdn=4
au FileType perl,python set fml=10
au FileType perl,python set fdo=block,hor,mark,percent,quickfix,search,tag,undo,search
au FileType python set expandtab

if exists('g:loaded_nerd_tree')
    nnoremap <F7> :NERDTreeToggle<CR>
    let NERDTreeIgnore=['^\.']
    let NERDTreeShowHidden=0
endif

" end Perl settings

nnoremap <silent> <F8> :TagbarToggle<CR>
inoremap <silent> <F8> <Esc>:TagbarToggle<CR><Esc>

let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"
nnoremap g] g<C-]>


function! AlwaysCD()
       if bufname("") !~ "^scp://" && bufname("") !~ "^sftp://" && bufname("") !~ "^ftp://"
               lcd %:p:h
       endif
endfunction
autocmd BufEnter * call AlwaysCD()

function! DeleteRedundantSpaces()
       let cline = line(".")
       let ccol = col(".")
       silent! %s/\s\+$//g
       call cursor(cline, ccol)
endfunction
au BufWrite * call DeleteRedundantSpaces()

set noswapfile
set nobackup
set nowritebackup

autocmd FileType python set formatoptions=wcrq2l
autocmd FileType python set inc="^\s*from"

autocmd FileType c      set si
autocmd FileType txt    set ts=3
autocmd FileType txt    set tw=78
autocmd FileType txt    set expandtab

let g:TemplateLoaded = 0
function! LoadTemplate(fname)
    if g:TemplateLoaded == 0
        let g:TemplateLoaded = 1
        normal 0
        exe "read " . a:fname
    endif
endfunction
" Template for arduino sketch

function! NumberToggle()
  if(&relativenumber == 1 && &number == 1)
    set nonumber
    set norelativenumber
  elseif (&number == 1)
    set relativenumber
  else
      set number
  endif
endfunc

function! NumberLineMode(mode)
    if (&relativenumber == 1 || &number == 1)
        if (a:mode == 1)
            set number
            set norelativenumber
        else
            set number
            set relativenumber
        endif
    endif
endfunction

nnoremap <C-n> :call NumberToggle()<cr>

au FocusLost * call NumberLineMode(1)
au FocusGained * call NumberLineMode(2)

au InsertEnter * call NumberLineMode(1)
au InsertLeave * call NumberLineMode(2)

set number
set relativenumber

function! s:find_tags(filepath, tags_file_name)
    let c_dir = fnamemodify(a:filepath, ':h')
    let c_dirname = fnamemodify(c_dir, ':t')
    while c_dir != '/' && c_dirname != 'develop' && c_dirname != ''
        let tag_path = c_dir . '/' . a:tags_file_name
        if filereadable(tag_path)
            " If there is a file c_dir . tags, use it
            return tag_path
            break
        else
            " Otherwise go one directory up
            let c_dir = fnamemodify(c_dir, ':h')
            let c_dirname = fnamemodify(c_dir, ':t')
        endif
    endwhile

    return v:none
endfunction

function! ConfigureUbleMode()
    let &tags = substitute(expand('%:p:h'), 'uble/.*', 'uble/ctags', '')
    let astyle_opts = substitute(expand('%:p:h'), 'uble/.*', 'uble/astyle.opts', '')
    let &formatprg = "astyle --options=" . astyle_opts
endfunction

function! SetTagsByBaseName(tags_file_name)
    let tag_file = s:find_tags(expand('%:p'), a:tags_file_name)
    if tag_file != v:none
        let &tags = tag_file
    endif
endfunction

function! SignOff()
    if exists('g:user_name') && exists('g:user_email')
        let lnum = line('.')
        call setline(lnum, 'Signed-Off-By: ' . g:user_name . ' <' . g:user_email . '>')
    endif
endfunction

au FileType gitcommit nnoremap <C-s> call SignOff()

au BufEnter,BufNew */uble/*.c,*/uble/*.h,*/uble/*.cc,*/uble/*.hpp call ConfigureUbleMode()
au BufEnter,BufNew */develop/*.c,*/develop/*.h,*/develop/*.cc,*/develop/*.hpp,*/develop/*.cpp call SetTagsByBaseName('ctags')
