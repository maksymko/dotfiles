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
Plugin 'wting/rust.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/taglist.vim'
Plugin 'scrooloose/nerdtree'
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

au BufRead,BufNewFile */libopencm3/*.h,*/libopencm3/*.c set noexpandtab
au BufRead,BufNewFile */unicore-mx/*.h,*/unicore-mx/*.c set noexpandtab

colorscheme evening

map <F2> <Esc>:w<CR>
map! <F2> <Esc>:w<CR>

map <F10> <Esc>:qa<CR>
map! <F10> <Esc>:qa<CR>

map <F9>  <Esc>:wqa<CR>
map! <F9>  <Esc>:wqa<CR>

inoremap <s-up> <Esc><c-w>W<Ins>
inoremap <s-down> <Esc><c-w>w<Ins>

nnoremap <s-up> <c-w>W
nnoremap <s-down> <c-w>w

" Fancy middle-line <CR>
inoremap <C-CR> <Esc>o
nnoremap <C-CR> o

" This is the way I like my quotation marks and various braces
inoremap '' ''<Left>
inoremap "" ""<Left>
inoremap () ()<Left>
inoremap <> <><Left>
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap () ()<Left>

" Better Marks
nnoremap ' `

" Perl settings
let g:Perl_AuthorName      = 'Maxim Sloyko'
let g:Perl_AuthorRef       = 'MS'
let g:Perl_Email           = 'msloyko@sw.ru'
let g:Perl_Company         = 'SWsoft Holdings Inc.'

let perl_nofold_packages = 1
au FileType perl set comments=:##
au FileType perl set commentstring=##%s

au FileType perl,python set foldlevel=0
au FileType perl set foldcolumn=4
au FileType perl set fen
au FileType perl        set fdm=syntax
au FileType perl,python set fdn=4
au FileType perl,python set fml=10
au FileType perl,python set fdo=block,hor,mark,percent,quickfix,search,tag,undo,search
au FileType python set expandtab

au FileType perl,python abbr sefl self
au FileType perl abbr sjoft shift
au FileType perl abbr DUmper Dumper

if exists('g:loaded_nerd_tree')
    nnoremap <F7> :NERDTreeToggle<CR>
    let NERDTreeIgnore=['^\.']
    let NERDTreeShowHidden=0
endif

function! ToggleNumberRow()
       if !exists("g:NumberRow") || 0 == g:NumberRow
               let g:NumberRow = 1
               call ReverseNumberRow()
       else
               let g:NumberRow = 0
               call NormalizeNumberRow()
       endif
endfunction


" Reverse the number row characters
function! ReverseNumberRow()
       " map each number to its shift-key character
       inoremap 1 !
       inoremap 2 @
       inoremap 3 #
       inoremap 4 $
       inoremap 5 %
       inoremap 6 ^
       inoremap 7 &
       inoremap 8 *
       inoremap 9 (
       inoremap 0 )
       inoremap - _
    inoremap 90 ()<Left>
       " and then the opposite
       inoremap ! 1
       inoremap @ 2
       inoremap # 3
       inoremap $ 4
       inoremap % 5
       inoremap ^ 6
       inoremap & 7
       inoremap * 8
       inoremap ( 9
       inoremap ) 0
       inoremap _ -
endfunction

" DO the opposite to ReverseNumberRow -- give everything back
function! NormalizeNumberRow()
       iunmap 1
       iunmap 2
       iunmap 3
       iunmap 4
       iunmap 5
       iunmap 6
       iunmap 7
       iunmap 8
       iunmap 9
       iunmap 0
       iunmap -
       "------
       iunmap !
       iunmap @
       iunmap #
       iunmap $
       iunmap %
       iunmap ^
       iunmap &
       iunmap *
       iunmap (
       iunmap )
       iunmap _
       inoremap () ()<Left>
endfunction

"call ToggleNumberRow()
nnoremap <M-n> :call ToggleNumberRow()<CR>

function! UseWord(word)
       let spec_cases = {'Dumper': 'Data::Dumper'}
       let my_word = a:word
       if has_key(spec_cases, my_word)
               let my_word = spec_cases[my_word]
       endif

       let was_used = search("^use.*" . my_word, "bw")

       if was_used > 0
               echo "Used already"
               return 0
       endif

       let last_use = search("^use", "bW")
       if 0 == last_use
               last_use = search("^package", "bW")
               if 0 == last_use
                       last_use = 1
               endif
       endif

       let use_string = "use " . my_word . ";"
       let res = append(last_use, use_string)
       return 1
endfunction

function! UseCWord()
       let cline = line(".")
       let ccol = col(".")
       let ch = UseWord(expand("<cword>"))
       normal mu
       call cursor(cline + ch, ccol)

endfunction

function! WrapText() range
       let all_text = []
       for c_ln in getline(a:firstline, a:lastline)
               call extend(all_text, split(c_ln))
       endfor
       let text_width = &tw != 0 ? &tw : 80
       let new_lines = []
       let c_str = ""
       while len(all_text) > 0
               let c_word = remove(all_text, 0)
               if len(c_str) + len(c_word) + 1 < text_width
                       let c_str .= " " . c_word
               else
                       call add(new_lines, c_str)
                       let c_str = c_word
               endif
       endwhile
endfunction

function! GetWords(pattern)
       let cline = line(".")
       let ccol = col(".")
       call cursor(1,1)

       let temp_dict = {}
       let cpos = searchpos(a:pattern)
       while cpos[0] != 0
               let temp_dict[expand("<cword>")] = 1
               let cpos = searchpos(a:pattern, 'W')
       endwhile

       call cursor(cline, ccol)
       return keys(temp_dict)
endfunction

function! AppendWordsLike(pattern)
       let word_list = sort(GetWords(a:pattern))
       call append(line("."), word_list)
endfunction


function! MarkDebug()
       let cline = line(".")
       let ctext = getline(cline)
       call setline(cline, ctext . "##_DEBUG_")
endfunction

function! RemoveDebug()
       %g/#_DEBUG_/d
endfunction

au FileType perl,python inoremap <M-d> <Esc>:call MarkDebug()<CR><Ins>
au FileType perl,python inoremap <F6> <Esc>:call RemoveDebug()<CR><Ins>
au FileType perl,python nnoremap <F6> :call RemoveDebug()<CR>

" end Perl settings

nnoremap <silent> <F8> :TlistToggle<CR>
inoremap <silent> <F8> <Esc>:TlistToggle<CR><Esc>

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
autocmd FileType mail   set noai
autocmd FileType mail   set ts=3
autocmd FileType mail   set tw=78
autocmd FileType mail   set shiftwidth=3
autocmd FileType mail   set expandtab
autocmd FileType xslt   set ts=4
autocmd FileType xslt   set shiftwidth=4
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
au BufNewFile  *.pde  call LoadTemplate("~/.vim/skel/pde.tmpl")

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

function! s:set_tags(tags_file_name)
    let tag_file = s:find_tags(expand('%:p'), a:tags_file_name)
    if tag_file != v:none
        let &tags = tag_file
    endif
endfunction

au BufEnter,BufNew */uble/*.c,*/uble/*.h,*/uble/*.cc,*/uble/*.hpp call ConfigureUbleMode()
au BufEnter,BufNew */develop/*.c,*/develop/*.h,*/develop/*.cc,*/develop/*.hpp,*/develop/*.cpp call s:set_tags('ctags')

set number
set relativenumber
