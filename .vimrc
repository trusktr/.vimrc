" NOTE: You'll need to find and replace file separators if running in a
" non-unix environment (e.g. DOS).

" TODO: Make a FileSeparator variable to handle each OS.

scriptencoding utf-8 " make sure we use utf-8 before doing anything.
behave mswin " awesome (but horrible name choice. "behave cua" would be nicer. I dislike Windows.) Treats the cursor like an I beam when selecting text instead of a block, and if you have a block the I beam is basically the left edge of the block.
runtime! macros/matchit.vim " enabled awesome match abilities like HTML tag matching with %

let s:VIMROOT = $HOME."/.vim"

" Create necessary folders if they don't already exist.
if exists("*mkdir")
    silent! call mkdir(s:VIMROOT, "p")
    silent! call mkdir(s:VIMROOT."/bundle", "p")
    silent! call mkdir(s:VIMROOT."/swap", "p")
    silent! call mkdir(s:VIMROOT."/undo", "p")
    silent! call mkdir(s:VIMROOT."/backup", "p")
else
    echo "Error: Create the directories ".s:VIMROOT."/, ".s:VIMROOT."/bundle/, ".s:VIMROOT."/undo/, ".s:VIMROOT."/backup/, and ".s:VIMROOT."/swap/ first."
    exit
endif

" if the ".s:VIMROOT."/bundle/ directory exists.
if glob(s:VIMROOT."/bundle/") != ""

    if glob(s:VIMROOT."/bundle/neobundle.vim/") == "" " if NeoBundle doesn't exist
        if (match(system('which git'), "git not found") == -1) " if git is installed
            echo "Setting up plugin manager..."
            silent! execute "cd ".s:VIMROOT."/bundle/"
            silent! execute "!echo && git clone https://github.com/Shougo/neobundle.vim"
            if glob(s:VIMROOT."/bundle/neobundle.vim/") == "" " if NeoBundle still doesn't exist
                echo "Error: Unable to set up the plugin manager. Something went wrong with git (likely a connection problem). Restart Vim to try again."
            endif
        else
            echo "Tip: Install Git then restart Vim to experience Vim in all it's glory."
        endif
    endif

    if glob(s:VIMROOT."/bundle/neobundle.vim/") != "" " if NeoBundle exists
        " BEGIN NEOBUNDLE PLUGIN MANAGEMENT:
            if has('vim_starting')
                set nocompatible               " be iMproved

                " Required:
                let &runtimepath.=",".s:VIMROOT."/bundle/neobundle.vim"
                "execute 'set runtimepath+='.s:VIMROOT.'/bundle/neobundle.vim'
                " ^^^ TODO: note why I did this.
                let g:neobundle#install_process_timeout = 600
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
                " TODO:
                "NeoBundle 'Shougo/vimproc', {
                     "\ 'build' : {
                     "\     'windows' : 'make -f make_mingw32.mak',
                     "\     'cygwin' : 'make -f make_cygwin.mak',
                     "\     'mac' : 'make -f make_mac.mak',
                     "\     'unix' : 'make -f make_unix.mak'
                     "\    }
                     "\ }
                NeoBundle 'kchmck/vim-coffee-script'
                NeoBundle 'tpope/vim-fugitive'
                NeoBundle 'tpope/vim-markdown'
                NeoBundle 'Lokaltog/vim-easymotion'
                "NeoBundle 'mattn/zencoding-vim' " use emmet instead
                NeoBundle 'mattn/emmet-vim'

                "" TODO: YouCompleteMe
                "if has("unix")
                "    " make sure you have cmake and python installed (and python support in vim). Add/remove the install command arguments as necessary. You need to have clang installed if you use the --system-libclang flag; if you don't use the flag the installer will download the binary from llvm.org. see YCM docs.
                "    NeoBundle 'Valloric/YouCompleteMe', {
                "         \ 'build' : {
                "         \     'mac' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
                "         \     'unix' : './install.sh --clang-completer --system-libclang --omnisharp-completer'
                "         \    }
                "         \ }
                "else
                "    if has("win32")
                "        " Windows user: have fun, good luck, or both. ;)
                "        " TODO: See here for starters on installing for Windows: http://stackoverflow.com/questions/18801354/c-family-semantic-autocompletion-plugins-for-vim-using-clang-clang-complete-yo
                "        NeoBundle 'Valloric/YouCompleteMe', {
                "             \ 'build' : {
                "             \     'windows' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
                "             \     'cygwin' : './install.sh --clang-completer --system-libclang --omnisharp-completer'
                "             \    }
                "             \ }
                "    endif
                "endif
                "    " TODO: download default ycm_extra)conf linked here: http://www.alexeyshmalko.com/2014/youcompleteme-ultimate-autocomplete-plugin-for-vim/
                "    let g:ycm_global_ycm_extra_conf = s:VIMROOT.'/.ycm_extra_conf.py'
                "    let g:ycm_collect_identifiers_from_tags_files = 1
                "    let g:ycm_seed_identifiers_with_syntax = 1

                NeoBundle 'scrooloose/nerdtree'
                NeoBundle 'mhinz/vim-startify'
                   let g:startify_session_dir = s:VIMROOT.'/session'
                "NeoBundle 'mbbill/VimExplorer'
                "NeoBundle 'yuratomo/gmail.vim'
                   "silent! source `=s:VIMROOT."/.gmail"` " Source login info
                NeoBundle 'kien/ctrlp.vim'
                    let g:ctrlp_working_path_mode = 2 " CtrlP: use the nearest ancestor that contains one of these directories or files: .git/ .hg/ .svn/ .bzr/ _darcs/
                    nnoremap <silent> <leader>sh :h<CR>:CtrlPTag<CR>
                NeoBundle 'scrooloose/syntastic'
                    let g:syntastic_mode_map             = { 'mode': 'active' }
                    let g:syntastic_error_symbol         = 'E'
                    let g:syntastic_style_error_symbol   = 'e'
                    let g:syntastic_warning_symbol       = 'W'
                    let g:syntastic_style_warning_symbol = 'w'
                NeoBundle 'scrooloose/nerdcommenter'

                " COLORSCHEMES
                    NeoBundle 'w0ng/vim-hybrid'
                    "NeoBundle 'noahfrederick/vim-hemisu'
                    "NeoBundle 'altercation/vim-colors-solarized'
                        "let g:solarized_termcolors=256
                        "set background=dark " specify whether you want the light theme or the dark theme.
                    "NeoBundle 'jonathanfilip/vim-lucius'
                    "NeoBundle 'jnurmine/Zenburn'
                    "NeoBundle 'adlawson/vim-sorcerer'
                    "NeoBundle 'zeis/vim-kolor'
                    "NeoBundle 'jordwalke/flatlandia'
                    "NeoBundle 'antlypls/vim-colors-codeschool'
                    "NeoBundle 'morhetz/gruvbox'
                    "NeoBundle '3DGlasses.vim'

                "NeoBundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
                "NeoBundle 'Lokaltog/vim-powerline'
                    "let g:Powerline_symbols='fancy' " Powerline: fancy statusline (patched font)
                "NeoBundle 'stephenmckinney/vim-solarized-powerline'
                NeoBundle 'bling/vim-airline'
                    let g:airline#extensions#syntastic#enabled = 1
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
                NeoBundle 'briancollins/vim-jst'
                NeoBundle 'jimmyhchan/dustjs.vim'
                "NeoBundle 'sjl/gundo.vim'
                NeoBundle 'mbbill/undotree'
                "NeoBundle 'wesQ3/vim-windowswap' " easily swap window splits.
                NeoBundle 'MattesGroeger/vim-bookmarks' " nice (annotated) bookmarks in your gutter.

                " A bunch of filetype plugins. Put NerdCommenter after this to
                " give prefernce to those shortcuts, otherwise this overrides
                " many of them.
                "NeoBundle 'WolfgangMehner/vim-plugins'
                " ^^^ TODO: Many mapping conflicts.

                NeoBundle 'ide'
                " ^^^ Effing amazing. Great idea.

                NeoBundle 'http://conque.googlecode.com/svn/trunk/', {
                            \'name': 'conque',
                        \}

                NeoBundle 'majutsushi/tagbar'
                NeoBundle 'gcmt/taboo.vim'
                    let g:taboo_tab_format         = " %N:%f%m "
                    let g:taboo_renamed_tab_format = " %N:\"%l%m\" "

                " Align stuff.
                NeoBundle 'junegunn/vim-easy-align'
                    xmap <leader>a <Plug>(EasyAlign)
                "NeoBundle 'godlygeek/tabular'

            " VIM.ORG SCRIPTS
                set cursorline " highlight the current line. Needed for the next plugin to work.
                NeoBundle "CursorLineCurrentWindow"
                "NeoBundle 'L9' " Required for FuzzyFinder
                "NeoBundle 'FuzzyFinder'
                NeoBundle 'DrawIt'
                if !(&term == "win32" || $TERM == "cygwin")
                   NeoBundle 'taglist.vim'
                endif
                "NeoBundle 'CmdlineCompl.vim' SEEMS OUTDATED
                "NeoBundle 'hexman.vim'

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

            " LOCAL PLUGINS
                "NeoBundle 'file:///home/user/path/to/plugin'

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

      " For all text files set 'textwidth' to 80 characters.
      "autocmd FileType text setlocal textwidth=80

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
        let &backupdir=s:VIMROOT.'/backup//' " double slash means make the filenames unique.
        let &directory=s:VIMROOT.'/swap//' " double slash means make the filenames unique.
        if has("persistent_undo")
            if exists('&undofile') && exists('&undodir')
                set undofile
                let &undodir=s:VIMROOT.'/undo'
            endif
        endif
        set tabstop=8
        set expandtab
        set shiftwidth=4 " Number of spaces for...
        set softtabstop=4 " each indent level
        set textwidth=0 " At which column to wrap to the next line when typing.
        set colorcolumn=0 " At which column to show the margin line. TODO: make a toggle to turn the column on and off.
        set ignorecase " Do case insensitive matching...
        set smartcase " ...except when using capital letters
        set incsearch " Incremental search
        set wildmenu " Better commandline tab completion
        set wildmode=longest:list,full " Complete longest common string and show the match list, then epand to first full match
        set laststatus=2               " Always show a status line
        "set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l\ of\ %L] " custom status line. Not needed if using powerline or airline.
        set cursorline " highlight the current line.
        "set cursorcolumn " highlight the current column.
        set virtualedit=onemore " so we can go one character past the last in normal mode.
        set backspace=indent,eol,start " don't limit backspace to one line. Behaves like a modern editor in this regard.
        set showtabline=2 " 0 never show tab bar, 1 at least two tabs present, 2 always
        set scrolloff=0 " how many lines to keep before and after the cursor near the top or bottom of the view.
        "tell vim how to represent certain characters. Make the cursor on a tab space appear at the front of the tab space:
            "if !(&term == "win32" || $TERM == "cygwin")
                "set listchars=tab:\ \ ,trail:·
            "else
                set listchars=tab:˒\ ,trail:×,nbsp:·,conceal:¯,eol:¬
            "endif
            set list " enable the above character representation
        set timeout
        set timeoutlen=1000000 " Really long timeout length for any multikey combos so it seems like there's no timeout, but with some of the benefits of having a timeout. I don't like when partially typed commands dissappear without my permission.
        filetype indent plugin on " enable filetype features.
        set showcmd " display incomplete command. I moved this here from Bram's example because it wasn't working before vundle.
        set history=9999		" how many lines of command line history to keep.
        set pastetoggle=<f12> " Toggle paste mode with <f12> for easy pasting without auto-formatting.
        set hidden " buffers keep their state when a new buffer is opened in the same view.
        set winminheight=0 " Show at least zero lines instead of at least one for horizontal splits.
        set sessionoptions=blank,curdir,folds,help,resize,slash,tabpages,unix,winpos,winsize " :help sessionoptions

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
            set ttimeoutlen=10 " TODO: Does this interfere with the above set timeoutlen?
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
        " FOR ALL ENVIRONMENTS
            set guioptions=acegimrLbtT
        " FOR SPECIFIC ENVIRONMENTS
            if &term == "linux" " 16-color
                " nothing here yet. TODO: Find a good 16-color theme.
            else " 256-color
                silent! colorscheme hybrid
                if &term == "xterm" || &term == "xterm-256color" || &term == "screen-256color"
                    " make the background color always transparent in xterm
                        "autocmd ColorScheme * highlight normal ctermbg=None
                    set t_Co=256 " enable full color
                    set t_ut= " disable clearing of the background. This is helpful in tmux and screen.
                    set ttymouse=xterm2 " use advanced mouse support even if not in xterm (e.g. if in screen/tmux).
                    highlight LineNr ctermfg=red
                    highlight MatchParen cterm=bold,underline ctermbg=none ctermfg=green
                    highlight TabLineSel ctermfg=yellow
                    highlight TabLineFill ctermfg=black
                elseif has("gui_running")
                    highlight LineNr guifg=red
                    highlight MatchParen gui=bold guibg=black guifg=limegreen
                    if has("gui_gtk2")
                        silent! set guifont=Ubuntu\ Mono\ for\ Powerline\ 13
                    elseif has("gui_win32")
                        silent! set guifont=Consolas:h11:cANSI
                    endif
                endif
            endif

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

                " TODO TODO TODO TODO: Map all HJKL to IJKL conversion in one place
                " no-recursively, then use the literal mapping for
                " functionality.
                noremap i k
                noremap j h
                noremap k j
                noremap h i
                nmap <c-i> <c-up>
                nmap <c-j> <c-left>
                nmap <c-k> <c-down>
                nmap <c-l> <c-right>
                if has("gui_running") " alt combinations have to be treated differently in gvim vs console vim.
                    imap <a-i> <up>
                    imap <a-j> <left>
                    imap <a-k> <down>
                    imap <a-l> <right>
                    imap <c-a-i> <c-up>
                    imap <c-a-j> <c-left>
                    imap <c-a-k> <c-down>
                    imap <c-a-l> <c-right>
                else
                    imap i <up>
                    imap j <left>
                    imap k <down>
                    imap l <right>
                    " TODO: the following doesn't work in terminal.
                    imap <c-a-i> <c-up>
                    imap <c-a-j> <c-left>
                    imap <c-a-k> <c-down>
                    imap <c-a-l> <c-right>
                    " TODO: temporary for terminal until a solution exists:
                    imap <c-i> <c-up>
                    imap <c-j> <c-left>
                    imap <c-k> <c-down>
                    imap <c-l> <c-right>
                endif


            " make using ctrl+arrows to move by word. TODO: Do programmatically
                map <c-left> b
                map <c-right> e
                " TODO: Move cursor programmatically with a function, not with maps to other keys. It will perform faster.
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
            " Enter VISUAL mode by holding shift+arrows or ctrl+shift+arrows
                map <c-c> <esc>
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
            " exit VISUAL when shift not held.
                "xnoremap <right> <esc><right>
                "xnoremap <left> <esc><left>
                "xnoremap <up> <esc><up>
                "xnoremap <down> <esc><down>
                "xnoremap <c-right> <esc>e
                "xnoremap <c-left> <esc>b
                "xnoremap <c-up> <esc>10<up>
                "xnoremap <c-down> <esc>10<down>

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
            " VVV TODO: map ijkl keys to hjkl keys instead, then map the hjkl keys to the actual action.
            nnoremap <a-k> :m .+1<cr>==
            nnoremap <a-i> :m .-2<cr>==
            vnoremap <a-k> :m '>+1<cr>gv=gv
            vnoremap <a-i> :m '<-2<cr>gv=gv

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
            " alt+left/right to move between tabs in normal mode.
                nmap <a-right> gt
                nmap <a-left> gT
                " Why don't the next two work in console?
                noremap <a-l> gt
                noremap <a-j> gT
                " ^^^ TODO: map ijkl keys to hjkl keys instead, then map the hjkl keys to the actual action.
                noremap l gt
                noremap j gT
            " quick buffer switching
                nnoremap <leader>b :buffers<cr>:b<space>
            " HJKL to IJKL split window commands.
                nnoremap <c-w>i <c-w>k
                nnoremap <c-w>k <c-w>j
                nnoremap <c-w>j <c-w>h
                nnoremap <c-w>h <c-w>i
                nnoremap <c-w>I <c-w>K
                nnoremap <c-w>K <c-w>J
                nnoremap <c-w>J <c-w>H
                nnoremap <c-w>H <c-w>I
            " easier split window switching.
                nnoremap <c-a-i> <c-w>k
                nnoremap <c-a-k> <c-w>j
                nnoremap <c-a-j> <c-w>h
                nnoremap <c-a-l> <c-w>l

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


        " CHEAT SHEET WITH <F4>. Put helpful content in VIMROOT/quicktip.
            let g:MyVimTips="off"
            function! ToggleVimTips()
                if g:MyVimTips == "on"
                    let g:MyVimTips="off"
                    pclose
                else
                    let g:MyVimTips="on"
                    " add a cheat sheet here to be easily toggle with <F4>
                    execute "pedit ".s:VIMROOT."/quicktip"
                    " TODO: hard code the quicktip so it will work for whomever
                    " copies my setup?
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
