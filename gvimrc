so ~/.vimrc

highlight Cursor guibg=Yellow guifg=Black
let font2="DejaVu Sans Mono 12"
let font3="Noto Mono 12"
let font4="Ubuntu Mono 14"
let font5="FreeMono 12"
let font6="Inconsolata Medium 14"
let font7="Fira Code Medium 14"
let &guifont=font7

set titlestring=%{v:servername}\ %f
set guiligatures=!\"#$%&()*+-./:<=>?@[]^_{\|~

colorscheme evening

" Keep this at the bottom
if filereadable($HOME . "/.gvimrc_override")
    so ~/.gvimrc_override
endif

"l0Oo1I
