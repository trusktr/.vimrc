" NOTE: You'll need to find and replace file separators if running in a
" non-unix environment (e.g. DOS).

" TODO: Make a FileSeparator variable to handle each OS.


scriptencoding utf-8 " make sure we use utf-8 before doing anything.
"behave mswin " awesome (but horrible name choice. "behave cua" would be nicer. I dislike Windows.) Treats the cursor like an I beam when selecting text instead of a block, and if you have a block the I beam is basically the left edge of the block.
let loaded_matchit = 1
runtime! macros/matchit.vim " enabled awesome match abilities like HTML tag matching with %
    " TODO: Fix ugly reposition of view during match.

set nocompatible " be iMproved

let s:VIMROOT = $HOME."/.vim"
let &runtimepath=s:VIMROOT."," . &runtimepath

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

" BEGIN PLUGIN_MANAGEMENT {
" if the ".s:VIMROOT."/bundle/ directory exists.
if glob(s:VIMROOT."/bundle/") != ""

    if glob(s:VIMROOT."/bundle/vim-plug/") == "" " if Plug doesn't exist
        if (match(system('which git'), "git not found") == -1) " if git is installed
            echo "Setting up plugin manager..."
            silent! execute "cd ".s:VIMROOT."/bundle/"
            silent! execute "!echo && git clone https://github.com/junegunn/vim-plug.git"
            if glob(s:VIMROOT."/bundle/vim-plug/") == "" " if Plug still doesn't exist
                echo "Error: Unable to set up the plugin manager. Something went wrong (maybe git failed or a connection problem). Restart Vim to try again or clone https://github.com/junegunn/vim-plug.git into ~/.vim/bundle manually."
            endif
        else
            echo "Tip: Install Git then restart Vim for plugin management. See Plug for details: https://github.com/junegunn/vim-plug"
        endif
    endif

    if glob(s:VIMROOT."/bundle/vim-plug/") != "" " if Plug exists
        " BEGIN PLUGIN MANAGEMENT:
            if has('vim_starting')
                let &runtimepath=s:VIMROOT."/bundle/vim-plug," . &runtimepath
                runtime plug.vim
            endif

            call plug#begin(expand(s:VIMROOT.'/bundle')) " put stuff in the bundle folder.

                Plug 'junegunn/vim-plug' " let Plug update itself.

                "Plug 'yuratomo/gmail.vim'
                   "silent! source `=s:VIMROOT."/.gmail"` " Source login info

                "Plug 'scrooloose/syntastic' " All purpose syntax checking " SLOW
                    "let g:syntastic_check_on_open        = 0
                    "let g:syntastic_check_on_wq          = 0
                    "let g:syntastic_auto_jump            = 2
                    ""let g:syntastic_auto_loc_list        = 1
                    "let g:syntastic_mode_map             = { 'mode': 'passive' }
                    ""let g:syntastic_error_symbol         = 'E'
                    "let g:syntastic_error_symbol         = "✖"
                    "let g:syntastic_style_error_symbol   = 'e'
                    ""let g:syntastic_warning_symbol       = 'W'
                    "let g:syntastic_warning_symbol       = "∇"
                    "let g:syntastic_style_warning_symbol = 'w'

                Plug 'benekastah/neomake' " Makers for various file types. TODO: auto install tool (jshint, eslint).

                    " jshint config
                    "let g:neomake_javascript_enabled_makers = ['jshint']
                    "let g:neomake_javascript_jshint_maker = {
                        "\ 'args': ['--verbose'],
                        "\ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)'
                        "\ }

                    " eslint config
                    let g:neomake_javascript_enabled_makers = ['eslint']

                    let g:neomake_error_sign = {
                        \ 'text': '✖',
                        \ 'texthl': 'ErrorMsg',
                        \ }
                    let g:neomake_warning_sign = {
                        \ 'text': '∇',
                        \ 'texthl': 'WarningMsg',
                        \ }

                    autocmd FileType javascript :autocmd BufWritePost <buffer> :silent Neomake

                Plug 'scrooloose/nerdcommenter'

                " COLORSCHEMES
                " TODO: Mark which ones support term, gui, or both.
                    Plug 'w0ng/vim-hybrid'
                    Plug 'trusktr/seti.vim'
                    "Plug 'daylerees/colour-schemes', { 'rtp': 'vim', }
                    "Plug 'djjcast/mirodark'
                    "Plug 'nicholasc/vim-seti' // doesn't work in terminal
                    "Plug 'noahfrederick/vim-hemisu'
                    "Plug 'altercation/vim-colors-solarized'
                        "let g:solarized_termcolors=256
                    "Plug 'jonathanfilip/vim-lucius'
                    "Plug 'jnurmine/Zenburn'
                    "Plug 'adlawson/vim-sorcerer'
                    "Plug 'zeis/vim-kolor'
                    "Plug 'jordwalke/flatlandia'
                    "Plug 'antlypls/vim-colors-codeschool'
                    "Plug 'morhetz/gruvbox'
                        "" disable gruvbox italics, which causes line colors to be inverted
                        "if !has("gui_running")
                            "let g:gruvbox_italic=0
                        "endif
                        "silent !~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh " enable this for terminal support if you're using gruvbox in Mac OS X iterm2.
                        "silent !~/.vim/bundle/gruvbox/gruvbox_256palette.sh     " enable this for terminal support if you're using gruvbox in 256-colore linux terminal.
                    "Plug '3DGlasses.vim'
                    "Plug 'goatslacker/mango.vim'
                    "Plug 'jasonlong/lavalamp', {
                        "\ 'rtp': 'vim',
                        "\ 'build' : {
                        "\     'mac':   'mkdir ./vim/colors && cp -f ./vim/lavalamp.vim ./vim/colors/lavalamp.vim',
                        "\     'unix':  'mkdir ./vim/colors && cp -f ./vim/lavalamp.vim ./vim/colors/lavalamp.vim',
                        "\     'linux': 'mkdir ./vim/colors && cp -f ./vim/lavalamp.vim ./vim/colors/lavalamp.vim'
                        "\    }
                        "\ }
                    "Plug 'nanotech/jellybeans.vim'
                    Plug 'chriskempson/base16-vim'
                    "Plug 'xolox/vim-misc' " required by xolox/vim-colorscheme-switcher
                    "Plug 'xolox/vim-colorscheme-switcher' " use the :RandomColorScheme commands! :D
                    "Plug 'baskerville/bubblegum'

                " Other Theming
                    Plug 'blueyed/vim-diminactive'
                        let g:diminactive_use_colorcolumn = 1

                Plug 'Claperius/random-vim' " random number generator
                "Plug 'trusktr/random-vim' " random number generator (my fork)

                " STATUS LINES

                    " requires python powerline package and config
                    "Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
                    "Plug 'Lokaltog/vim-powerline'
                        "let g:Powerline_symbols='fancy' " Powerline: fancy statusline (patched font)
                        "let g:powerline_pycmd='py3'
                        "Plug 'stephenmckinney/vim-solarized-powerline'

                    "can be slow
                    "Plug 'vim-airline/vim-airline'
                        "Plug 'vim-airline/vim-airline-themes'
                        let g:airline_detect_modified = 1
                        let g:airline_detect_paste = 1
                        let g:airline_detect_crypt = 0
                        let g:airline_detect_spell = 0
                        let g:airline_inactive_collapse = 0
                        let g:airline_skip_empty_sections = 1
                        let g:airline_theme='tomorrow'
                        let g:airline_theme_patch_func = 'AirlineThemePatch'
                        function! AirlineThemePatch(palette)
                            if g:airline_theme == 'tomorrow'
                                for colors in values(a:palette.inactive)
                                    let colors[2] = 245 " lighten the inactive foreground.
                                endfor
                            endif
                        endfunction

                        if !exists('g:airline_symbols')
                            let g:airline_symbols = {}
                        endif
                        let g:airline_left_sep = ''
                        let g:airline_right_sep = ''
                        "let g:airline_left_sep = '▶'
                        "let g:airline_right_sep = '◀'
                        let g:airline_symbols.branch = '⎇'
                        let g:airline_symbols.linenr = '#'
                        let g:airline_symbols.crypt = '🔒'
                        let g:airline_symbols.whitespace = ''

                        "let g:airline_extensions = []
                        let g:airline#extensions#disable_rtp_load = 1
                        " disable if using a custom tab plugin like the following gcmt/taboo.vim

                        let g:airline#extensions#tabline#enabled = 0
                        let g:airline#extensions#tabline#left_sep = ''
                        let g:airline#extensions#tabline#left_alt_sep = ''
                        let g:airline#extensions#tabline#show_splits = 0
                        let g:airline#extensions#tabline#show_buffers = 0
                        let g:airline#extensions#tabline#show_tab_nr = 1
                        let g:airline#extensions#tabline#tab_nr_type = 1
                        let g:airline#extensions#tabline#show_tab_type = 1
                        let g:airline#extensions#tabline#buffer_nr_format = '%s:'
                        let g:airline#extensions#tabline#formatter = 'trusktr'
                        let g:airline#extensions#tabline#tab_min_count = 1
                        let g:airline#extensions#tabline#close_symbol = '✖'

                        let g:airline#extensions#bufferline#enabled = 0
                        let g:airline#extensions#syntastic#enabled = 0

                        let g:airline#extensions#hunks#enabled = 1
                        let g:airline#extensions#hunks#non_zero_only = 1

                        let g:airline#extensions#branch#enabled = 1
                        let g:airline#extensions#branch#empty_message = '-'

                        let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
                        let g:airline#extensions#whitespace#show_message = 1
                        let g:airline#extensions#whitespace#long_format = 'l %s'
                        let g:airline#extensions#whitespace#mixed_indent_file_format = 'mif %s'
                        let g:airline#extensions#whitespace#trailing_format = '× %s'
                        let g:airline#extensions#whitespace#mixed_indent_format = 'mi %s'

                        let g:airline#extensions#default#layout = [
                            \ [ 'a', 'b', 'c' ],
                            \ [ 'z', '-y', '-x', 'error', 'warning' ]
                        \ ]
                            "\ [ 'c', 'b', 'a' ],

                    "Plug 'molok/vim-smartusline' " broken in neovim? Doesn't restore NORMAL color after leaving INSERT.
                        "set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

                    Plug 'itchyny/lightline.vim'
                        let g:lightline = {
                              \ 'enable': {
                              \   'statusline': 1,
                              \   'tabline': 0,
                              \ },
                              \ 'active': {
                              \   'left': [
                              \       [ 'mode', 'paste' ],
                              \       [ 'filename', 'readonly', 'modified' ],
                              \       [ 'fugitive', ],
                              \   ]
                              \ },
                              \ 'inactive': {
                              \   'left': [
                              \       [ 'filename', 'readonly', 'modified' ],
                              \       [ ],
                              \   ]
                              \ },
                              \ 'component': {
                              \   'readonly': '%{&readonly?"x":""}',
                              \   'fugitive': '%{winwidth(0) > 70 ? (exists("*fugitive#head") ? "⎇  " . fugitive#head() : "") : ""}',
                              \   'filetype': '%{winwidth(0) > 70 ? (&filetype !=# "" ? &filetype : "no ft") : ""}',
                              \   'fileencoding': '%{winwidth(0) > 70 ? (&fenc !=# "" ? &fenc : &enc) : ""}',
                              \   'fileformat': '%{winwidth(0) > 70 ? &fileformat : ""}',
                              \ },
                              \ 'component_visible_condition': {
                              \   'fugitive': '(exists("*fugitive#head") && winwidth(0) > 70 && ""!=fugitive#head())',
                              \   'filetype': '(winwidth(0) > 70)',
                              \   'fileencoding': '(winwidth(0) > 70)',
                              \   'fileformat': '(winwidth(0) > 70)',
                              \ },
                              \ 'separator': { 'left': '', 'right': '' },
                              \ 'subseparator': { 'left': '|', 'right': '|' }
                          \ }

                    " CUSTOM STATUS LINE
                        set laststatus=2               " Always show a status line
                        set noshowmode
                        function! SetupCustomStatusline()
                            " TODO: make a better status line.
                            set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l\ of\ %L] " custom status line. Not needed if using powerline or airline.

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
                            au BufEnter * hi statuslinenc guibg=#222222 guifg=#414141 ctermfg=8

                            au InsertEnter * call InsertStatuslineColor(v:insertmode)
                            au InsertChange * call InsertStatuslineColor(v:insertmode)

                            " doesn't work in NeoVim 0.1.2
                            au InsertLeave * hi statusline guibg=#69bf64 guifg=#222222 ctermfg=green
                            " workaround:
                            au CursorMoved * hi statusline guibg=#69bf64 guifg=#222222 ctermfg=green

                            " Update the status line immediately when leaving INSERT or VISUAL mode by
                            " pressing <esc>
                                "if ! has('gui_running')
                                "    set ttimeoutlen=10 " XXX: Does this interfere with timeoutlen? Why do we need this?
                                "    augroup FastEscape
                                "        autocmd!
                                "        au InsertEnter * set timeout | set timeoutlen=10000
                                "        au InsertLeave * set timeoutlen=10000 | set notimeout
                                "        " TODO: Make this work with VISUAL also. No VisualEnter/Leave
                                "        " autocmds though. :(
                                "        "au VisualEnter * set timeout | set timeoutlen=0
                                "        "au VisualLeave * set timeoutlen=10000 | set timeout
                                "    augroup END
                                "endif
                        endfunction
                        function! SetupCustomStatusline2()
                            "set statusline=
                            "set statusline +=%1*\ %n\ %*            "buffer number
                            "set statusline +=%5*%{&ff}%*            "file format
                            "set statusline +=%3*%y%*                "file type
                            "set statusline +=%4*\ %<%F%*            "full path
                            "set statusline +=%2*%m%*                "modified flag
                            "set statusline +=%1*%=%5l%*             "current line
                            "set statusline +=%2*/%L%*               "total lines
                            "set statusline +=%1*%4v\ %*             "virtual column number
                            "set statusline +=%2*0x%04B\ %*          "character under cursor
                            "hi User1 guifg=#eea040 guibg=#222222
                            "hi User2 guifg=#dd3333 guibg=#222222
                            "hi User3 guifg=#ff66ff guibg=#222222
                            "hi User4 guifg=#a0ee40 guibg=#222222
                            "hi User5 guifg=#eeee40 guibg=#222222
                            set statusline=
                            set statusline+=%7*\[%n]                                  "buffernr
                            set statusline+=%1*\ %<%F\                                "File+path
                            set statusline+=%2*\ %y\                                  "FileType
                            set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
                            set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
                            set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
                            set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
                            set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
                            set statusline+=%9*\ col:%03c\                            "Colnr
                            set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
                            function! HighlightSearch()
                              if &hls
                                return 'H'
                              else
                                return ''
                              endif
                            endfunction
                            hi User1 guifg=#ffdad8  guibg=#880c0e
                            hi User2 guifg=#000000  guibg=#F4905C
                            hi User3 guifg=#292b00  guibg=#f4f597
                            hi User4 guifg=#112605  guibg=#aefe7B
                            hi User5 guifg=#051d00  guibg=#7dcc7d
                            hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
                            hi User8 guifg=#ffffff  guibg=#5b7fbb
                            hi User9 guifg=#ffffff  guibg=#810085
                            hi User0 guifg=#ffffff  guibg=#094afe
                        endfunction
                        "call SetupCustomStatusline()
                        "call SetupCustomStatusline2()

                        " mode aware cursors (in GUI)
                        set gcr=a:block
                        set gcr+=o:hor50-Cursor
                        set gcr+=n:Cursor
                        set gcr+=i-ci-sm:InsertCursor
                        set gcr+=r-cr:ReplaceCursor-hor20
                        set gcr+=c:CommandCursor
                        set gcr+=v-ve:VisualCursor
                        set gcr+=a:blinkon0
                        hi InsertCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=37  guibg=#2aa198
                        hi VisualCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#d33682
                        hi ReplaceCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#dc322f
                        hi CommandCursor ctermfg=15 guifg=#fdf6e3 ctermbg=166 guibg=#cb4b16

                " Navigation/UI
                    "Plug 'ZoomWin' "seems to be broken.
                    Plug 'zoomwintab.vim' " this one works.

                    "Plug 'gcmt/taboo.vim'
                        "let g:taboo_tab_format         = " %N:%f%m "
                        "let g:taboo_renamed_tab_format = " %N:\"%l%m\" "

                    Plug 'mhinz/vim-startify' ", { 'on': ['Startify', 'SSave', 'SLoad'] }
                       let g:startify_files_number = 10
                       let g:startify_update_oldfiles = 1
                       let g:startify_session_autoload = 0
                       let g:startify_session_persistence = 1
                       let g:startify_change_to_vcs_root = 1
                       let g:startify_padding_left = 3
                       let g:startify_list_order = [
                           \ ['   Commands'], 'commands',
                           \ ['   Sessions'], 'sessions',
                           \ ['   MRU Files'], 'files',
                           \ ['   MRU Files in Current Dir'], 'dir',
                           \ ['   Bookmarks'], 'bookmarks',
                       \ ]
                       let g:startify_session_dir = s:VIMROOT.'/session'
                       let g:startify_session_sort = 1
                       let g:startify_session_number = 5
                       let g:startify_session_before_save = [
                           \ 'echo "Cleaning up before saving.."',
                           \ 'call NERDTreeCloseAll()',
                       \ ]

                    Plug 'Lokaltog/vim-easymotion'

                    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
                        nnoremap <leader>f :NERDTreeToggle<cr>
                        " quit when NERDTree is the only buffer.
                        "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
                        function! NERDTreeIsOpen()
                            if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
                                return 1
                            else
                                return 0
                            endif
                        endfunction
                        function! NERDTreeCloseAll()
                            silent! Tabdo if NERDTreeIsOpen() | NERDTreeClose | endif
                        endfunction

                    "Plug 'mbbill/VimExplorer'

                    " requires exuberant ctags.
                    "Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
                        "nnoremap <leader>t :TagbarToggle<cr>

                    " FUZZY FINDING
                        "Plug 'kien/ctrlp.vim' " Alternative to wincent/command-t
                            "let g:ctrlp_working_path_mode = 2 " CtrlP: use the nearest ancestor that contains one of these directories or files: .git/ .hg/ .svn/ .bzr/ _darcs/
                            "nnoremap <silent> <leader>sh :h<CR>:CtrlPTag<CR>
                        "Plug 'wincent/command-t' " Alternative to kien/ctrlp.vim, seems to have better matching
                            "let g:CommandTMaxHeight=10
                        "Plug 'L9' " Required for FuzzyFinder
                        "Plug 'FuzzyFinder' " requires L9
                        "Plug 'mileszs/ack.vim' " in-vim replacement for grep.

                        Plug 'junegunn/fzf', { 'do': './install --all' }
                        Plug 'junegunn/fzf.vim'
                            map <leader><space> :Files<cr>
                            let g:fzf_action = {
                                \ 'ctrl-t': 'tab split',
                                \ 'ctrl-s': 'split',
                                \ 'ctrl-v': 'vsplit' }
                            " - down / up / left / right
                            let g:fzf_layout = { 'down': '~25%' }

                        " Fzf seems cleaner and faster, and exists for zsh too.
                        if ((has('nvim') || v:version > 799) && has('python3')) " for neovim or vim 8.0+
                            Plug 'Shougo/denite.nvim' " async version of unite.vim
                        else
                            Plug 'Shougo/unite.vim'
                        endif


                    Plug 'wesQ3/vim-windowswap' " easily swap window splits.

                    " BOOKMARKS
                        " nice (annotated) bookmarks in your gutter. Makes loading
                        " a session noticeably slow at the moment:
                        " https://github.com/MattesGroeger/vim-bookmarks/issues/111
                        "Plug 'MattesGroeger/vim-bookmarks'

                        " show and navigate bookmarks in the gutter.
                        Plug 'kshenoy/vim-signature'
                            " Similar mappings as vim-bookmarks (non-recursive
                            " so it triggers vim-signature's mappings).
                            nmap mm m3
                            nmap mn ]-
                            nmap mp [-
                            let g:SignatureMap = {
                                \ 'GotoNextSpotAlpha'  :  "",
                                \ 'GotoPrevSpotAlpha'  :  "",
                            \ }


                " GIT
                    Plug 'tpope/vim-fugitive'

                    "Plug 'mhinz/vim-signify'
                        "let g:signify_disable_by_default = 1
                        "let g:signify_cursorhold_normal = 1
                        "let g:signify_cursorhold_insert = 1

                    Plug 'airblade/vim-gitgutter' ", { 'on': 'GitGutterToggle' }
                        nnoremap <leader>gg :GitGutterToggle<cr>
                        nnoremap <leader>gn :GitGutterNextHunk<cr>
                        nnoremap <leader>gp :GitGutterPrevHunk<cr>
                        let g:gitgutter_realtime = 0
                        let g:gitgutter_eager = 0

                "Plug 'https://github.com/SirVer/ultisnips.git' " why does this only work with the full url?

                " Keep a stack of yanks (ctrl+p and ctrl+n to switch to previous or next yank)
                    "Plug 'vim-scripts/YankRing.vim' " seems to conflict with the unnamedplus clipboard setting. I'm using Gnome Clipboard stack extension anyways.
                        "nnoremap <leader>yr :YRShow<cr>
                    "Plug 'maxbrunsfeld/vim-yankstack'
                        "nmap <c-n> <Plug>yankstack_substitute_newer_paste
                        "nmap <c-p> <Plug>yankstack_substitute_older_paste
                    "Plug 'svermeulen/vim-easyclip' " ctrl+p/n not working.
                    if has('nvim')
                        "Plug 'bfredl/nvim-miniyank'
                            "map p <plug>(miniyank-autoput)
                            "map P <plug>(miniyank-autoPut)
                            "map <c-p> <plug>(miniyank-cycle)
                        "Plug 'machakann/vim-highlightedyank'
                            "if !has('nvim')
                                "map y <Plug>(highlightedyank)
                            "endif
                            "let g:highlightedyank_highlight_duration = 100
                            "hi HighlightedyankRegion cterm=reverse gui=reverse
                    endif


                Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentLinesToggle' } " seems to preform better than Yggdroot/indentLine, but doesn't look as nice.
                    let g:indent_guides_auto_colors = 1
                    let g:indent_guides_color_change_percent = 3
                    let g:indent_guides_guide_size = 1
                    nnoremap <leader>l :IndentLinesToggle<cr>

                "Plug 'Yggdroot/indentLine'
                    "let g:indentLine_faster = 1
                    "let g:indentLine_enabled = 0
                    ""let g:indentLine_char = '.'
                    ""let g:indentLine_first_char='.'
                    "let g:indentLine_showFirstIndentLevel=1

                "Plug 'megaannum/self' " required for megaannum/forms
                "Plug 'megaannum/forms' " Runs a bit slow..
                "Plug 'mfumi/snake.vim'

                " COMPLETION
                    Plug 'SyntaxComplete'
                    Plug 'tomtom/tlib_vim' " required by garbas/vim-snipmate
                    Plug 'marcweber/vim-addon-mw-utils' " required by garbas/vim-snipmate
                    Plug 'garbas/vim-snipmate'
                    Plug 'honza/vim-snippets'

                    if has('nvim')
                        if !has('python3') && match(system('which pip3'), "pip3 not found") == -1
                            call system('pip3 install neovim')
                        endif

                        if has('python3')
                            Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " neovim with python support only
                                let g:deoplete#enable_at_startup = 1
                        endif
                    endif


                    " bracket completion
                        "Plug 'cohama/lexima.vim' " Same as delimitMate, but also completes unclosed brakcets when pressing enter for new line.
                        "Plug 'Raimondi/delimitMate'
                            "let delimitMate_expand_cr = 2
                            "let delimitMate_expand_space = 1
                        "Plug 'Townk/vim-autoclose' " No dot redo support
                        "Plug 'jiangmiao/auto-pairs' " No dot redo support

                        " complements bracket completion
                        Plug 'tpope/vim-surround' " surround selections with things like quotes, parens, brakcets, etc.

                    "" TODO: YouCompleteMe, make function for Plug.
                    "if has("unix")
                    "    " make sure you have cmake and python installed (and python support in vim). Add/remove the install command arguments as necessary. You need to have clang installed if you use the --system-libclang flag; if you don't use the flag the installer will download the binary from llvm.org. see YCM docs.
                    "    Plug 'Valloric/YouCompleteMe', {
                    "         \ 'build' : {
                    "         \     'mac' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
                    "         \     'unix' : './install.sh --clang-completer --system-libclang --omnisharp-completer'
                    "         \    }
                    "         \ }
                    "else
                    "    if has("win32")
                    "        " Windows user: have fun, good luck, or both. ;)
                    "        " TODO: See here for starters on installing for Windows: http://stackoverflow.com/questions/18801354/c-family-semantic-autocompletion-plugins-for-vim-using-clang-clang-complete-yo
                    "        Plug 'Valloric/YouCompleteMe', {
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
                    "Plug 'JavaScript-Indent' " outdated compared to pangloss/vim-javascript (prefer that).

                    " The following syntax plugins all work together. The order they are specified might affect the outcome a
                    " little (highlight colors could vary, etc, similar to cascading style sheets).
                    Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' } " works in tandem with pangloss/vim-javascript
                    Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' } " supports latest language features.
                    Plug 'othree/yajs.vim', { 'for': 'javascript' } " JavaScript syntax plugin
                    Plug 'pangloss/vim-javascript', { 'for': 'javascript' } " preferred, works in tandem with jelera/vim-javascript-syntax

                    " Tern is slow. It will be loaded when the commands are
                    " first executed instead of at the beginning. XXX Why
                    " doesn't the "on" setting work?
                    Plug 'ternjs/tern_for_vim', {
                    \    'do': 'npm install',
                    \    'on': [
                    \        'TernDef',
                    \        'TernDefPreview',
                    \        'TernDefSplit',
                    \        'TernDefTab',
                    \        'TernDoc',
                    \        'TernDocBrowse',
                    \        'TernRefs',
                    \        'TernRename',
                    \        'TernType'
                    \    ]
                    \}

                    "Plug 'drslump/vim-syntax-js' " replace various keywords in JavaScript with abbreviations and symbols
                        "set conceallevel=2
                        "set concealcursor=nc  " don't reveal the conceals unless on insert or visual modes
                        "let g:syntax_js=['function', 'return', 'semicolon', 'comma', 'this', 'proto', 'solarized'] " which conceals to enable
                    Plug 'moll/vim-node', { 'for': 'javascript' }
                    "Plug 'walm/jshint.vim' " prefer NeoMake with added jshint config.
                    Plug 'jamescarr/snipmate-nodejs', { 'for': 'javascript' } " requires garbas/vim-snipmate, dump the contents of snippets/javascript into the directory ~/.vim/snippets/javascript
                    "Plug 'myhere/vim-nodejs-complete' " use <c-x><c-o> to trigger completion.
                    "Plug 'ahayman/vim-nodejs-complete', { 'for': 'javascript' } " use <c-x><c-o> to trigger completion. Fork of myhere's version, more up to date.
                        " XXX ^ This causes some files to crash and never open.
                    Plug 'sidorares/node-vim-debugger', { 'for': 'javascript' }

                    " Adds a function text object for javascript that selects
                    " everything inside a function, similar to the { object
                    " except you can be in a deeply nested block and still
                    " select the whole function.

                        " TODO FIXME: messes up the object key because the mapping is recursive?
                        "Plug 'kana/vim-textobj-user', { 'for': 'javascript' } " required by kana/vim-textobj-function
                        "Plug 'kana/vim-textobj-function', { 'for': 'javascript' } " required by thinca/vim-textobj-function-javascript

                        "Plug 'thinca/vim-textobj-function-javascript', { 'for': 'javascript' }

                    " Use the same js beautifier from jsbeautifier.org
                    Plug 'maksimr/vim-jsbeautify', { 'on': 'JsBeautify' }
                        command JsBeautify call JsBeautify()

                    " Syntax highlight stuff inside JS template strings.
                    Plug 'Quramy/vim-js-pretty-template', { 'for': 'javascript' }

                " JSX
                    "Plug 'jsx/jsx.vim', { 'for': 'javascript.jsx' }
                    Plug 'mxw/vim-jsx', { 'for': 'javascript.jsx' }

                " COFFEESCRIPT
                    Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

                " TYPESCRIPT
                    Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

                " QML
                    Plug 'peterhoeg/vim-qml'
                    "Plug 'calincru/qml.vim'

                " HTML/TEMPLATES/MARKUP
                    "Plug 'mattn/zencoding-vim' " deprecated, use mattn/emmet-vim instead
                    Plug 'mattn/emmet-vim', { 'for': ['javascript.jsx', 'html'] }
                        let g:user_emmet_leader_key='<leader>'
                    Plug 'briancollins/vim-jst', { 'for': 'html.ejs' }
                    "Plug 'jimmyhchan/dustjs.vim'
                    "Plug 'nono/vim-handlebars' " This is deprecated in favor of mustache/vim-mustache-handlebars " SLOW
                    "Plug 'mustache/vim-mustache-handlebars', { 'for': 'html.handlebars' } " SLOW
                    Plug 'trusktr/vim-mustache-handlebars', { 'for': 'html.handlebars' } " SLOW
                        let g:mustache_abbreviations = 1
                    Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
                    Plug 'tpope/vim-markdown', { 'for': 'markdown' }

                " CSS
                    Plug 'hail2u/vim-css3-syntax', { 'for': 'css' } " better CSS3 support.
                    Plug 'wavded/vim-stylus', { 'for': 'stylus' } " stylus css
                    Plug 'groenewege/vim-less', { 'for': 'less' } " less css support
                    Plug 'tpope/vim-haml', { 'for': ['haml', 'sass', 'scss'] } " haml, sass, and scss support

                "Plug 'sjl/gundo.vim'
                Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
                    let g:undotree_TreeNodeShape = '•'
                    nnoremap <leader>u :UndotreeToggle<cr>

                " A bunch of filetype plugins. Put NerdCommenter after this to
                " give prefernce to those shortcuts, otherwise this overrides
                " many of them.
                "Plug 'WolfgangMehner/vim-plugins'
                " ^^^ TODO: Many mapping conflicts.

                "Plug 'ide'
                " ^^^ Effing amazing. Great idea.
                " TODO: messes up tab switch mapping.

                " Align stuff.
                    Plug 'junegunn/vim-easy-align'
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
                        \     },
                        \     '(': {
                        \         'pattern':       '(',
                        \         'left_margin':   1,
                        \         'right_margin':  0,
                        \         'stick_to_left': 0
                        \     },
                        \     '[': {
                        \         'pattern':       '[',
                        \         'left_margin':   1,
                        \         'right_margin':  0,
                        \         'stick_to_left': 0
                        \     }
                        \ }


                    "Plug 'godlygeek/tabular'

                "Plug 'terryma/vim-multiple-cursors'
                    "TODO: Make it work with IJKL. Perhaps using non-recursive mappings will fix it.

                Plug 'guns/xterm-color-table.vim'

                set cursorline " highlight the current line. Needed for the next plugin to work.
                Plug 'CursorLineCurrentWindow'

                Plug 'DrawIt'

                "if !(&term == "win32" || $TERM == "cygwin")
                    "Plug 'taglist.vim'
                "endif

                "Plug 'CmdlineCompl.vim' SEEMS OUTDATED
                "Plug 'hexman.vim'

                " For creating text-based-ui menus in vim:
                "Plug 'svn://svn.code.sf.net/p/vimuiex/code/trunk', {
                            "\'name': 'vxlib',
                            "\'rtp': 'runtime/vxlib/'
                        "\}
                "Plug 'svn://svn.code.sf.net/p/vimuiex/code/trunk', {
                            "\'name': 'vimuiex',
                            "\'rtp': 'runtime/vimuiex/'
                        "\}

                " When enabled preserves line endings, otherwise vim always adds a newline to the end.
                "Plug 'PreserveNoEOL'
                    "let g:PreserveNoEOL = 1

                Plug 'vim-jp/vital.vim' " nice utility functions, including one to make tree objects.

                "Plug 'kana/vim-gf-user'
                "Plug 'kana/vim-textobj-user'
                "Plug 'kana/vim-smartword'
                "Plug 'kana/vim-textobj-function'

                " TODO: Other plugins to try:
                " - https://rhysd.github.io/#vim-plugin

                Plug 't9md/vim-textmanip'
                    " needs custom shortcuts. Merge with my alt+movement below.

                " Elm
                Plug 'lambdatoast/elm.vim'

                " BEGIN SEARCHING

                    " Shows the index of current the current search match out
                    " of the total matches when navigating with n and N, f.e.
                    " [3/12]
                    Plug 'google/vim-searchindex'

                    " Incremental search
                    set incsearch

                    " less escaping for chars with special meaning.
                    set magic

                    " Set "very magic" for all searches.
                    "Plug 'coot/EnchantedVim'
                        let g:VeryMagic = 0
                        " Turn on all other features.
                        let g:VeryMagicSubstituteNormalise = 1
                        let g:VeryMagicSubstitute = 1
                        let g:VeryMagicGlobal = 1
                        let g:VeryMagicVimGrep = 1
                        let g:VeryMagicSearchArg = 1
                        let g:VeryMagicFunction = 1
                        let g:VeryMagicHelpgrep = 1
                        let g:VeryMagicRange = 1
                        let g:VeryMagicEscapeBackslashesInSearchArg = 1
                        let g:SortEditArgs = 1

                        " If using incsearch:
                        nnoremap / /\v
                        nnoremap ? ?\v
                        "nnoremap :g/ :g/\v " enable if needed
                        vnoremap / /\v
                        vnoremap ? ?\v
                        cnoremap s: s:\v
                        " no-magic searching
                        noremap <leader>/ /\V
                        noremap <leader>? ?\V

                    " highlight all matches of current word, but do not move cursor to
                    " the next or previous ocurrence likw * and # do.
                        "nnoremap <silent> <cr> :let searchTerm = '\v<'.expand("<cword>").'>' <bar> let @/ = searchTerm <bar> echo '/\v'.@/ <bar> call histadd("search", searchTerm) <bar> :call TargetOn()<cr>
                        nnoremap <silent> <cr> :let searchTerm = '\v<'.expand("<cword>").'>' <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>
                    " highlight the visual selection after pressing enter.
                        xnoremap <silent> <cr> "*y:silent! let searchTerm = '\V'.substitute(escape(@*, '\/'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>

                    " ctrl+c to control search highlight. ctrl+c doesn't do anything
                    " in normal mode otherwise. Uncomment one of the two lines. The
                    " first one only turns off search highlight when it is on, no
                    " toggling, but a subsequent search or typing n or N will turn it
                    " back on automatically. The second one toggles search highlight
                    " on or off, and searching does not automatically turn it back on.
                        "set hlsearch " start with highlight on
                        "set cursorcolumn " start with the vertucal cursor column.
                        function! TargetToggle()
                            if(&hlsearch == 1)
                                call TargetOff()
                            else
                                call TargetOn()
                            endif
                        endfunc

                        function! TargetOff()
                            set nohlsearch
                            set nocursorcolumn
                        endfunc

                        function! TargetOn()
                            echo &hlsearch
                            set hlsearch
                            set cursorcolumn
                        endfunc

                        "nnoremap <silent> <c-c> :call TargetToggle()<cr>

                        nnoremap <silent> <c-c> :if (&hlsearch == 1) \| set nohlsearch \| else \| set hlsearch \| endif<cr>

                    " TODO: turn on highlight after a search.
                " END SEARCHING


            call plug#end()

            " Required:
        " END PLUGIN MANAGEMENT:
    endif

endif
" END PLUGIN_MANAGEMENT {


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
      filetype plugin indent on

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
    " TODO: Put everything either in a plugin above, or in a file in the custom
    " folder, sourced below:
        silent! source `=s:VIMROOT."/custom/something.vim"` " Source login info

    " TODO: Put this somewhere!! Skip to the next line with same indentation.
    " Nice.
        "nnore <leader>x :call search('^'.matchstr(getline('.'),'^\s*').'\S','We')<CR>

    " OPTIONS.
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
        set wildmenu " Better commandline tab completion

        " TODO: For some reason, this doesn't apply until I set it manually.
        " Neovim issue: ...
        set wildmode=longest:list,full " Complete longest common string and show the match list, then expand to the first full match

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
        set timeoutlen=10000 " default 1000. This makes vim wait for you to finish a multi-key combo, but with the benefits of having a timeout (if set timeout).
        set ttimeout
        set ttimeoutlen=1000 " default 1000
        filetype indent plugin on " enable filetype features.
        set showcmd " display incomplete command. I moved this here from Bram's example because it wasn't working before vundle.
        set history=9999        " how many lines of command line history to keep.
        set pastetoggle=<f12> " Toggle paste mode with <f12> for easy pasting without auto-formatting.

        set winminheight=0 " Show at least zero lines instead of at least one for horizontal splits.
        set winminwidth=0 " Show at least zero columns instead of at least one for vertical splits.
        set sessionoptions=blank,curdir,folds,help,resize,slash,tabpages,unix,winpos,winsize " :help sessionoptions
        set noequalalways " prevents splitting or closing windows from resizing all other windows.
        set splitbelow " on horizontal split, the new window is below instead of the default on top.
        set splitright " on vertical split, the new window is to the right instead of the default left.
        set clipboard=unnamedplus " Makes vim yank and paste to/from the system clipboard without having to use "* or "+. It's useful if you switch between separate instances of vim, and when you have a system clipboard stack so you can keep find previous clipboard entries. If you don't have a clipboard stack, you might like to disable this and use something like vim-yankstack instead.

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


    " STYLE (look and feel, colorscheme, font, etc)

        " TODO: random colorscheme.
        "let colorschemes = ['zenburn', 'hybrid', 'solarized', 'hemisu', 'seti', '3dglasses']
        "echo 'LENGTH OF ARRAY'
        "echo len(colorschemes)
        "let colorscheme = colorschemes[Random(0, len(colorschemes)-1)]
        "echo colorscheme

        " FOR ALL ENVIRONMENTS
            set guioptions=acegimrLbtT

        " FOR SPECIFIC ENVIRONMENTS
            if &term == "linux" " 16-color
                " nothing here yet. TODO: Find a good 16-color theme.

            else " 256-color

                "execute "silent! colorscheme ".colorscheme

                if &term == "xterm" || &term == "xterm-256color" || &term == "screen-256color" || (&term == "nvim" && !has("gui_running"))

                    " make the background color always transparent in xterm
                        "autocmd ColorScheme * highlight normal ctermbg=None
                    set t_Co=256 " enable full color
                    set t_ut= " disable clearing of the background. This is helpful in tmux and screen.
                    if exists("&ttymouse")
                        set ttymouse=xterm2 " use advanced mouse support even if not in xterm (e.g. if in screen/tmux).
                    endif

                    " Some vim plugins set this, some don't, so lets make sure it exists before setting a color.
                    let g:colors_name = ''

                    set background=dark
                    execute "silent! colorscheme hybrid"
                    "execute "silent! colorscheme solarized"
                    "execute "silent! colorscheme bubblegum-256-dark"

                    " based on bubblegum:
                    if (g:colors_name == 'bubblegum-256-dark')
                        highlight CursorLine ctermfg=NONE
                        highlight MatchParen ctermfg=yellow ctermbg=NONE
                    endif

                    " based on hybrid:
                    if (g:colors_name == 'hybrid')
                        " colors for nicer window focus, using the
                        " vim-diminactive plugin.
                        "highlight Normal ctermfg=250 ctermbg=233 guifg=#c5c8c6 guibg=#1d1f21
                        "set background=dark
                        highlight ColorColumn ctermbg=232 guibg=#282a2e
                        highlight LineNr ctermfg=237 ctermbg=233 guifg=#373b41

                        highlight vertsplit guibg=#222222 guifg=#222222 ctermfg=8
                        highlight signcolumn guibg=#252525 ctermfg=8
                        highlight MatchParen cterm=bold,underline ctermbg=none ctermfg=yellow
                        highlight TabLineSel cterm=bold ctermfg=yellow
                        highlight TabLineFill ctermfg=black
                        highlight TabLine ctermbg=darkgray ctermfg=black
                    endif

                    if &term == "nvim"
                        tnoremap <c-;><c-n> <c-\><c-n>
                    endif

                elseif has("gui_running") " MacVim, Gvim, nvim with gui

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
                        silent! set guifont=courier 13
                    endif

                    silent! set macmeta
                    " TODO: ^^^ add detection of macvim.

                    let g:terminal_color_0  = '#2e3436'
                    let g:terminal_color_1  = '#cc0000'
                    let g:terminal_color_2  = '#4e9a06'
                    let g:terminal_color_3  = '#c4a000'
                    let g:terminal_color_4  = '#3465a4'
                    let g:terminal_color_5  = '#75507b'
                    let g:terminal_color_6  = '#0b939b'
                    let g:terminal_color_7  = '#d3d7cf'
                    let g:terminal_color_8  = '#555753'
                    let g:terminal_color_9  = '#ef2929'
                    let g:terminal_color_10 = '#8ae234'
                    let g:terminal_color_11 = '#fce94f'
                    let g:terminal_color_12 = '#729fcf'
                    let g:terminal_color_13 = '#ad7fa8'
                    let g:terminal_color_14 = '#00f5e9'
                    let g:terminal_color_15 = '#eeeeec'

                    set background=dark
                    execute "silent! colorscheme base16-eighties"
                    " customize hybrid a little.
                    highlight Comment guifg=#585858
                    highlight Normal guifg=#999999
                    "highlight TabLine guifg=#333333 guibg=#777777
                    "highlight TabLineSel guifg=#FA7F7F
                    highlight MatchParen gui=bold guibg=black guifg=limegreen
                endif

            endif

    if &term == "nvim" "TODO: detect terminal UI vs GUI in nvim.
        let g:terminal_scrollback_buffer_size = 100000
    endif

    " BEGIN KEYBINDINGS:

        " edit the yanked file. f.e. yy to copy a line containing a file name,
        " the <leader>e to edit that file.
            noremap <leader>e :e <c-r>"<bs><cr>

        " OS X: command -> control
            map <d-a> <c-a>
            map <d-b> <c-b>
            map <d-c> <c-c>
            map <d-d> <c-d>
            map <d-e> <c-e>
            map <d-f> <c-f>
            map <d-g> <c-g>
            map <d-h> <c-h>
            map <d-i> <c-i>
            map <d-j> <c-j>
            map <d-k> <c-k>
            map <d-l> <c-l>
            map <d-m> <c-m>
            map <d-n> <c-n>
            map <d-o> <c-o>
            map <d-p> <c-p>
            map <d-q> <c-q>
            map <d-r> <c-r>
            map <d-s> <c-s>
            map <d-t> <c-t>
            map <d-u> <c-u>
            map <d-v> <c-v>
            map <d-w> <c-w>
            map <d-x> <c-x>
            map <d-y> <c-y>
            map <d-z> <c-z>

        " prevent me from using arrow keys. Grrrrr.
            map <up> :startinsert<cr>I suck at Vim.
            map <down> :startinsert<cr>I suck at Vim.
            map <left> :startinsert<cr>I suck at Vim.
            map <right> :startinsert<cr>I suck at Vim.
            imap <up> I suck at Vim.
            imap <down> I suck at Vim.
            imap <left> I suck at Vim.
            imap <right> I suck at Vim.

        " MOVEMENT {
            " IJKL like arrow keys. {
                " TODO: make sure this is consistent across modes including when
                " waiting for keystroke combinations and when using ctrl for
                " movement like with arrow keys.
                " TODO: Make toggle between new modes and classic mode.
                " TODO: Make this into a plugin.

                " TODO TODO TODO TODO: Map all HJKL to IJKL conversion in one
                " place no-recursively, then use literal HJKL mappings for all
                " functionality.
                "set langmap=hHjkKi;iIhjJk

                " TODO: We need this if in neovim <0.1.2, or in vim. Somehow
                " detect if langmap works or not?
                    " TODO: file bug about langmap on NeoVim.

                " IJKL: {
                    " when lagmap doesn't work
                        "noremap <c-i> <c-k>
                        "noremap <c-j> <c-h>
                        "noremap <c-k> <c-j>
                        "noremap <c-h> <c-i>

                        "noremap <a-i> <a-k>
                        "noremap <a-j> <a-h>
                        "noremap <a-k> <a-j>
                        "noremap <a-h> <a-i>

                        "noremap <c-a-i> <c-a-k>
                        "noremap <c-a-j> <c-a-h>
                        "noremap <c-a-k> <c-a-j>
                        "noremap <c-a-h> <c-a-i>

                        "noremap <c-s-i> <c-s-k>
                        "noremap <c-s-j> <c-s-h>
                        "noremap <c-s-k> <c-s-j>
                        "noremap <c-s-h> <c-s-i>

                    "when langmap works, nothing to do
                " }
            " }

            " MODIFIER+DIRECTION {

                " ctrl+direction in NORMAL to move word by word or 10 lines by 10 lines
                " TODO: Move cursor programmatically with a function, not with maps to other keys. It will perform faster.

                    " IJKL: {
                        " when langmap doesn't work
                            "map <c-j> <c-left>
                            "map <c-k> <c-down>
                            "map <c-i> <c-up>
                            "map <c-l> <c-right>

                        " when lagmap works

                            " this one doesn't work.
                            map <c-h> <c-left>
                            " workaround. TODO: file bug?
                            nmap <BS> <c-h>
                            xmap <BS> <c-h>

                            " But these work.
                            map <c-j> <c-down>
                            map <c-k> <c-up>
                            map <c-l> <c-right>
                    " }

                    " disabled in favor of switching tabs.
                    "noremap <c-left> b
                    "noremap <c-right> e

                    noremap <c-down> 10<down>
                    noremap <c-up> 10<up>

                " ctrl+direction in INSERT to move word by word or 10 lines by 10 lines

                    " IJKL: {
                        " when langmap doesn't work
                        " TODO: remove tab when terminal works properly.
                        "imap <c-j> <c-left>
                        "imap <c-k> <c-down>
                        "imap <c-i> <c-up>
                        "imap <tab> <c-up>
                        "imap <c-l> <c-right>

                        " when langmap works
                        imap <c-h> <c-left>
                        imap <c-j> <c-down>
                        imap <c-k> <c-up>
                        imap <c-l> <c-right>
                    " }

                    " IJKL: {
                        " when langmap doesn't work
                        " FIXME: the following doesn't work in terminal.
                        "imap <c-a-j> <c-left>
                        "imap <c-a-k> <c-down>
                        "imap <c-a-i> <c-up>
                        "imap <c-a-l> <c-right>

                        " when langmap works
                        imap <c-a-h> <c-left>
                        imap <c-a-j> <c-down>
                        imap <c-a-k> <c-up>
                        imap <c-a-l> <c-right>
                    " }

                    " TODO: move cursor programmatically instead of using <c-o>
                    inoremap <c-left> <c-o>b
                    inoremap <c-down> <c-o>10<down>
                    inoremap <c-up> <c-o>10<up>
                    inoremap <c-right> <c-o>e

                " alt+direction in INSERT to move char by char or line by line
                    " Some environments (terminals) output escape followed by letter instead of alt+letter
                        imap j <a-j>
                        imap k <a-k>
                        imap i <a-i>
                        imap l <a-l>
                        imap h <a-h>

                    " Mac OS X (alt+letters output certain symbols in OS X)
                        imap ∆ <a-j>
                        imap ˚ <a-k>
                        imap ˆ <a-i>
                        imap ¬ <a-l>
                        imap ˙ <a-h>

                        imap ê <a-j>
                        imap ë <a-k>
                        imap é <a-i>
                        imap ì <a-l>
                        " TODO <a-h>

                    " IJKL: {
                        " when langmap doesn't work
                        "inoremap <a-j> <left>
                        "inoremap <a-k> <down>
                        "inoremap <a-i> <up>
                        "inoremap <a-l> <right>

                        " when langmap works
                        inoremap <a-h> <left>
                        inoremap <a-j> <down>
                        inoremap <a-k> <up>
                        inoremap <a-l> <right>
                    " }
            " }

            "map <s-left> B
            "map <s-right> E

            " natural scrolling for up/down.
                "nnoremap <c-u> <c-d>
                "nnoremap <c-d> <c-u>
        " } MOVEMENT

        " SELECTION {
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

            " $ in VISUAL mode goes to the last char, not the newline char.
            " IJKL: {
                " TODO: move cursor programmatically instead of with movement keys, then langmap setting won't matter.

                " when langmap doesn't work
                "xnoremap $ $j

                " when langmap works
                xnoremap $ $h
            " }
        " } SELECTION

        " backspace/delete with ctrl
        " no ctrl+backspace/delete in terminals for now. :(
            imap <c-bs> <c-w>
            "imap <c-h> <c-w>

            imap <c-del> <c-o>de
            imap [3;5~ <c-o>de

        " smart home key.
            nmap <expr> <home> search('^\s\+\%#', 'n') ? '0' : '_'
            vmap <expr> <home> search('^\s\+\%#', 'n') ? '0' : '_'
            vmap <expr> <s-home> search('^\s\+\%#', 'n') ? '0' : '_'
            imap <expr> <home> search('^\s\+\%#', 'n') ? '<c-o>0' : '<c-o>_'

        " end key goes past last letter in NORMAL mode with :set virtualedit=onemore.
            "nmap <end> <end><right>

        " Move line or selection up or down with alt+up/down and indent based
        " on new location.
            " IJKL: {
                " when langmap doesn't work
                "nmap <a-k> <a-down>
                "nmap <a-i> <a-up>
                "vmap <a-k> <a-down>
                "vmap <a-i> <a-up>

                " when langmap works
                nmap <a-j> <a-down>
                nmap <a-k> <a-up>
                vmap <a-j> <a-down>
                vmap <a-k> <a-up>
            " }

            " OS X
            nmap ˆ <a-i>
            nmap ∆ <a-j>
            nmap ˚ <a-k>
            vmap ˆ <a-i>
            vmap ∆ <a-j>
            vmap ˚ <a-k>

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

        " COPY/PASTE
            " Make `"*` behave the same on all OSes. In linux, `"*` uses the
            " SECONDARY register for pasting with a mouse middle click, but I
            " never use that. In OS X, `"*` uses the same register as `"+`,
            " which is the behavior I like.
                noremap "* "+
                inoremap <c-r>* <c-r>+
                " TODO: handle command/search mode.

            " Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
            " which is the default
                nnoremap Y y$

            " Make p paste CUA style like gedit, notepad, etc (e.g. pastes then
            " the cursor is at the end of the paste). Note: Seems to be the
            " default behavior now.
                "nnoremap p p`]
                "xnoremap p p`]

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
                " IJKL: {
                    "  when langmap doesn't work
                        "map j <a-h>
                        "map l <a-l>

                        "" Mac OS X
                        "map ∆ <a-h>
                        "map ¬ <a-l>

                    " when langmap works
                        map h <a-h>
                        map l <a-l>

                        " Mac OS X
                        map ˙ <a-h>
                        map ¬ <a-l>
                " }

                map <a-h> <a-left>
                map <a-l> <a-right>

                noremap <c-left> gT
                noremap <c-right> gt
                nnoremap <a-left> gT
                nnoremap <a-right> gt

            " quick buffer switching
                " native way
                "nnoremap <leader>b :buffers<cr>:b<space>

                " using fzf plugin!
                nnoremap <leader>b :Buffers<cr>

            " HJKL to IJKL window commands.
            " IJKL: {
                " when langmap doesn't work
                    "nnoremap <c-w>j <c-w>h
                    "nnoremap <c-w>k <c-w>j
                    "nnoremap <c-w>i <c-w>k
                    "nnoremap <c-w>h <c-w>i

                    "nnoremap <c-w><c-j> <c-w><c-h>
                    "nnoremap <c-w><c-k> <c-w><c-j>
                    "nnoremap <c-w><c-i> <c-w><c-k>
                    "nnoremap <c-w><c-h> <c-w><c-i>

                    "nnoremap <c-w>J <c-w>H
                    "nnoremap <c-w>K <c-w>J
                    "nnoremap <c-w>I <c-w>K
                    "nnoremap <c-w>H <c-w>I

                " when langmap works, nothing to do.
            " }

            " easier split window switching.
                " IJKL: {

                    " when langmap doesn't work
                        "" FIXME: ctrl+shift doesn't work in MacVim, so using ctrl+alt for now.
                        ""nnoremap <c-s-j> <c-w>h
                        ""nnoremap <c-s-k> <c-w>j
                        ""nnoremap <c-s-i> <c-w>k
                        ""nnoremap <c-s-l> <c-w>l
                        "nnoremap <c-a-j> <c-w>h
                        "nnoremap <c-a-k> <c-w>j
                        "nnoremap <c-a-i> <c-w>k
                        "nnoremap <c-a-l> <c-w>l

                    " when langmap works
                        " FIXME: ctrl+shift doesn't work in MacVim, so using ctrl+alt for now.
                        "nnoremap <c-s-h> <c-w>h
                        "nnoremap <c-s-j> <c-w>j
                        "nnoremap <c-s-k> <c-w>k
                        "nnoremap <c-s-l> <c-w>l
                        nnoremap <c-a-h> <c-w>h
                        nnoremap <c-a-j> <c-w>j
                        nnoremap <c-a-k> <c-w>k
                        nnoremap <c-a-l> <c-w>l
                " }

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

                function! SetRelativeNumber()
                    if(&buftype == 'terminal')
                        return
                    endif

                    if(&number)
                        set relativenumber
                    endif
                endfunc

                function! SetNoRelativeNumber()
                    if(&buftype == 'terminal')
                        return
                    endif

                    if(&number)
                        set norelativenumber
                    endif
                endfunc

                nnoremap <leader>n :call NumberToggle()<cr>
                " TODO: Use a function to detect NeoVim terminal buffers and
                " not do anything in those buffers.
                autocmd FocusLost * :call SetNoRelativeNumber()
                autocmd FocusGained * :call SetRelativeNumber()
                autocmd InsertEnter * :call SetNoRelativeNumber()

                " doesn't work in NeoVim 0.1.2
                autocmd InsertLeave * :call SetRelativeNumber()
                " workaround:
                autocmd CursorMoved * :call SetRelativeNumber()

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

        " Reverse all lines.
            command Reverse g/^/m0

        " BEGIN BUFFERS
        set nohidden
        autocmd BufNew,BufNewFile,BufRead * setlocal bufhidden=delete
        " Delete all hidden buffers.
        function! DeleteInactiveBufs()
            "From tabpagebuflist() help, get a list of all buffers in all tabs
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
        " END BUFFERS

        " windo, bufdo, and tabdo replacement commands that return you to your
        " original window, buffer, or tab. See:
        " http://vim.wikia.com/wiki/Run_a_command_in_multiple_buffers
        " {{
            " Like windo but restore the current window.
            function! WinDo(command)
                let currwin=winnr()
                let curaltwin=winnr('#')
                execute 'windo ' . a:command
                " restore previous/alt window
                execute curaltwin . 'wincmd w'
                " restore current window
                execute currwin . 'wincmd w'
            endfunction
            command! -nargs=+ -complete=command Windo call WinDo(<q-args>)

            " Like bufdo but restore the current buffer.
            function! BufDo(command)
                let currBuff=bufnr("%")
                execute 'bufdo ' . a:command
                execute 'buffer ' . currBuff
            endfunction
            command! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

            " Like tabdo but restore the current tab.
            function! TabDo(command)
                let currTab=tabpagenr()
                execute 'tabdo ' . a:command
                execute 'tabn ' . currTab
            endfunction
            command! -nargs=+ -complete=command Tabdo call TabDo(<q-args>)
        " }}

    " END COMMAND MAPS AND SPECIAL FUNCTION MAPS:

" END CUSTOM SETTINGS:
