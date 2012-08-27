" vimrc by Leon Szpilewski
" it's a mess :]
" http://xr0.eu 


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
	finish
endif


set t_Co=256
if has("gui_running")
	"looks like mvim on os x supports now dark backgrounds! finally!
	"set background=light
	"colorscheme darkblue2
	set background=dark
	colorscheme tir_black
else
	set background=dark
	colorscheme tir_black
endif
" colorscheme oceanblack
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set tabstop=2
set shiftwidth=2
syntax on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
" map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

	augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

if $VIM_CRONTAB == "true"
	set nobackup
	set nowritebackup
endif

" omnicppcomplete options
"map <C-x><C-x><C-T> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/commontags /usr/include /usr/local/include<CR><CR>
"set tags+=~/.vim/commontags

" --- OmniCppComplete ---
" -- required --
"set nocp " non vi compatible mode
"filetype plugin on " enable plugins

" -- optional --
" auto close options when exiting insert mode or moving away
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"set completeopt=menu,menuone

" -- configs --
"let OmniCpp_MayCompleteDot = 1 " autocomplete with .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
"let OmniCpp_MayCompleteScope = 0 " autocomplete with ::
"let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
"let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
"let OmniCpp_LocalSearchDecl = 1 " don't require special style of function opening braces
"let OmniCpp_ShowAccess = 0
" -- ctags --
" map <ctrl>+F12 to generate ctags for current folder:
"map <C-x><C-t> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" add current directory's generated tags file to available tags
"set tags+=./tags

" Setup the tab key to do autocompletion
"function! CompleteTab()
"	let prec = strpart( getline('.'), 0, col('.')-1 )
"	if prec =~ '^\s*$' || prec =~ '\s$'
"		return "\<tab>"
"	else
"		return "\<c-x>\<c-o>"
"	endif
"endfunction

"inoremap <tab> <c-r>=CompleteTab()<cr>

"function! SuperCleverTab()
"	if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
"		return "\<Tab>"
"	else
"		if &omnifunc != ''
"			return "\<C-X>\<C-O>"
"		elseif &dictionary != ''
"			return "\<C-K>"
"		else
"			return "\<C-N>"
"		endif
"	endif
"endfunction

"inoremap <Tab> <C-R>=SuperCleverTab()<cr>

set backspace=indent,eol,start
set encoding=utf-8
set autoindent
set smartindent
set noerrorbells
set incsearch
set title

set undolevels=500

set suffixes+=.o,.so,.a,.pyc
set suffixes-=.h

set history=1000
set nowb
set nobackup
set noswapfile

set autoread

set laststatus=2
set number
set numberwidth=3
set cmdheight=2
set ruler
set hlsearch
set showmode
set showcmd
set showmatch
set wildchar=<TAB>
set nowrap

" omni menu colors
hi Pmenu guibg=#7f7f7f guifg=#ffffff
hi PmenuSel guibg=#d9fefe guifg=#002e41

if has("gui_running")
	"FIXME: fix for both term and gui
	if has('title')
		set titlestring=editing:\ %-25.55F\ %a%r%m titlelen=70 "
	endif
	set guifont=Monaco:h13
	
if v:progname =~? "gvim"
	set guifont=Monospace
endif
	"set guifont=Terminus:h14
	"set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
	"no toolbar
	"set guioptions-=T
	" don't use ALT keys for menus.
	set winaltkeys=no
	"set guicursor=a:blinkon0

endif " has("gui")

"FIXME use same as for 79
if has("gui_running")
	hi Error80 gui=NONE guifg=#ffffff guibg=#6e2e2e
	hi ErrorLeadSpace gui=NONE guifg=#ffffff guibg=#6e2e2e
	hi ErrorTailSpace gui=NONE guifg=#ffffff guibg=#6e2e2e
else
	hi Error80 cterm=NONE ctermfg=white ctermbg=red
	hi ErrorLeadSpace cterm=NONE ctermfg=white ctermbg=red
	hi ErrorTailSpace cterm=NONE ctermfg=white ctermbg=red
endif

if $LANG =~ ".*\.UTF-8$" || $LANG =~ ".*utf8$" || $LANG =~ ".*utf-8$"
	set listchars+=tab:»·,trail:·,precedes:…,extends:…
else
	set listchars=tab:>-,trail:-
endif

if has('statusline')
	" status line detail:
	" %f file path
	" %y file type between braces
	" %([%R%M]%) fileflags between braces
	" %{'!'[&ff=='default_file_format']}
	" shows a '!' if the fileformat
	" is not the platform default
	" %{'$'[!&list]} shows a '*' if in list mode
	" %{'~'[&pm=='']} shows a '~' if in patchmode
	" (%{synIDattr(synID(line('.'),col('.'),0),'name')})
	" only for debug : display the
	" current syntax item name
	" %= right-align following items
	" #%n buffer number
	" %l/%L,%c%V line number, total number of
	" lines, and column number
	function! SetStatusLineStyle()
		if &stl == '' || &stl =~ 'synID'
			let &stl="%f %([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}%{'~'[&pm=='']}%=#%n %l/%L,%c%V "
		else
			let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n %l/%L,%c%V "
		endif
	endfunc
	" switch between the normal and vim-debug modes in
	" the status line
	nmap _ds :call SetStatusLineStyle()<CR>
	call SetStatusLineStyle()
endif

set visualbell t_vb=

" uncomment if you want to mark the current cursorline,
" column with a different color
"autocmd WinEnter * setlocal cursorcolumn
"autocmd BufEnter * setlocal cursorcolumn
autocmd WinEnter * setlocal cursorline
autocmd BufEnter * setlocal cursorline
" "hi cursorcolumn ctermbg=247 ctermfg=?? guibg=grey70 guifg=??
" hi cursorline ctermbg=247 guibg=grey70

"FIXME: add colors for some C99 stuff
let c_C99=1
let c_c_vim_compatible=1
let c_comment_strings=1
let c_comment_numbers=1
let c_comment_types=1
let c_warn_nested_comments=1
let c_cpp_comments=1
let c_ansi_typedefs=1
let c_ansi_constants=1
let c_posix=1
let c_comment_date_time=1
let c_minlines=25
let c_C89=1
let c_gnu=1
let c_syntax_for_h=1

" unmap arrows/pgdn/pgup so you learn to use hjkl
""jmap <Left> \
""map <Right> \
""map <Up> \
""map <Down> \
""map <PageUp> \
""map <PageDown> \

""imap <Left> <nop>
""imap <Right> <nop>
""imap <Up> <nop>
""imap <Down> <nop>
""imap <PageUp> <nop>
""imap <PageDown> <nop>

nnoremap <silent> <F1> :A<CR>
inoremap <silent> <F1> <ESC><CR>

nnoremap <silent> <F2> :Tlist<CR>
inoremap <silent> <F2> <ESC>:Tlist<CR>

nnoremap <silent> <F3> :NERDTreeToggle<CR>
inoremap <silent> <F3> :NERDTreeToggle<CR>

" simple tab switchting
nnoremap <silent> T gT
nnoremap <silent> t gt  
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-w> :tabclose<CR>

" settings for taglist
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Compact_Format = 1
let Tlist_Display_Prototype = 0
let Tlist_Show_Menu = 1
let Tlist_Display_Tag_Scope = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Process_File_Always = 1
let Tlist_Max_Tag_Length = 20
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "order"
let Tlist_Use_SingleClick = 1
let tlist_c_settings = 'c;f:FUNCTIONS'

function GoFormat()
		let regel=line(".")
		%!/usr/local/bin/gofmt
		call cursor(regel, 1)
endfunction

function CFormat()
	let regel=line(".")
	%!/opt/local/bin/astyle
	call cursor(regel, 1)
endfunction

autocmd Filetype go command! Fmt call GoFormat()
autocmd Filetype c command! Fmt call CFormat()
map <C-H> :Fmt<CR>

" -----------------------------------------------------------------------------------------
" neocomplcache
" source: http://www.vim.org/scripts/script.php?script_id=2620
" -----------------------------------------------------------------------------------------
  
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() 
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
inoremap <expr><Space> neocomplcache#smart_close_popup()."\<Space>"
"inoremap <expr><(> neocomplcache#smart_close_popup()."("

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1


" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" -----------------------------------------------------------------------------------------
"
" indenting
" source: http://vim.wikia.com/wiki/Making_Parenthesis_And_Brackets_Handling_Easier 
"
" -----------------------------------------------------------------------------------------

"inoremap ( ()<Esc>:call BC_AddChar(")")<CR>i
"inoremap { {<CR>}<Esc>:call BC_AddChar("}")<CR><Esc>kA<CR>
"inoremap [ []<Esc>:call BC_AddChar("]")<CR>i
"inoremap " ""<Esc>:call BC_AddChar("\"")<CR>i
"" jump out of parenthesis
"inoremap <C-j> <Esc>:call search(BC_GetChar(), "W")<CR>a
"
"function! BC_AddChar(schar)
" if exists("b:robstack")
" let b:robstack = b:robstack . a:schar
" else
" let b:robstack = a:schar
" endif
"endfunction
"
"function! BC_GetChar()
" let l:char = b:robstack[strlen(b:robstack)-1]
" let b:robstack = strpart(b:robstack, 0, strlen(b:robstack)-1)
" return l:char
"endfunction
"
let g:slime_target = "tmux"

let g:vimclojure#HighlightBuiltins=1   " Highlight Clojure's builtins
let g:vimclojure#ParenRainbow=1        " Rainbow parentheses'!
let g:vimclojure#DynamicHighlighting=1 " Dynamically highlight functions
