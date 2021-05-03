set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" set bs=indent,eol,start  " allow backspacing over everything in insert mode
set bs=eol,start  " allow backspacing over everything in insert mode
"set ai   " always set autoindenting on
"set backup  " keep a backup file
set viminfo='20,\"50 " read/write a .viminfo file, don't store more
  " than 50 lines of registers

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
       cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
       cs add $CSCOPE_DB
    endif
    set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" colo soso 
colo desert
set nocompatible " Use Vim defaults (much better!)
set history=60        " keep 60 lines of command line history
set autoread
set mouse-=a
set nobackup
"set ignorecase  " or ic, noignorecase or noic
syntax on
set number
set hlsearch
set incsearch
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set showcmd
set ruler             " show the cursor position all the time
set sm
filetype plugin indent on

"""""""""""""""""""""""""""""
" ; to be command prefix 
"""""""""""""""""""""""""""""
let mapleader = ";" 

"""""""""""""""""""""""""""""
"  map " " to ":"
"""""""""""""""""""""""""""""
nmap <space> :

"""""""""""""""""""""""""""""
" open vimrc 
"""""""""""""""""""""""""""""
map <silent> <leader>ee :e $HOME/.vimrc<cr>
autocmd! bufwritepost *.vimrc source $HOME/.vimrc

"""""""""""""""""""""""""""""
" save file 
"""""""""""""""""""""""""""""
nmap <leader>ww :w!<cr>

"""""""""""""""""""""""""""""
" enter shell quickly 
"""""""""""""""""""""""""""""
nmap <C-Z> :shell<cr>

"""""""""""""""""""""""""""""
" use system Clipboard 
"""""""""""""""""""""""""""""
map <C-C> "*y
"map <C-V> "*p

"""""""""""""""""""""""""""""
" void ctrl + W exist shell 
"""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""
" Tag list (ctags)
"""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 0


"""""""""""""""""""""""""""""
" netrw setting
"""""""""""""""""""""""""""""
let g:netrw_winsize = 30
nmap <silent><leader>fe :Sexplorer!<cr>

"""""""""""""""""""""""""""""
" BufExplorer
"""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSortBy='mru'
let g:bufExplorerSplitRight=0
let g:bufExplorerSplitVertical=1
let g:bufExplorersplitVertSize=30
let g:bufExplorerUseCurrentWindow=1
autocmd BufWinEnter \[Buf\ List\] setl nonumber

"""""""""""""""""""""""""""""
" winManager setting
"""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent><leader>wm :WMToggle<cr>


"""""""""""""""""""""""""""""
" lookupfile setting 
"""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_PreservePatternHistory = 1
let g:LookupFile_AlwaysAcceptFirst = 1
let g:LookupFile_AllowNewFiles = 0
if filereadable("./filenametags")
    let g:LookupFile_TagExpr = "./filenametags"
endif
nmap <silent><leader>lk :LUTags<cr>
nmap <silent><leader>ll :LUBufs<cr>
nmap <silent><leader>lw :LUWalk<cr>

"""""""""""""""""""""""""""""
" mark setting 
"""""""""""""""""""""""""""""
nmap <silent><leader>hh <Plug>MarkSet
vmap <silent><leader>hh <Plug>MarkSet
nmap <silent><leader>hc <Plug>MarkClear
vmap <silent><leader>hc <Plug>MarkClear
nmap <silent><leader>hr <Plug>MarkRegex
vmap <silent><leader>hr <Plug>MarkRegex


"""""""""""""""""""""""""""""
" cscope setting 
"""""""""""""""""""""""""""""
" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    set cst
    set nocsverb

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
endif

    " show msg when any other cscope db added
set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR> 

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or
    " network connection, set it higher.  If you don't set ttimeoutlen, the
    " value for timeoutlent (default: 1000) is used.
    "
    "set ttimeoutlen=100

endif

"if has("cscope")
"    set csprg=/usr/bin/cscope
"    set csto=1
"    set cst
"    set nocsverb
"    " add any database in current directory
"    if filereadable("cscope.out")
"        cs add cscope.out
"    endif
"
"    set csverb
"endif

"nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>


"""""""""""""""""""""""""""""
" quickfix setting 
"""""""""""""""""""""""""""""
map  <buffer> <leader><space> :w<cr>:make<cr>
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cw :cw 10<cr>
nmap <leader>lv :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>


"""""""""""""""""""""""""""""
" neocomplcache setting 
"""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_camel_case_completion=1


"""""""""""""""""""""""""""""
" DoxygenToolkit setting 
"""""""""""""""""""""""""""""
let g:doxygenToolkit_authorName="gzhang"
let g:doxygenToolkit_briefTag_funcName="yes"
"map <leader>a:DoxAuthor
"map <leader>f:Dox
"map <leader>b:DoxBlock
"map <leader>c O/** */<Left><Left>


"""""""""""""""""""""""""""""
" vim grep setting 
"""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS sccs .svn generated'
set grepprg=/bin/grep\ -nsHR
set noeb vb t_vb=

