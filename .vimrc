" NOTE: You'll need to find and replace file separators if running in a
" non-unix environment (e.g. DOS).

" TODO: Make a FileSeparator variable to handle each OS.

scriptencoding utf-8 " make sure we use utf-8 before doing anything.
"behave mswin " awesome (but horrible name choice. "behave cua" would be nicer. I dislike Windows.) Treats the cursor like an I beam when selecting text instead of a block, and if you have a block the I beam is basically the left edge of the block.
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
                let g:neobundle#install_process_timeout = 600
            endif

            " Required:
            call neobundle#begin(expand(s:VIMROOT.'/bundle/'))

                " Let NeoBundle manage NeoBundle
                " Required:
                NeoBundleFetch 'Shougo/neobundle.vim'


                " MY BUNDLES HERE:
                " Along with bundle-specific settings.
                " Refer to |:NeoBundle-examples|.
                " Note: You don't set neobundle setting in .gvimrc!

                " EXAMPLES:
                    " GITHUB REPOS:
                        " NeoBundle 'username/repo'

                    " VIMSCRIPTS.ORG SCRIPTS:
                        " NeoBundle 'script-name'

                    " NON GITHUB REPOS:
                        "NeoBundle 'git://git.wincent.com/command-t'

                    " NON GIT REPOS:
                        "NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
                        "NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'

                    " LOCAL PLUGINS
                        "NeoBundle 'file:///home/user/path/to/plugin'

                " Brief help
                " :NeoBundleList          - list configured bundles
                " :NeoBundleInstall(!)    - install(update) bundles
                " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

                " TODO:
                NeoBundle 'Shougo/vimproc.vim', {
                     \ 'build' : {
                     \     'windows' : 'tools\\update-dll-mingw',
                     \     'cygwin' : 'make -f make_cygwin.mak',
                     \     'mac' : 'make -f make_mac.mak',
                     \     'linux' : 'make',
                     \     'unix' : 'gmake',
                     \    },
                     \ }

                NeoBundle 'mhinz/vim-startify'
                   let g:startify_session_dir = s:VIMROOT.'/session'

                NeoBundle 'tpope/vim-fugitive'
                NeoBundle 'Lokaltog/vim-easymotion'

                NeoBundle 'scrooloose/nerdtree'
                    nnoremap <leader>f :NERDTreeToggle<cr>

                "NeoBundle 'mbbill/VimExplorer'

                "NeoBundle 'yuratomo/gmail.vim'
                   "silent! source `=s:VIMROOT."/.gmail"` " Source login info

                "NeoBundle 'scrooloose/syntastic' " All purpose syntax checking " SLOW
                    "let g:syntastic_check_on_open        = 0
                    "let g:syntastic_check_on_wq          = 0
                    "let g:syntastic_auto_jump            = 2
                    ""let g:syntastic_auto_loc_list        = 1
                    "let g:syntastic_mode_map             = { 'mode': 'passive' }
                    ""let g:syntastic_error_symbol         = 'E'
                    "let g:syntastic_error_symbol         = "✗"
                    "let g:syntastic_style_error_symbol   = 'e'
                    ""let g:syntastic_warning_symbol       = 'W'
                    "let g:syntastic_warning_symbol       = "∇"
                    "let g:syntastic_style_warning_symbol = 'w'

                NeoBundle 'benekastah/neomake' " Makers for various file types. Includes jshint for JavaScript.
                    let g:neomake_javascript_jshint_maker = {
                        \ 'args': ['--verbose'],
                        \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)'
                        \ }
                    let g:neomake_javascript_enabled_makers = ['jshint']
                    let g:neomake_error_sign = {
                        \ 'text': '✗',
                        \ 'texthl': 'ErrorMsg',
                        \ }
                    let g:neomake_warning_sign = {
                        \ 'text': '∇',
                        \ 'texthl': 'WarningMsg',
                        \ }

                    autocmd FileType javascript :autocmd BufWritePost <buffer> :Neomake

                NeoBundle 'scrooloose/nerdcommenter'

                " COLORSCHEMES
                    NeoBundle 'w0ng/vim-hybrid'
                    NeoBundle 'daylerees/colour-schemes', { 'rtp': 'vim', }
                    NeoBundle 'djjcast/mirodark'
                    "NeoBundle 'nicholasc/vim-seti' // doesn't work in terminal
                    NeoBundle 'trusktr/seti.vim'
                    NeoBundle 'noahfrederick/vim-hemisu'
                    NeoBundle 'altercation/vim-colors-solarized'
                        let g:solarized_termcolors=256
                        set background=dark " specify whether you want the light theme or the dark theme.
                    "NeoBundle 'jonathanfilip/vim-lucius'
                    NeoBundle 'jnurmine/Zenburn'
                    "NeoBundle 'adlawson/vim-sorcerer'
                    "NeoBundle 'zeis/vim-kolor'
                    "NeoBundle 'jordwalke/flatlandia'
                    "NeoBundle 'antlypls/vim-colors-codeschool'
                    NeoBundle 'morhetz/gruvbox'
                        " disable gruvbox italics, which causes line colors to be inverted
                        if !has("gui_running")
                            let g:gruvbox_italic=0
                        endif
                        silent !~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh " enable this for terminal support if you're using gruvbox in Mac OS X iterm2.
                        silent !~/.vim/bundle/gruvbox/gruvbox_256palette.sh     " enable this for terminal support if you're using gruvbox in 256-colore linux terminal.
                    "NeoBundle '3DGlasses.vim'
                    NeoBundle 'goatslacker/mango.vim'
                    "NeoBundle 'jasonlong/lavalamp', {
                        "\ 'rtp': 'vim',
                        "\ 'build' : {
                        "\     'mac':   'mkdir ./vim/colors && cp -f ./vim/lavalamp.vim ./vim/colors/lavalamp.vim',
                        "\     'unix':  'mkdir ./vim/colors && cp -f ./vim/lavalamp.vim ./vim/colors/lavalamp.vim',
                        "\     'linux': 'mkdir ./vim/colors && cp -f ./vim/lavalamp.vim ./vim/colors/lavalamp.vim'
                        "\    }
                        "\ }
                    NeoBundle 'nanotech/jellybeans.vim'
                    NeoBundle 'chriskempson/base16-vim'
                    NeoBundle 'xolox/vim-misc' " required by xolox/vim-colorscheme-switcher
                    NeoBundle 'xolox/vim-colorscheme-switcher' " use the :RandomColorScheme commands! :D
                    NeoBundle 'baskerville/bubblegum'

                NeoBundle 'Claperius/random-vim' " random number generator
                "NeoBundle 'trusktr/random-vim' " random number generator (my fork)

                " Status Lines
                    "NeoBundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
                    "NeoBundle 'Lokaltog/vim-powerline'
                        "let g:Powerline_symbols='fancy' " Powerline: fancy statusline (patched font)
                    "NeoBundle 'stephenmckinney/vim-solarized-powerline'

                    "NeoBundle 'bling/vim-airline' " SLOW
                        "let g:airline_theme="base16"
                        "let g:airline_left_sep=''
                        "let g:airline_right_sep=''

                        "" disable if using a custom tab plugin like the following gcmt/taboo.vim
                        ""let g:airline#extensions#tabline#enabled = 1
                        ""let g:airline#extensions#tabline#left_sep = ' '
                        ""let g:airline#extensions#tabline#left_alt_sep = ' '

                        ""let g:airline#extensions#syntastic#enabled = 1

                        "let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
                        "let g:airline#extensions#whitespace#show_message = 1
                        "let g:airline#extensions#whitespace#trailing_format = 't%s'
                        "let g:airline#extensions#whitespace#mixed_indent_format = 'm%s'

                    "NeoBundle 'molok/vim-smartusline'
                        "set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

                " Navigation/UI
                    "NeoBundle 'gcmt/taboo.vim'
                        "let g:taboo_tab_format         = " %N:%f%m "
                        "let g:taboo_renamed_tab_format = " %N:\"%l%m\" "

                    NeoBundle 'majutsushi/tagbar'

                " Gutter stuff
                    "NeoBundle 'mhinz/vim-signify'
                        "let g:signify_disable_by_default = 1
                        "let g:signify_cursorhold_normal = 1
                        "let g:signify_cursorhold_insert = 1

                    "NeoBundle 'airblade/vim-gitgutter' " SLOW
                        "let g:gitgutter_realtime = 0
                        "let g:gitgutter_eager = 0

                "NeoBundle 'https://github.com/SirVer/ultisnips.git' " why does this only work with the full url?

                NeoBundle 'maxbrunsfeld/vim-yankstack'
                    nmap <leader>P <Plug>yankstack_substitute_newer_paste
                    nmap <leader>p <Plug>yankstack_substitute_older_paste

                NeoBundle 'nathanaelkane/vim-indent-guides' " seems to preform better than Yggdroot/indentLine, but doesn't look as nice.
                    let g:indent_guides_auto_colors = 1
                    let g:indent_guides_color_change_percent = 3
                    let g:indent_guides_guide_size = 1
                    nnoremap <leader>il :IndentLinesToggle<cr>

                "NeoBundle 'Yggdroot/indentLine'
                    "let g:indentLine_faster = 1
                    "let g:indentLine_enabled = 0
                    ""let g:indentLine_char = '.'
                    ""let g:indentLine_first_char='.'
                    "let g:indentLine_showFirstIndentLevel=1

                "NeoBundle 'megaannum/self' " required for megaannum/forms
                "NeoBundle 'megaannum/forms' " Runs a bit slow..
                "NeoBundle 'mfumi/snake.vim'

                " COMPLETION
                    NeoBundle 'SyntaxComplete'
                    NeoBundle 'tomtom/tlib_vim' " required by garbas/vim-snipmate
                    NeoBundle 'marcweber/vim-addon-mw-utils' " required by garbas/vim-snipmate
                    NeoBundle 'garbas/vim-snipmate'
                    NeoBundle 'honza/vim-snippets'

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

                " JAVASCRIPT
                    NeoBundle 'jelera/vim-javascript-syntax' " works in tandem with pangloss/vim-javascript
                    "NeoBundle 'JavaScript-Indent' " seems to be outdated compared to pangloss/vim-javascript.
                    NeoBundle 'pangloss/vim-javascript' " preferred, works in tandem with jelera/vim-javascript-syntax
                    "NeoBundle 'drslump/vim-syntax-js' " replace various keywords in JavaScript with abbreviations and symbols
                        "set conceallevel=2
                        "set concealcursor=nc  " don't reveal the conceals unless on insert or visual modes
                        "let g:syntax_js=['function', 'return', 'semicolon', 'comma', 'this', 'proto', 'solarized'] " which conceals to enable
                    NeoBundle 'moll/vim-node'
                    "NeoBundle 'walm/jshint.vim' " prefer Syntastic
                    NeoBundle 'jamescarr/snipmate-nodejs' " requires garbas/vim-snipmate, dump the contents of snippets/javascript into the directory ~/.vim/snippets/javascript
                    "NeoBundle 'myhere/vim-nodejs-complete' " use <c-x><c-o> to trigger completion.
                    NeoBundle 'ahayman/vim-nodejs-complete' " use <c-x><c-o> to trigger completion. Fork of myhere's version, more up to date.
                    NeoBundle 'sidorares/node-vim-debugger'

                    " TODO FIXME: messes up the object key because the mapping is recursive?
                    NeoBundle 'kana/vim-textobj-user' " required by kana/vim-textobj-function
                    NeoBundle 'kana/vim-textobj-function' " required by thinca/vim-textobj-function-javascript

                    " Adds a function text object for javascript that selects
                    " everything inside a function, similar to the { object
                    " except you can be in a deeply nested block and still
                    " select the whole function.
                    NeoBundle 'thinca/vim-textobj-function-javascript'

                    "echo "Be sure to install jshint for Syntastic syntax support. npm install -g jshint"

                " COFFESCRIPT
                    NeoBundle 'kchmck/vim-coffee-script'

                " HTML/TEMPLATES/MARKUP
                    "NeoBundle 'mattn/zencoding-vim' " deprecated, use mattn/emmet-vim instead
                    NeoBundle 'mattn/emmet-vim'
                        let g:user_emmet_leader_key='<leader>'
                    NeoBundle 'briancollins/vim-jst'
                    NeoBundle 'jimmyhchan/dustjs.vim'
                    "NeoBundle 'nono/vim-handlebars' " This is deprecated in favor of mustache/vim-mustache-handlebars " SLOW
                    NeoBundle 'mustache/vim-mustache-handlebars' " SLOW
                    NeoBundle 'digitaltoad/vim-jade'
                    NeoBundle 'tpope/vim-markdown'

                " CSS
                    NeoBundle 'hail2u/vim-css3-syntax' " better CSS3 support.
                    NeoBundle 'wavded/vim-stylus' " stylus css
                    NeoBundle 'groenewege/vim-less' " less css support
                    NeoBundle 'tpope/vim-haml' " haml, sass, and scss support

                NeoBundle 'tpope/vim-surround' " surround selections with things like quotes, parens, brakcets, etc.

                "NeoBundle 'sjl/gundo.vim'
                NeoBundle 'mbbill/undotree'
                    let g:undotree_TreeNodeShape = '•'
                    nnoremap <leader>u :UndotreeToggle<cr>

                NeoBundle 'wesQ3/vim-windowswap' " easily swap window splits.
                NeoBundle 'MattesGroeger/vim-bookmarks' " nice (annotated) bookmarks in your gutter.

                " A bunch of filetype plugins. Put NerdCommenter after this to
                " give prefernce to those shortcuts, otherwise this overrides
                " many of them.
                "NeoBundle 'WolfgangMehner/vim-plugins'
                " ^^^ TODO: Many mapping conflicts.

                "NeoBundle 'ide'
                " ^^^ Effing amazing. Great idea.
                " TODO: messes up tab switch mapping.

                "NeoBundle 'http://conque.googlecode.com/svn/trunk/', {
                            "\'name': 'conque',
                        "\}

                " Align stuff.
                    NeoBundle 'junegunn/vim-easy-align'
                        xmap <leader>a <Plug>(EasyAlign)
                        let g:easy_align_delimiters = {
                        \     'a': {
                        \         'pattern':       '\<as\>',
                        \         'left_margin':   1,
                        \         'right_margin':  1,
                        \         'stick_to_left': 0
                        \     },
                        \     'f': {
                        \         'pattern':       '\<from\>',
                        \         'left_margin':   1,
                        \         'right_margin':  1,
                        \         'stick_to_left': 0
                        \     }
                        \ }


                    "NeoBundle 'godlygeek/tabular'

                "NeoBundle 'terryma/vim-multiple-cursors'
                    "TODO: Make it work with IJKL. Perhaps using non-recursive mappings will fix it.

                NeoBundle 'guns/xterm-color-table.vim'
                    set cursorline " highlight the current line. Needed for the next plugin to work.

                NeoBundle "CursorLineCurrentWindow"

                " SEARCH AND NAVIGATION
                    "NeoBundle 'kien/ctrlp.vim' " Alternative to wincent/command-t
                        "let g:ctrlp_working_path_mode = 2 " CtrlP: use the nearest ancestor that contains one of these directories or files: .git/ .hg/ .svn/ .bzr/ _darcs/
                        "nnoremap <silent> <leader>sh :h<CR>:CtrlPTag<CR>
                    "NeoBundle 'wincent/command-t' " Alternative to kien/ctrlp.vim, seems to have better matching
                        "let g:CommandTMaxHeight=10
                    "NeoBundle 'L9' " Required for FuzzyFinder
                    "NeoBundle 'FuzzyFinder' " requires L9
                    "NeoBundle 'mileszs/ack.vim' " in-vim replacement for grep.

                NeoBundle 'DrawIt'

                if !(&term == "win32" || $TERM == "cygwin")
                    NeoBundle 'taglist.vim'
                endif

                "NeoBundle 'CmdlineCompl.vim' SEEMS OUTDATED
                "NeoBundle 'hexman.vim'
                NeoBundle 'ZoomWin'

                " For creating text-based-ui menus in vim:
                "NeoBundle 'svn://svn.code.sf.net/p/vimuiex/code/trunk', {
                            "\'name': 'vxlib',
                            "\'rtp': 'runtime/vxlib/'
                        "\}
                "NeoBundle 'svn://svn.code.sf.net/p/vimuiex/code/trunk', {
                            "\'name': 'vimuiex',
                            "\'rtp': 'runtime/vimuiex/'
                        "\}

                " When enabled preserves line endings, otherwise vim always adds a newline to the end.
                "NeoBundle 'PreserveNoEOL'
                    "let g:PreserveNoEOL = 1

                NeoBundle 'vim-jp/vital.vim' " nice utility functions, including one to make tree objects.

            call neobundle#end()

            " Required:
            filetype plugin indent on

            " If there are uninstalled bundles found on startup,
            " this will conveniently prompt you to install them.
            NeoBundleCheck
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
      set nobackup        " do not keep a backup file, use versions instead
    else
      set backup        " keep a backup file
    endif
    "set history=500        " keep 50 lines of command line history
    set ruler        " show the cursor position all the time
    set showcmd        " display incomplete commands
    set incsearch " do incremental searching

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

      set autoindent        " always set autoindenting on

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
        set expandtab " use spaces instead of tabs
        set tabstop=4
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

            function! InsertStatuslineColor(mode)
                if a:mode == 'i'
                    hi statusline guibg=#ef4d4a guifg=#222222 ctermfg=red
                elseif a:mode == 'r'
                    hi statusline guibg=#4e8dcb guifg=#222222 ctermfg=blue
                else
                    hi statusline guibg=#8a7cf4 guifg=#333333 ctermfg=purple
                endif
            endfunction

            " default statusline color in Normal mode
            au BufEnter * hi statusline guibg=#69bf64 guifg=#222222 ctermfg=green
            au InsertLeave * hi statusline guibg=#69bf64 guifg=#222222 ctermfg=green

            au BufEnter * hi statuslinenc guibg=#222222 guifg=#414141 ctermfg=8
            au BufEnter * hi vertsplit guibg=#222222 guifg=#222222 ctermfg=8
            au BufEnter * hi signcolumn guibg=#252525 ctermfg=8
            au BufEnter * hi linenr guibg=#292929 guifg=#444444 ctermfg=8

            au InsertEnter * call InsertStatuslineColor(v:insertmode)
            au InsertChange * call InsertStatuslineColor(v:insertmode)

        set cursorline " highlight the current line.
        "set cursorcolumn " highlight the current column.
        set virtualedit=block " so we can go one character past the last in normal mode.
        set backspace=indent,eol,start " don't limit backspace to one line. Behaves like a modern editor in this regard.

        set showtabline=2 " 0 never show tab bar, 1 at least two tabs present, 2 always

            " GUI tab labels with tab number, buffer name, number of windows
            function! GuiTabLabel()
                let label = ''
                let bufnrlist = tabpagebuflist(v:lnum)
                " Add '+' if one of the buffers in the tab page is modified
                for bufnr in bufnrlist
                    if getbufvar(bufnr, "&modified")
                        let label = '+'
                        break
                    endif
                endfor
                " Append the tab number
                let label .= v:lnum.': '
                " Append the buffer name
                let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
                if name == ''
                    " give a name to no-name documents
                    if &buftype=='quickfix'
                        let name = '[Quickfix List]'
                    else
                        let name = '[No Name]'
                    endif
                else
                    " get only the file name
                    let name = fnamemodify(name,":t")
                endif
                let label .= name
                " Append the number of windows in the tab page
                let wincount = tabpagewinnr(v:lnum, '$')
                return label . '  [' . wincount . ']'
            endfunction
            set guitablabel=%{GuiTabLabel()}

            function MyTabLine()
                let s = ''
                let t = tabpagenr()
                let i = 1
                while i <= tabpagenr('$')
                    let buflist = tabpagebuflist(i)
                    let winnr = tabpagewinnr(i)
                    let s .= '%' . i . 'T'
                    let s .= (i == t ? '%1*' : '%2*')
                    let s .= ' '
                    let s .= i . ':'
                    "let s .= winnr . '/' . tabpagewinnr(i,'$')
                    let s .= '%*'
                    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
                    let bufnr = buflist[winnr - 1]
                    let file = bufname(bufnr)
                    let buftype = getbufvar(bufnr, 'buftype')
                    if buftype == 'nofile'
                        if file =~ '\/.'
                            let file = substitute(file, '.*\/\ze.', '', '')
                        endif
                    else
                        let file = fnamemodify(file, ':p:t')
                    endif
                    if file == ''
                        let file = 'new'
                    endif
                    let s .= file
                    let i = i + 1
                endwhile
                let s .= '%T%#TabLineFill#%='
                let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
                return s
            endfunction
            set tabline=%!MyTabLine()

        set scrolloff=0 " how many lines to keep before and after the cursor near the top or bottom of the view.
        "tell vim how to represent certain characters. Make the cursor on a tab space appear at the front of the tab space:
            "if !(&term == "win32" || $TERM == "cygwin")
                "set listchars=tab:\ \ ,trail:·
            "else
                set listchars=tab:˒\ ,trail:×,nbsp:·,conceal:¯
            "endif
            set list " enable the above character representation
        set notimeout
        set timeoutlen=1000000 " Really long timeout length for any multikey combos so it seems like there's no timeout, but with some of the benefits of having a timeout. I don't like when partially typed commands dissappear without my permission.
        filetype indent plugin on " enable filetype features.
        set showcmd " display incomplete command. I moved this here from Bram's example because it wasn't working before vundle.
        set history=9999        " how many lines of command line history to keep.
        set pastetoggle=<f12> " Toggle paste mode with <f12> for easy pasting without auto-formatting.
        set hidden " buffers keep their state when a new buffer is opened in the same view.
        set winminheight=0 " Show at least zero lines instead of at least one for horizontal splits.
        set winminwidth=0 " Show at least zero columns instead of at least one for vertical splits.
        set sessionoptions=blank,curdir,folds,help,resize,slash,tabpages,unix,winpos,winsize " :help sessionoptions
        set noequalalways " prevents splitting or closing windows from resizing all other windows.

    " prevent the alternate buffer in Gnome Terminal, etc, so output works
    " like vim's internal :echo command. woo!
    " TODO: Not so clean right now. The output of Git commands is ugly!! Make
    " it nice.
        "let old_t_te = &t_te
        "let old_t_ti = &t_ti
        "autocmd CmdwinEnter * set t_ti= t_te=
        "autocmd CmdwinLeave * let &t_te=old_t_te | let let &t_ti=old_t_ti

    " prevent the cursor from moving one space left after leaving insert.
    " TODO: make this work with <c-o> while in INSERT
        "let CursorColumnI = 0 "the cursor column position in INSERT
        "autocmd InsertEnter * let CursorColumnI = col('.')
        "autocmd CursorMovedI * let CursorColumnI = col('.')
        "autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

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
        " TODO: random colorscheme.
        "let colorschemes = ['zenburn', 'hybrid', 'solarized', 'hemisu', 'seti', '3dglasses']
        "echo 'LENGTH OF ARRAY'
        "echo len(colorschemes)
        "let colorscheme = colorschemes[Random(0, len(colorschemes)-1)]
        "echo colorscheme

        " look and feel (colorscheme, font, etc)
        " FOR ALL ENVIRONMENTS
            set guioptions=acegimrLbtT
        " FOR SPECIFIC ENVIRONMENTS
            if &term == "linux" " 16-color
                " nothing here yet. TODO: Find a good 16-color theme.
            else " 256-color
                "execute "silent! colorscheme ".colorscheme
                if &term == "xterm" || &term == "xterm-256color" || &term == "screen-256color" || &term == "nvim"
                    " make the background color always transparent in xterm
                        "autocmd ColorScheme * highlight normal ctermbg=None
                    set t_Co=256 " enable full color
                    set t_ut= " disable clearing of the background. This is helpful in tmux and screen.
                    set ttymouse=xterm2 " use advanced mouse support even if not in xterm (e.g. if in screen/tmux).

                    "execute "silent! colorscheme hybrid"
                    execute "silent! colorscheme bubblegum"

                    highlight LineNr ctermfg=red
                    highlight MatchParen cterm=bold,underline ctermbg=none ctermfg=green
                    highlight TabLineSel ctermfg=yellow
                    highlight TabLineFill ctermfg=black

                elseif has("gui_running")
                    execute "silent! colorscheme base16-eighties"
                    " customize hybrid a little.
                    highlight Comment guifg=#585858
                    highlight Normal guifg=#999999
                    "highlight TabLine guifg=#333333 guibg=#777777
                    "highlight TabLineSel guifg=#FA7F7F
                    "highlight LineNr guifg=red
                    highlight MatchParen gui=bold guibg=black guifg=limegreen

                    set guioptions-=m  "remove menu bar
                    set guioptions-=T  "remove toolbar
                    set guioptions-=e  "use text-based tabs
                    set guioptions-=b  "remove bottom scrollbar
                    set guioptions-=r  "remove right-hand scroll bar
                    set guioptions-=L  "remove left-hand scroll bar

                    if has("gui_gtk2")
                        silent! set guifont=Ubuntu\ Mono\ for\ Powerline\ 13
                    elseif has("gui_win32")
                        silent! set guifont=Consolas:h11:cANSI
                    else
                        silent! set guifont=courier
                    endif

                    silent! set macmeta
                    " TODO: ^^^ add detection of macvim.
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

        " MOVEMENT {
            " make uhjk like arrow keys and move undo to l.
            " TODO: make sure this is consistent across modes including when
            " waiting for keystroke combinations and when using ctrl for
            " movement like with arrow keys.
            " TODO: Make toggle between new modes and classic mode.
            " TODO: Make this into a plugin.

                " TODO TODO TODO TODO: Map all HJKL to IJKL conversion in one place
                " no-recursively, then use the literal mapping for
                " functionality.
                set langmap=hHjkKi;iIhjJk

                noremap <c-i> <c-k>
                noremap <c-j> <c-h>
                noremap <c-k> <c-j>
                noremap <c-h> <c-i>

                noremap <a-i> <a-k>
                noremap <a-j> <a-h>
                noremap <a-k> <a-j>
                noremap <a-h> <a-i>

                noremap <c-a-i> <c-a-k>
                noremap <c-a-j> <c-a-h>
                noremap <c-a-k> <c-a-j>
                noremap <c-a-h> <c-a-i>

                noremap <c-s-i> <c-s-k>
                noremap <c-s-j> <c-s-h>
                noremap <c-s-k> <c-s-j>
                noremap <c-s-h> <c-s-i>

            " ctrl+direction in NORMAL to move word by word or 10 lines by 10 lines
            " TODO: Move cursor programmatically with a function, not with maps to other keys. It will perform faster.
                map <c-j> <c-left>
                map <c-k> <c-down>
                map <c-i> <c-up>
                map <c-l> <c-right>

                noremap <c-left> b
                noremap <c-down> 10<down>
                noremap <c-up> 10<up>
                noremap <c-right> e

            " ctrl+direction in INSERT to move word by word or 10 lines by 10 lines
                " TODO: remove tab when terminal works properly.
                imap <c-j> <c-left>
                imap <c-k> <c-down>
                imap <c-i> <c-up>
                imap <tab> <c-up>
                imap <c-l> <c-right>

                " TODO: the following doesn't work in terminal.
                imap <c-a-j> <c-left>
                imap <c-a-k> <c-down>
                imap <c-a-i> <c-up>
                imap <c-a-l> <c-right>

                inoremap <c-left> <c-o>b
                inoremap <c-down> <c-o>10<down>
                inoremap <c-up> <c-o>10<up>
                inoremap <c-right> <c-o>e

            " alt+direction in INSERT to move char by char or line by line
                imap j <a-j>
                imap k <a-k>
                imap i <a-i>
                imap l <a-l>

                " Mac OS X
                imap ∆ <a-j>
                imap ˚ <a-k>
                imap ˆ <a-i>
                imap ¬ <a-l>

                imap ê <a-j>
                imap ë <a-k>
                imap é <a-i>
                imap ì <a-l>

                inoremap <a-j> <left>
                inoremap <a-k> <down>
                inoremap <a-i> <up>
                inoremap <a-l> <right>

            "map <s-left> B
            "map <s-right> E

            " natural scrolling for up/down.
                "nnoremap <c-u> <c-d>
                "nnoremap <c-d> <c-u>
        " } MOVEMENT

        " SELECTION
            " Enter VISUAL mode by holding shift+arrows or ctrl+shift+arrows
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

            " proper $ in VISUAL mode, goes to the last char.
                " TODO: handle HJKL vs IJKL
                xnoremap $ g$h

        " deleting with ctrl
            imap <c-bs> <c-w>
            imap <c-h> <c-w>

            " no ctrl+backspace in terminals for now. :(
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

            " highlight all matches of current word, but do not move cursor to
            " the next or previous ocurrence likw * and # do.
                nnoremap <cr> :silent! let searchTerm = '\<'.expand("<cword>").'\>' <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>
            " same thing as above, but highlights the visual selection.
                xnoremap <cr> "*y:silent! let searchTerm = substitute(escape(@*, '\/.*$^~[]'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>

            " ctrl+c to control search highlight. ctrl+c doesn't do anything
            " in normal mode otherwise. Uncomment one of the two lines. The
            " first one only turns off search highlight when it is on, no
            " toggling, but a subsequent search or typing n or N will turn it
            " back on automatically. The second one toggles search highlight
            " on or off, and searching does not automatically turn it back on.
                nnoremap <c-c> :if (&hlsearch == 1) \| set nohlsearch \| else \| set hlsearch \| endif <cr>

            " TODO: turn on highlight after a search.

        " Move line or selection up or down with alt+up/down and indent based
        " on new location.
            " TODO TODO TODO TODO: Map all HJKL to IJKL conversion in one place
            nmap <a-k> <a-down>
            nmap <a-i> <a-up>
            vmap <a-k> <a-down>
            vmap <a-i> <a-up>

            nnoremap <a-down> :m .+1<cr>==
            nnoremap <a-up> :m .-2<cr>==
            " alt+arrows doesn't work in OS X terminals.
            inoremap <a-down> <esc>:m .+1<cr>==gi
            inoremap <a-up> <esc>:m .-2<cr>==gi
            vnoremap <a-down> :m '>+1<cr>gv=gv
            vnoremap <a-up> :m '<-2<cr>gv=gv

        " save with ctrl+s
            "imap <c-s> <c-o>:w<cr>
            noremap <c-s> :w<cr>

        " toggle comments. Requires scrooloose/nerdcommenter plugin.
            let commented = 0
            nnoremap <c-_> :if (commented%2 == 0) \| exe 'normal \<leader>cl' \| else \| exe 'normal \<leader>cu' \| endif \| let commented=commented+1<cr>

        " Reformat current paragraph
            xnoremap Q gq
            nnoremap Q gqap

        " Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
        " which is the default
            nnoremap Y y$

        " Make p paste CUA style like gedit, notepad, etc (e.g. pastes then
        " the cursor is at the end of the paste). Note: Seems to be the
        " default behavior now.
            nnoremap p p`]
            xnoremap p p`]

        " pasteitesp copied line literally, at cursor position. TODO: Strip
        " whitespace.
            nnoremap <leader>p i<c-r>"<c-o>0<bs><c-c>

        " backspace in normal mode.
            "nnoremap <bs> X

        " BUFFER NAVIGATION
            " shift+ctrl+t to open new tabs.
                noremap <c-t> :tabnew<cr>
                "noremap <c-t> :tabnew<cr>:Startify<cr>

            " alt+left/right to move between tabs in normal mode.
                " Why don't the next two work in console?
                " TODO TODO TODO TODO: Map all HJKL to IJKL conversion in one place
                map <a-j> <a-left>
                map <a-l> <a-right>
                map j <a-left>
                map l <a-right>
                nnoremap <a-left> gT
                nnoremap <a-right> gt

            " quick buffer switching
                nnoremap <leader>b :buffers<cr>:b<space>

            " TODO TODO TODO TODO: Map all HJKL to IJKL conversion in one place
            " HJKL to IJKL window commands.
                nnoremap <c-w>i <c-w>k
                nnoremap <c-w>k <c-w>j
                nnoremap <c-w>j <c-w>h
                nnoremap <c-w>h <c-w>i

                nnoremap <c-w><c-i> <c-w><c-k>
                nnoremap <c-w><c-k> <c-w><c-j>
                nnoremap <c-w><c-j> <c-w><c-h>
                nnoremap <c-w><c-h> <c-w><c-i>

                nnoremap <c-w>I <c-w>K
                nnoremap <c-w>K <c-w>J
                nnoremap <c-w>J <c-w>H
                nnoremap <c-w>H <c-w>I

            " easier split window switching.

                " TODO FIXME: ctrl+shift doesn't work in MacVim, so using ctrl+alt for now.
                "nnoremap <c-s-j> <c-w>h
                "nnoremap <c-s-k> <c-w>j
                "nnoremap <c-s-i> <c-w>k
                "nnoremap <c-s-l> <c-w>l
                nnoremap <c-a-j> <c-w>h
                nnoremap <c-a-k> <c-w>j
                nnoremap <c-a-i> <c-w>k
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

        " Beautify json.
            command JsonFormat %!python -m json.tool

        " Delete all hidden buffers.
        function! DeleteInactiveBufs()
            "From tabpagebuflist() help, get a list of all buffers in all tabs
            let tablist = []
            for i in range(tabpagenr('$'))
                call extend(tablist, tabpagebuflist(i + 1))
            endfor

            "Below originally inspired by Hara Krishna Dara and Keith Roberts
            "http://tech.groups.yahoo.com/group/vim/message/56425
            let nWipeouts = 0
            for i in range(1, bufnr('$'))
                if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
                "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
                    silent exec 'bwipeout' i
                    let nWipeouts = nWipeouts + 1
                endif
            endfor
            echomsg nWipeouts . ' buffer(s) wiped out'
        endfunction
        command BuffDeleteHidden :call DeleteInactiveBufs()

    " END COMMAND MAPS AND SPECIAL FUNCTION MAPS:

" END CUSTOM SETTINGS:
