
syntax on
filetype plugin indent on

set clipboard=unnamedplus   " using system clipboard (unnamedplus) needs vim with +clipboard 
                            " (vim  --version | grep clipboard)
                            " for ubuntu use vim-gtk package
							" unnamed for windows
set nocompatible            " make vim not compatible with vi (this way vim is more consistent)
set tabstop=4               " tab is 4 chars long
set shiftwidth=4            " how many chars are shifted by for example > and < 
set smartindent             " do smart autoindenting when starting a new line
set smarttab                " add/del shiftwidth/tabstop worth of chars
set noesckeys               " function keys that start with an esc are recognized in Insert mode
set number                  " add line number
set relativenumber          " add relative line numbers
set ignorecase              " ignore case when searching
set smartcase               " ignore 'ignorecase' when search pattern contains upper case chars
set incsearch               " incremental search
set hlsearch                " highlight search
set autochdir               " when switching file, change wd in vim as well
set ruler                   " denote line, col in bottom right of the buffer
set wildmenu                " show search menu in vim command mode
set mouse=a                 " enable mouse in every mode
set encoding=utf-8          " sets the encoding used
set fileencoding=utf-8      " sets the encoding for the file/buffer
set showcmd                 " Show (partial) command in the last line of the screen
set path+=**
set modifiable
set wildignore+=*.git,*.swp,tags

" netrw (file explorer)
" % makes new file while in Explorer
" d makes new directory while in Explorer
" D deletes file while in Explorer
" R to rename file/directory
" gh to show hidden files
" CTRL-e toggle left split explorer
nnoremap <C-e> :Lexplore<CR>
" SHIFT-e open explorer in new tab
nnoremap <S-e> :Texplore<CR>
let g:netrw_liststyle = 3    " use i to cycle through list-types
let g:netrw_banner = 0       " use I to enable/disable banner
let g:netrw_winsize = 25
let g:netrw_browse_split = 4 " open file from netrw to:
                             " 1 - new horizontal split
                             " 2 - new vertical split
                             " 3 - new tab
                             " 4 - previous window

" Put autocmds in a group, so that you can revert them with, eg:
" ":augroup vimStartup | au! | augroup END"
augroup vimStartup
  au!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END

" Convenient function to see the changes made in current buffer since last save.
if !exists(":W")
    command W vert new | set bt=nofile | r ++edit # | 0d_ | diffthis 
                \ | wincmd p | diffthis
                \ | wincmd h
endif

" General shortcuts

" za (un)folds under cursor
" zA (un)folds recursively under cursor
" zc fold area under cursor
" zC fold area under cursor recursively
" zm fold more (going up the leveles)
" zM folds all
" zR unfolds all

" make Q quit buffer
nnoremap <S-q> :q<CR>

"" redraw buffer
"nnoremap <C-F5> :redraw!<CR>

" reuse the previous yank with visual mode
xnoremap p pgvy

"" Align highlighted rows with common symbol
" function! Align(symbol)
	" execute "norm ^f" . a:symbol . "60i ^40lvwhx"
" endfunction
" command! -nargs=1 -range Align <line1>,<line2>call Align('<args>')

" auto-complete parenthesis and quotes
inoremap (<Tab> ()<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap [<Tab> []<Esc>i
inoremap '<Tab> ''<Esc>i
inoremap "<Tab> ""<Esc>i

"" make split
"nnoremap <C-b> :vert new<CR>
"nnoremap <S-b> :new<CR>

" resize splits
nnoremap <C-S-Up> <C-W>-
nnoremap <C-S-Down> <C-W>+
nnoremap <C-S-Left> <C-W>< 
nnoremap <C-S-Right> <C-W>>

" CTRL-w h/j/k/l navigates vim splits
" CTRL-W SHIFT-H/J/K/L rotates vim splits

" create/close/navigate tabs
" gt - next tab
" gT - prior tab
" nnn gt - numbered tab
nnoremap <C-PageUp> :tabnew<CR>
nnoremap <C-PageDown> :tabclose<CR>
nnoremap <C-Home> gT
nnoremap <C-End> gt

"" save/load session
" nnoremap <C-s> :w<CR>
" nnoremap <C-M-s> :mksession!<CR>
" nnoremap <C-y> :source Session.vim<CR>

" autocomplete
" omni-complete with ctags for language specific completion
set omnifunc=syntaxcomplete#Complete          " <C-x><C-o> for language specific completion
au Syntax r runtime! syntax/r.vim
au Syntax python runtime! syntax/python.vim
au Syntax cpp runtime! syntax/cpp.vim
au Syntax c runtime! syntax/c.vim
au Syntax go runtime! syntax/go.vim
set tags=./tags;,tags;                        " search tags in ./ dir and/or recurse upward
" auto generate ctags when opening a file with specified extension
autocmd BufRead,BufNewFile,BufWritePost *.{go,py,r,cpp,h,c,sql} silent execute "!ctags -R -a --exclude=.git"
" <package manager> install exhuberant-ctags
" autocmd BufRead,BufNewFile,BufWritePost *.{go,py,r,cpp,h,c,sql} silent execute "!ctags.exe -R -a --exclude=.git"
" choco install universal-ctags

" CTRL-o jumps back to last cursor position
" CTRL-i jumps forward to previous cursor position
" CTRL-^ to jump back to previous file
" N CTRL-^ to jump to N'th file/buffer (see :files or :buffers or :ls)
" :bn next buffer
" :bp prev buffer
" :bad[d] {filename} add file to buffer list without loading it
" :[N]bd[elete] [N] unload buffer
" e # opens the last closed buffer
" TODO:
" * :files,buffers, ls
" * tags
" * jumplist
" * changes

" ctags for function/variable specific completion
" <C-x>] for ctags based completion
" C-] or g] to jump to tag definition
" <C-W>] to horizontal split the definition
" <C-W>[ to vertical split the definition
nnoremap <C-w>[ :vert winc ]<CR>
" <C-w>} preview of tag window
" <C-w>z close preview window
" :tags to show contents of tag stack
" :tag <tag name> to jump to that tag (can use regex search in <tag name>)
" browse oldfiles
nnoremap <C-h> :browse oldfiles!<CR>

" jumping to files
" gf - go to path/to/file
" gF - go to path/to/file:col
" <C-w>f - go to path/to/file in new split window
" <C-w>v+gf - go to path/to/file in new vert split window
" <C-w>gf - go to path/to/file in new tab

" reopen last closed buffer
augroup bufclosetrack
  au!
  autocmd WinLeave * let g:lastWinName = @%
augroup END
function! LastWindow()
  exe "vert split " . g:lastWinName
endfunction
command -nargs=0 LastWindow call LastWindow()
nnoremap <C-w>t :call LastWindow()<CR>

" find patterns/TODOs
function! Grep(word,flag)
    if a:word == "" && a:flag == ""
        let l:word = expand('<cword>')
    elseif a:word != ""
        let l:word = substitute(a:word," ","\" \"","g")
        " let l:word = substitute(a:word,"|","\\\\\\\\|","g")
    elseif a:word == "" && a:flag == "-todo"
        let l:word = "TODO:\\|NOTE:\\|HACK:\\|DEBUG:\\|FIXME:\\|REVIEW:\\|BUG:\\|TEST:\\|TESTME:\\|MAYBE:"
    endif
	" execute "vert term grep -rni --binary-files=without-match --exclude-dir=.git --exclude-dir=.cache --exclude=tags --exclude=*.swp --color=always \"" . l:word . "\""
	execute "lvimgrep /\\c" . l:word . "/gj **/*"
	execute "lopen"
endfunction
nnoremap <C-f> :call Grep("","")<CR>
if !exists(":F")
    command -nargs=* F call Grep("<args>","")
endif
if !exists(":T")
    command -nargs=* T call Grep("<args>","-todo")
endif

" Open link from vim
" gx - from netrw_gx (opens url)
" bit of a hack 
function! SeeUrl()
    let l:url = expand('<cWORD>')
    execute "tabnew" 
    execute "!xdg-open " . l:url
    execute "q"
endfunction
nmap gu :call SeeUrl()<CR>
vmap gu <Esc>:call SeeUrl()<CR>

" Handle commenting myself.
" Could use some plugin, that is more full featured, but this will do.
" Thats because I don't want to add external plugins to workflow (currently).
" Although, I am using some of my own external programs (see Grep()).
" Currently supporting line comments only.
function! Commentary()
	let l:comment = "# "
    let l:ext = expand('%:e')
    let l:col = virtcol('.')
	let l:twosided = 0
    " go/C-style commenting
    if l:ext == "go" || l:ext == "c" || l:ext == "cpp"
        let l:comment = "// "
    " vim
    elseif l:ext == "vim" || expand('%') == ".vimrc" || expand('%') == "_vimrc"
        let l:comment = "\" "
    " sql
    elseif l:ext == "sql"
        let l:comment = "-- "
    " python
    elseif l:ext == "py"
        let l:comment = "# "
    " shell
    elseif l:ext == "sh" || l:ext == "zsh" || l:ext == "bash" || expand('%') == ".bashrc" || expand('%') == "_bashrc"
        let l:comment = "# "
    " html (and md)
    elseif l:ext == "html" || l:ext == "md"
        let l:comment = "<!-- "
		let l:comment_end = " -->"
		let l:twosided = 1
    " " css
    " elseif l:ext == "css"
        " let l:comment = "/* "
		" let l:comment_end = " */"
		" let l:twosided = 1
    endif
    let l:count = len(l:comment)
    let l:compare =  "^[	|\ ]*" . l:comment . ".*$"
    let l:cond = getline('.') =~ l:compare
    if cond
		execute "norm ^" . l:count . "x^" 
		if l:twosided == 1
			let l:count_end = len(l:comment_end)-1
			execute "norm $v" . l:count_end . "hx0^"

		endif
    else 
        execute "norm I" . l:comment . "0^"
		if l:twosided == 1
			let l:count_end = len(l:comment_end)
			execute "norm A" . l:comment_end . "0^"
		endif
    endif
endfunction
nnoremap <C-_> :call Commentary()<CR>
vnoremap <C-_> :call Commentary()<CR>
nnoremap <C-/> :call Commentary()<CR>
noremap <C-/> :call Commentary()<CR>


" git
" TODO: in vimdiff, see diffget etc for resolving conflicts
nnoremap <C-g><C-l> :vert<Space>terminal<Space>++cols=80<Space>git<Space>log<Space>--all<Space>--decorate<Space>--oneline<Space>--graph<Space>--no-abbrev-commit<CR>
nnoremap <C-g><C-s> :terminal<Space>++rows=15<Space>git<Space>status<CR>
nnoremap <C-g><C-a> :terminal<Space>++rows=20<Space>git<Space>add<Space>-i<CR>
nnoremap <C-g>c :terminal<Space>++rows=20<Space>git<Space>commit<CR>
nnoremap <C-g><C-p> :terminal<Space>++rows=10<Space>git<Space>push<CR>
nnoremap <C-g>p     :terminal<Space>++rows=10<Space>git<Space>pull<CR>
nnoremap <C-g>d     :call GitDiff(1)<CR><CR>
nnoremap <C-g><C-d> :call GitDiffClose()<CR><CR>

" Get current file diff with n'th commit.
" Open current file and diff in new tab.
" Also, provide a command to close that tab.
function! GitDiff(n)
	let l:filename = bufname('%')
	let l:filepath = getcwd()
	execute "! git show HEAD~" . a:n . ":" . l:filename . " > /tmp/" . l:filename . "; printf \"[INFO] Getting " . l:filename . " version from " . a:n . " commit(s) back\\n\" "
	execute "tabnew /tmp/" . l:filename
	execute "vertical diffs " . l:filepath . "/" . l:filename
endfunction
function! GitDiffClose()
	tabclose
	execute "! rm -f /tmp/" . bufname('%') . "; printf \"[INFO] /tmp cleaned from the temp diff files\\n\""
endfunction

" autogroups for makeprg
augroup auMakeprg
	autocmd Filetype go setlocal makeprg=go\ build
augroup END

"" autocommands for Golang files
" function! VIMGO()
	" silent execute "!goimports -w %"
	" silent execute "!gofmt -s -e -w %"
	" silent execute "!go vet % 2> out"
	" silent execute "!sed -i 's/vet://g' out"
	" silent execute "!golint % >> out"
	" silent execute "e! %"
	" silent execute "redraw!"
	" silent execute "cfile out"
	" execute "copen"
" endfunction
" augroup vimGo
    " au BufWritePost *.go silent execute "call VIMGO()"
	" au VimLeave *.go silent execute "!rm out"
" augroup END

" F4 to compile a program
function! F4()
	let l:base = expand('%:r')
    let l:ext = expand('%:e')
    " Markdown: open corresponding pdf
    if l:ext == "md"
		silent execute "!pandoc --standalone --from markdown --to pdf -t latex --variable papersize=A4 -o " . l:base . ".pdf " . l:base . ".md"
		silent execute "!zathura " . l:base . ".pdf&"
    elseif l:ext == "go"
        silent execute "make"
		execute "copen"
		execute "wincmd p"
    " elseif l:ext == "<ext>"
        " execute ...
    endif
	execute "redraw!"
endfunction


" F5 for running/executing programs 
function! F5()
	let l:src = expand('%')
	let l:base = expand('%:r')
    let l:ext = expand('%:e')
    " Markdown: open corresponding pdf
    if l:ext == "md"
		silent execute "!pandoc --standalone --from markdown --to pdf -t latex --variable papersize=A4 -o " . l:base . ".pdf " . l:base . ".md"
    elseif l:ext == "go"
		execute "term ++rows=10 ./" . fnamemodify(getcwd(), ':t')
    elseif l:ext == "sh" || l:ext == "zsh" || l:ext == "bash"
        execute ":!./" . src
    " elseif l:ext == "<ext>"
        " execute ...
    endif
	execute "redraw!"
endfunction


" https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript#:~:text=function!%20s%3Aget_visual_selection()%0A%20%20%20%20%22%20Why,lines%2C%20%22%5Cn%22)%0Aendfunction 
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" F2 for documentation
function! F2()
	" let l:base = expand('%:r')
    let l:ext = expand('%:e')
    if l:ext == "go"
		execute "term go doc " . s:get_visual_selection() 
    " elseif l:ext == "<ext>"
        " execute ...
    endif
	execute "redraw!"
endfunction

" F3 for testing
function! F3()
	" let l:base = expand('%:r')
    let l:ext = expand('%:e')
    if l:ext == "go"
		execute "term ++rows=10 go test -cover"
    " elseif l:ext == "<ext>"
        " execute ...
    endif
	execute "redraw!"
endfunction

vmap <F2> :call F2()<CR>
nmap <F3> :call F3()<CR>
nmap <F4> :call F4()<CR>
nmap <F5> :call F5()<CR>
