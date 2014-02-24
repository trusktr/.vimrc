
let s:VIMROOT = $HOME."/.vimtest"

" Create necessary folders if they don't already exist.
if exists("*mkdir")
    silent! call mkdir(s:VIMROOT, "p")
    silent! call mkdir(s:VIMROOT."/bundle", "p")
    silent! call mkdir(s:VIMROOT."/swap", "p")
    silent! call mkdir(s:VIMROOT."/undo", "p")
    silent! call mkdir(s:VIMROOT."/backup", "p")
else
    echo "Error: Create the directories ~/.vim/, ~/.vim/bundle/, ~/.vim/undo/, ~/.vim/backup/, and ~/.vim/swap/ first."
    exit
endif

if glob(s:VIMROOT."/bundle/") != "" " if the ~/.vim/bundle/ directory exists.

    if glob(s:VIMROOT."/bundle/neobundle.vim/") == "" " if NeoBundle doesn't exist
        echo "Installing NeoBundle..."
        silent! execute "!cd ".s:VIMROOT."/bundle/ && echo && git clone https://github.com/Shougo/neobundle.vim"
        if glob(s:VIMROOT."/bundle/neobundle.vim/") == "" " if NeoBundle still doesn't exist
            echo "Error: Unable to install NeoBundle. Make sure Git is installed then restart Vim to try again."
        endif
    endif

    if glob(s:VIMROOT."/bundle/neobundle.vim/") != "" " if NeoBundle exists
        " BEGIN NEOBUNDLE PLUGIN MANAGEMENT:
             if has('vim_starting')
                 set nocompatible               " be iMproved

                 " Required:
                 let &runtimepath.=",".s:VIMROOT."/bundle/neobundle.vim"
                 "execute 'set runtimepath+='.s:VIMROOT.'/bundle/neobundle.vim'
             endif

             " Required:
             call neobundle#rc(expand(s:VIMROOT.'/bundle/'))

             " Let NeoBundle manage NeoBundle
             " Required:
             NeoBundleFetch 'Shougo/neobundle.vim'


             " MY BUNDLES HERE:
             " Along with bundle-specific settings.
             " Note: You don't set neobundle setting in .gvimrc!
             " ORIGINAL REPOS ON GITHUB
                 NeoBundle 'Shougo/vimproc', {
                      \ 'build' : {
                      \     'windows' : 'make -f make_mingw32.mak',
                      \     'cygwin' : 'make -f make_cygwin.mak',
                      \     'mac' : 'make -f make_mac.mak',
                      \     'unix' : 'make -f make_unix.mak'
                      \    }
                      \ }
                 NeoBundle 'kchmck/vim-coffee-script'
                 NeoBundle 'tpope/vim-fugitive'
                 NeoBundle 'tpope/vim-markdown'
                 NeoBundle 'Lokaltog/vim-easymotion'
                 "NeoBundle 'mattn/zencoding-vim' " use emmet instead
                 NeoBundle 'mattn/emmet-vim'
                 "NeoBundle 'Valloric/YouCompleteMe' " TODO: Add build steps like for vimproc
                 NeoBundle 'scrooloose/nerdtree'
                 NeoBundle 'mhinz/vim-startify'
                 "NeoBundle 'mbbill/VimExplorer'
                 "NeoBundle 'yuratomo/gmail.vim'
                    "silent! source `=s:VIMROOT."/.gmail"` " Source login info
                 NeoBundle 'kien/ctrlp.vim'
                     let g:ctrlp_working_path_mode = 2 " CtrlP: use the nearest ancestor that contains one of these directories or files: .git/ .hg/ .svn/ .bzr/ _darcs/
                     nnoremap <silent> <leader>sh :h<CR>:CtrlPTag<CR>
                 "NeoBundle 'scrooloose/syntastic'
                     "let g:syntastic_mode_map = { 'mode': 'active' }
                     "let g:syntastic_error_symbol = '✗'
                     "let g:syntastic_style_error_symbol = '✠'
                     "let g:syntastic_warning_symbol = '∆'
                     "let g:syntastic_style_warning_symbol = '≈'
                 NeoBundle 'scrooloose/nerdcommenter'
                 "NeoBundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
                 "NeoBundle 'Lokaltog/vim-powerline'
                     "let g:Powerline_symbols='fancy' " Powerline: fancy statusline (patched font)
                 NeoBundle 'bling/vim-airline'
                 NeoBundle 'w0ng/vim-hybrid'
                 NeoBundle 'altercation/vim-colors-solarized'
                     let g:solarized_termcolors=256
                 NeoBundle 'stephenmckinney/vim-solarized-powerline'
                 NeoBundle 'nanotech/jellybeans.vim'
                 "NeoBundle 'mhinz/vim-signify'
                     "let g:signify_disable_by_default = 0
                     ""let g:signify_cursorhold_normal = 1
                     ""let g:signify_cursorhold_insert = 1
                 NeoBundle 'airblade/vim-gitgutter'
                 "NeoBundle 'msanders/snipmate.vim'
                 "NeoBundle 'https://github.com/SirVer/ultisnips.git' " why does this only work with the full url?
                 NeoBundle 'maxbrunsfeld/vim-yankstack'
                     nmap <leader>P <Plug>yankstack_substitute_newer_paste
                     nmap <leader>p <Plug>yankstack_substitute_older_paste
                 "NeoBundle 'nathanaelkane/vim-indent-guides'
                 "NeoBundle 'Yggdroot/indentLine'
                     "let g:indentLine_char = '.'
                     "let g:indentLine_first_char='.'
                     "let g:indentLine_showFirstIndentLevel=1
                 "NeoBundle 'megaannum/self' " required for megaannum/forms
                 "NeoBundle 'megaannum/forms' " Runs a bit slow..
                 "NeoBundle 'mfumi/snake.vim'
                 NeoBundle 'pangloss/vim-javascript'
             " VIM-SCRIPTS REPOS
                 "NeoBundle 'L9' " Required for FuzzyFinder
                 "NeoBundle 'FuzzyFinder'
                 NeoBundle 'vim-scripts/DrawIt'
                 NeoBundle 'vim-scripts/taglist.vim'
             " NON GITHUB REPOS
                 "NeoBundle 'git://git.wincent.com/command-t'
             " NON GIT REPOS
                 "NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
                 "NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'

                 " For creating text-based-ui menus in vim:
                 "NeoBundle 'svn://svn.code.sf.net/p/vimuiex/code/trunk', {
                             "\'name': 'vxlib',
                             "\'rtp': 'runtime/vxlib/'
                             "\}
                 "NeoBundle 'svn://svn.code.sf.net/p/vimuiex/code/trunk', {
                             "\'name': 'vimuiex',
                             "\'rtp': 'runtime/vimuiex/'
                             "\}

             " Required:
             filetype plugin indent on

             " If there are uninstalled bundles found on startup,
             " this will conveniently prompt you to install them.
             NeoBundleCheck

             " Brief help
             " :NeoBundleList          - list configured bundles
             " :NeoBundleInstall(!)    - install(update) bundles
             " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles
        " END NEOBUNDLE PLUGIN MANAGEMENT:
    endif

endif

" BEGIN VIM SUGGESTED DEFAULT SETTINGS BY BRAM MOOLENAR:
" Taken from /usr/share/vim/vim73/vimrc_example.vim

    " When started as "evim", evim.vim will already have done these settings.
    if v:progname =~? "evim"
      finish
    endif

    if has("vms")
      set nobackup		" do not keep a backup file, use versions instead
    else
      set backup		" keep a backup file
    endif
    "set history=500		" keep 50 lines of command line history
    set ruler		" show the cursor position all the time
    set showcmd		" display incomplete commands
    set incsearch		" do incremental searching

    " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
    " let &guioptions = substitute(&guioptions, "t", "", "g")

    " Don't use Ex mode, use Q for formatting
    "map Q gq

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
      filetype plugin indent off

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
      command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                      \ | wincmd p | diffthis
    endif
" END VIM SUGGESTED DEFAULT SETTINGS BY BRAM MOOLENAR:

" BEGIN CUSTOM SETTINGS:

    " TODO: Put this somewhere!! Skip to the next line with same indentation.
    " Nice.
        "nnore <leader>x :call search('^'.matchstr(getline('.'),'^\s*').'\S','We')<CR>

    " general settings.
        set wrapscan
        set whichwrap=b,s,<,>,[,],h,l
        set number
        set numberwidth=1
        set nowrap
        set sidescroll=5
        let &backupdir=s:VIMROOT.'/backup//'
        let &directory=s:VIMROOT.'/swap//'
        if exists('&undofile') && exists('&undodir')
            set undofile
            let &undodir=s:VIMROOT.'/undo'
        endif
        set tabstop=8
        set expandtab
        set shiftwidth=4 " Number of spaces for
        set softtabstop=4 " ...each indent level
        set ignorecase " Do case insensitive matching...
        set smartcase " ...except when using capital letters
        set incsearch " Incremental search
        set wildmenu " Better commandline tab completion
        set wildmode=longest:full,full " Expand match on first Tab complete
        set laststatus=2               " Always show a status line
        set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l\ of\ %L] " Show detailed information in status line
        set cursorline " highlight the current line.
        set virtualedit=onemore " so we can go one character past the last in normal mode.
        set showtabline=2 " 0 never show tab bar, 1 at least two tabs present, 2 always
        set scrolloff=0
        set listchars=tab:\ \ ,trail:· " tell vim how to represent certain characters. Make the cursor on a tab space appear at the front of the tab space.
        set list " enable the above character representation
        set notimeout " no timeout for any multikey combos. I'm too slow at some. hehe
        filetype indent plugin on " enable filetype features.
        set showcmd " display incomplete command. I moved this here from Bram's example because it wasn't working before vundle.
        set history=5000		" keep 5000 lines of command line history.
        set pastetoggle=<f12> " Toggle paste mode with <f12> for easy pasting without auto-formatting.
        set hidden " buffers keep their state when a new buffer is opened in the same view.
        set winminheight=0 " Show at least zero lines instead of at least one for horizontal splits.

    " prevent the alternate buffer in Gnome Terminal, etc, so output works
    " like vim's internal :echo command. woo!
    " TODO: Not so clean right now. The output of Git commands is ugly!! Make
    " it nice.
        "let old_t_te = &t_te
        "let old_t_ti = &t_ti
        "autocmd CmdwinEnter * set t_ti= t_te=
        "autocmd CmdwinLeave * let &t_te=old_t_te | let let &t_ti=old_t_ti

    " prevent the cursor from moving one space left after leaving insert.
    " DONE: make this work with <c-o> while in INSERT
        let CursorColumnI = 0 "the cursor column position in INSERT
        autocmd InsertEnter * let CursorColumnI = col('.')
        autocmd CursorMovedI * let CursorColumnI = col('.')
        autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

    " remove trailing spaces.
        " On Save:
            "let blacklist = ['bad'] " put filetypes that should keep whitespace here.
            "autocmd BufWritePre * if index(blacklist, &ft) < 0 | :%s/\s\+$//e | endif
        " With Keymap:
            " TODO: Return cursor to original position without losing `` marks.
            map <leader>d<space> :%s/\s\+$//g<cr>

    " Update the status line immediately when leaving INSERT or VISUAL mode by
    " pressing <esc>
        if ! has('gui_running')
            set ttimeoutlen=10
            augroup FastEscape
                autocmd!
                au InsertEnter * set timeout | set timeoutlen=0
                au InsertLeave * set timeoutlen=1000 | set notimeout
                " TODO: Make this work with VISUAL also. No VisualEnter/Leave
                " autocmds though. :(
                "au VisualEnter * set timeout | set timeoutlen=0
                "au InsertLeave * set timeoutlen=1000 | set notimeout
            augroup END
        endif


    " STYLE
        " look and feel (colorscheme, font, etc)
        " FOR SPECIFIC ENVIRONMENTS
            if &term == "linux"
                " nothing here yet
            elseif &term == "xterm" || &term == "xterm-256color"
                " make the background color always transparent in xterm
                    "autocmd ColorScheme * highlight normal ctermbg=None
                set t_Co=256 " enable full color
                silent! colorscheme hybrid
                highlight LineNr ctermfg=red
                highlight MatchParen cterm=bold ctermbg=none ctermfg=green
            elseif has("gui_running")
                silent! colorscheme hybrid
                highlight LineNr guifg=red
                highlight MatchParen gui=bold guibg=black guifg=limegreen
                if has("gui_gtk2")
                    silent! set guifont=Ubuntu\ Mono\ for\ Powerline\ 11
                elseif has("gui_win32")
                    silent! set guifont=Consolas:h11:cANSI
                endif
            endif
        " FOR ALL ENVIRONMENTS
            set guioptions=acegimrLbtT

    " BEGIN KEYBINDINGS:
        " prevent me from using arrow keys. Grrrrr.
            "map <up> iisuckatvi
            "map <down> iisuckatvi
            "map <left> iisuckatvi
            "map <right> iisuckatvi
            "imap <up> isuckatvi
            "imap <down> isuckatvi
            "imap <left> isuckatvi
            "imap <right> isuckatvi

        " MOVEMENT
            " make uhjk like arrow keys and move undo to l.
            " TODO: make sure this is consistent across modes including when
            " waiting for keystroke combinations and when using ctrl for
            " movement like with arrow keys.
            " TODO: Make toggle between new modes and classic mode.
            " TODO: Make this into a plugin.
                "nnoremap u k
                "nnoremap k l
                "nnoremap l u
                "xnoremap u k
                "xnoremap k l
                "xnoremap l u
                "nmap <c-u> <c-up>
                "nmap <c-h> <c-left>
                "nmap <c-j> <c-down>
                "nmap <c-k> <c-right>
                "imap <c-u> <c-up>
                "imap <c-h> <c-left>
                "imap <c-j> <c-down>
                "imap <c-k> <c-right>

                nnoremap j h
                nnoremap k j
                nnoremap i k
                nnoremap h i
                xnoremap j h
                xnoremap k j
                xnoremap i k
                xnoremap h i
                nmap <c-i> <c-up>
                nmap <c-j> <c-left>
                nmap <c-k> <c-down>
                nmap <c-l> <c-right>
                imap <c-i> <c-up>
                imap <c-j> <c-left>
                imap <c-k> <c-down>
                imap <c-l> <c-right>
                if has("gui_running") " alt combinations have to be treated differently in gvim vs console vim.
                    imap <a-i> <up>
                    imap <a-j> <left>
                    imap <a-k> <down>
                    imap <a-l> <right>
                else
                    imap i <up>
                    imap j <left>
                    imap k <down>
                    imap l <right>
                endif


            " make using ctrl+arrows to move by word.
                map <c-left> b
                map <c-right> e
                " TODO: Move cursor programmatically, not with maps to other keys.
                nmap <c-up> 10<up>
                nmap <c-down> 10<down>
                imap <c-up> <c-o>10<up>
                imap <c-down> <c-o>10<down>
                "map <s-left> B
                "map <s-right> E

        " SELECTION
            " ctrl+a to enter VISUAL and select all.
                map  <c-a> <esc>ggVG
                map! <c-a> <esc>ggVG
            " Enter VISUAL mode by holding shift+arrows or ctrl+shift+arrows, exit when shift not held.
                map <c-c> <esc>
                xnoremap <right> <esc><right>
                xnoremap <left> <esc><left>
                xnoremap <up> <esc><up>
                xnoremap <down> <esc><down>
                xnoremap <c-right> <esc>e
                xnoremap <c-left> <esc>b
                xnoremap <c-up> <esc>10<up>
                xnoremap <c-down> <esc>10<down>
                nnoremap <s-right> v<right>
                xnoremap <s-right> <right>
                inoremap <s-right> <c-o>v<right>
                nnoremap <s-left> v<left>
                xnoremap <s-left> <left>
                inoremap <s-left> <c-o>v<left>
                nnoremap <s-up> v<up>
                xnoremap <s-up> <up>
                inoremap <s-up> <c-o>v<up>
                nnoremap <s-down> v<down>
                xnoremap <s-down> <down>
                inoremap <s-down> <c-o>v<down>
                nnoremap <c-s-right> ve
                xnoremap <c-s-right> e
                inoremap <c-s-right> <c-o>ve
                nnoremap <c-s-left> vb
                xnoremap <c-s-left> b
                inoremap <c-s-left> <c-o>vb
                nnoremap <c-s-up> v10<up>
                xnoremap <c-s-up> 10<up>
                inoremap <c-s-up> <c-o>v10<up>
                nnoremap <c-s-down> v10<down>
                xnoremap <c-s-down> 10<down>
                inoremap <c-s-down> <c-o>v10<down>
                nmap <s-home> v<home>
                nmap <s-end> v<end>
                nnoremap <c-s-home> vgg0
                nnoremap <c-s-end> vG<end>

        " deleting with ctrl
            imap <c-bs> <c-w>
            imap <c-h> <c-w>
            " no ctrl+backspace for now. :(
            imap <c-del> <c-o>de
            imap [3;5~ <c-o>de

        " smart home key.
            nmap <expr> <home> search('^\s\+\%#', 'n') ? '0' : '_'
            vmap <expr> <home> search('^\s\+\%#', 'n') ? '0' : '_'
            vmap <expr> <s-home> search('^\s\+\%#', 'n') ? '0' : '_'
            imap <expr> <home> search('^\s\+\%#', 'n') ? '<c-o>0' : '<c-o>_'

        " end key goes past last letter in NORMAL mode with :set virtualedit=onemore.
            nmap <end> <end><right>

        " SEARCHING
            " ctrl+f to find.
                "map  <c-f> <esc>/
                "map! <c-f> <esc>/
            " enter to find next ocurrences.
                map <cr> n
                map <s-cr> N
            " highlight all matches of current word, but do not move cursor to
            " the next or previous ocurrence likw * and # do.
                nnoremap <leader>s :let @/ = expand('<cword>') <bar> echo @/ <bar> set hls<cr>
            " same thing as above, but highlights the visual selection.
                xnoremap <leader>s "*y<esc>:let @/ = substitute(escape(@*, '\/.*$^~[]'), "\n", '\\n', "g") <bar> echo @/ <bar> set hls<cr>

            " ctrl+c to control search highlight. ctrl+c doesn't do anything
            " in normal mode otherwise. Uncomment one of the two lines. The
            " first one only turns off search highlight when it is on, no
            " toggling, but a subsequent search or typing n or N will turn it
            " back on automatically. The second one toggles search highlight
            " on or off, and searching does not automatically turn it back on.
                "nnoremap <c-c> :nohlsearch<cr>
                nnoremap <c-c> :if (&hlsearch == 1) \| set nohlsearch \| else \| set hlsearch \| endif <cr>

        " Move line or selection up or down with alt+up/down and indent based
        " on new location.
            nnoremap <a-down> :m .+1<cr>==
            nnoremap <a-up> :m .-2<cr>==
            inoremap <a-down> <esc>:m .+1<cr>==gi
            inoremap <a-up> <esc>:m .-2<cr>==gi
            vnoremap <a-down> :m '>+1<cr>gv=gv
            vnoremap <a-up> :m '<-2<cr>gv=gv

        " save with ctrl+s
            "imap <c-s> <c-o>:w<cr>
            map <c-s> :w<cr>

        " toggle comments. Requires scrooloose/nerdcommenter plugin.
            let commented = 0
            nnoremap <c-_> :if (commented%2 == 0) \| exe 'normal \<leader>cl' \| else \| exe 'normal \<leader>cu' \| endif \| let commented=commented+1<cr>

        " Reformat current paragraph
            xnoremap Q gq
            nnoremap Q gqap

        " Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
        " which is the default
            nmap Y y$

        " Make p paste CUA style like gedit, notepad, etc (e.g. pastes then
        " the cursor is at the end of the paste).
            nmap p p`]
        " paste copied line literally, at cursor position. TODO: Strip
        " whitespace.
            nmap \p i<c-r>"<c-o>0<bs><c-c>

        " backspace in normal mode.
            "nmap <bs> X

        " BUFFER NAVIGATION
            " shift+ctrl+t to open new tabs.
            "map <c-t> :tabnew<cr>
            map <c-t> :tabnew<cr>:Startify<cr>
        " alt+left/right to move between tabs.
            map <a-right> gt
            map <a-left> gT

            " TODO: ijkl
            nnoremap <a-j> gt
            nnoremap <a-l> gT

        " quick buffer switching
            nnoremap <leader>b :buffers<cr>:b<space>
    " END KEYBINDINGS:

    " COMMAND MAPS AND KEYMAPS TO CUSTOM FUNCTIONS:
        " :h is shortcut for ":tab help"
            cabbrev h tab help

        " TODO: make Git work like Gpedit! for fugitive.
            cabbrev git Gpedit!
            "function! MyGit()
            "    pedit
            "endfunction
            "command! Git call MyGit()
            if has("autocmd")
                autocmd User Fugitive command! -buffer -nargs=* Git Gpedit! <args>
            endif

        " MAXIMIZE OR MINIMIZE CURRENT WINDOW
        " TODO: DOESN"T WORK!!
        " toggles whether or not the current window is automatically zoomed
            function! ToggleMaxWins()
                if exists('g:windowMax')
                    au! maxCurrWin
                    wincmd =
                    unlet g:windowMax
                else
                    augroup maxCurrWin
                        " au BufEnter * wincmd _ | wincmd |
                        "
                        " only max it vertically
                        au! WinEnter * wincmd _
                    augroup END
                    do maxCurrWin WinEnter
                    let g:windowMax=1
                endif
            endfunction

            nnoremap <Leader>max :call ToggleMaxWins()<CR>


        " PREVIEW WINDOW TEST
            let g:MyVimTips="off"
            function! ToggleVimTips()
                if g:MyVimTips == "on"
                    let g:MyVimTips="off"
                    pclose
                else
                    let g:MyVimTips="on"
                    " add a cheat sheet here to easily toggle with <F4>
                    pedit ~/.vim-quicktip
                endif
            endfunction

        nnoremap <F4> :call ToggleVimTips()<CR>

        " TOGGLE RELATIVE OR ABSOLUTE NUMBERS
            if exists('+relativenumber')
                set relativenumber " start with relative numbers
                function! NumberToggle()
                    if(&relativenumber == 1)
                        set norelativenumber
                    else
                        set relativenumber
                    endif
                endfunc

                nnoremap <C-n> :call NumberToggle()<cr>
                autocmd FocusLost * :set norelativenumber
                autocmd FocusGained * :set relativenumber
                autocmd InsertEnter * :set norelativenumber
                autocmd InsertLeave * :set relativenumber
            endif

        " TOGGLE LITERATE MODE
            " TODO: optimize, make into a plugin.
            noremap <silent> <Leader>w :call ToggleWrap()<CR>
            function ToggleWrap()
                if &wrap
                    echo "Wrap OFF"
                    setlocal nowrap
                    "set virtualedit=all
                    silent! nunmap <buffer> <Up>
                    silent! nunmap <buffer> <Down>
                    silent! nunmap <buffer> <Home>
                    silent! nunmap <buffer> <End>
                    silent! iunmap <buffer> <Up>
                    silent! iunmap <buffer> <Down>
                    silent! iunmap <buffer> <Home>
                    silent! iunmap <buffer> <End>
                else
                    echo "Wrap ON"
                    setlocal wrap linebreak nolist
                    "set virtualedit=
                    "setlocal display+=lastline
                    noremap  <buffer> <silent> <Up>   gk
                    noremap  <buffer> <silent> <Down> gj
                    noremap  <buffer> <silent> <Home> g<Home>
                    noremap  <buffer> <silent> <End>  g<End>
                    noremap  <buffer> <silent> i      gk
                    noremap  <buffer> <silent> k      gj
                    inoremap <buffer> <silent> <Up>   <C-o>gk
                    inoremap <buffer> <silent> <Down> <C-o>gj
                    inoremap <buffer> <silent> <Home> <C-o>g<Home>
                    inoremap <buffer> <silent> <End>  <C-o>g<End>
                endif
            endfunction

    " END COMMAND MAPS AND SPECIAL FUNCTION MAPS:

" END CUSTOM SETTINGS:

