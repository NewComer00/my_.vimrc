" Neovim Config File
" Default Location: ~/.config/nvim/init.vim

" *************************************************************************
" presettings
" *************************************************************************

set encoding=utf8

" *************************************************************************
" nvim plugins
" *************************************************************************

let GITHUB_RAW = 'https://raw.fastgit.org/'
let GITHUB_SITE = 'https://hub.fastgit.xyz/'
"let GITHUB_RAW = 'https://raw.githubusercontent.com/'
"let GITHUB_SITE = 'https://github.com/'

" download the plugin manager if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    echo 'Downloading plugin manager ...'
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs '.GITHUB_RAW.'junegunn/vim-plug/master/plug.vim && echo "Download successful." || echo "Download failed." '
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" color scheme
Plug GITHUB_SITE.'rafamadriz/neon'

" mostly used
Plug GITHUB_SITE.'preservim/nerdtree'
Plug GITHUB_SITE.'vim-airline/vim-airline'
Plug GITHUB_SITE.'akinsho/toggleterm.nvim'
Plug GITHUB_SITE.'mbbill/undotree'
Plug GITHUB_SITE.'preservim/tagbar'

" more convenience
Plug GITHUB_SITE.'luochen1990/rainbow'
Plug GITHUB_SITE.'itchyny/vim-cursorword.git'
Plug GITHUB_SITE.'ntpeters/vim-better-whitespace'
Plug GITHUB_SITE.'lukas-reineke/indent-blankline.nvim'
Plug GITHUB_SITE.'windwp/nvim-autopairs'
Plug GITHUB_SITE.'tpope/vim-surround'
Plug GITHUB_SITE.'airblade/vim-rooter'
Plug GITHUB_SITE.'junegunn/vim-peekaboo'
Plug GITHUB_SITE.'preservim/nerdcommenter'
Plug GITHUB_SITE.'vim-scripts/YankRing.vim'
Plug GITHUB_SITE.'farmergreg/vim-lastplace'

" finder
Plug GITHUB_SITE.'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug GITHUB_SITE.'ibhagwan/fzf-lua', {'branch': 'main'}

" LSP related
Plug GITHUB_SITE.'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
Plug GITHUB_SITE.'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug GITHUB_SITE.'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug GITHUB_SITE.'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug GITHUB_SITE.'L3MON4D3/LuaSnip' " Snippets plugin
Plug GITHUB_SITE.'ray-x/lsp_signature.nvim' " Function signature
Plug GITHUB_SITE.'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim' " Toggle LSP diagnostics

" debugger
Plug GITHUB_SITE.'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

call plug#end()

" *************************************************************************
" Language Server Protocol (LSP) server configs
" *************************************************************************

" [neovim/nvim-lspconfig]
" https://github.com/neovim/nvim-lspconfig
lua << EOF
-- register your installed LSP server here
MY_LSP_SERVER_LIST = {
    -- for example:
    "pylsp",
    "clangd",
}
-- find out LSP server for each language :
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps

-- my custom config function,
-- only take effect on buffers with an active language server
MY_CUSTOM_ON_ATTACH = function(client)
    -- hotkeys for LSP service
    vim.keymap.set('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    vim.keymap.set('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
    vim.keymap.set('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
    vim.keymap.set('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    vim.keymap.set('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
    vim.keymap.set('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
end
EOF

" *************************************************************************
" plugin configs
" *************************************************************************

" [rafamadriz/neon]
let g:neon_style = "dark"
let g:neon_italic_keyword = 1
let g:neon_italic_function = 1
let g:neon_transparent = 1
colorscheme neon

" [preservim/nerdtree]
let NERDTreeWinPos="right"
let NERDTreeShowHidden=1
let NERDTreeMouseMode=2

" [akinsho/toggleterm.nvim]
" https://github.com/akinsho/toggleterm.nvim
lua << EOF
require("toggleterm").setup()
EOF

" [preservim/tagbar]
let g:tagbar_position = 'vertical leftabove'
let g:tagbar_width = max([25, winwidth(0) / 5])

" [rainbow/luochen1990]
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'separately': {
\   'nerdtree': 0,
\   }
\}

" [lukas-reineke/indent-blankline.nvim]
" https://github.com/lukas-reineke/indent-blankline.nvim
lua << EOF
require("indent_blankline").setup {}
EOF

" [vim-scripts/YankRing.vim]
" make it compatible for neovim
" https://github.com/neovim/neovim/issues/2642#issuecomment-218232937
let g:yankring_clipboard_monitor = 0
" to avoid <C-p> collision with the ctrlp plugin
let g:yankring_replace_n_pkey = '<m-p>'
let g:yankring_replace_n_nkey = '<m-n>'
" save yankring history in this dir
let yankring_path=expand(stdpath("data")."/yankring-dir")
if !isdirectory(yankring_path)
    call mkdir(yankring_path, "", 0700)
endif
let g:yankring_history_dir = yankring_path

" [windwp/nvim-autopairs] with nvim-cmp
" https://github.com/windwp/nvim-autopairs
lua << EOF
require("nvim-autopairs").setup {}
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
'confirm_done',
cmp_autopairs.on_confirm_done()
)
EOF

" [ibhagwan/fzf-lua]
" https://github.com/ibhagwan/fzf-lua
lua << EOF
-- by default, using fzf binary downloaded by [junegunn/fzf]
local default_fzf_bin = vim.api.nvim_exec(
    [[echo expand(stdpath('data').'/plugged/fzf/bin/fzf')]], true)
require('fzf-lua').setup {
    fzf_bin = default_fzf_bin,
}
EOF

" [neovim/nvim-lspconfig] auto-completion settings
" https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
lua << EOF
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(MY_LSP_SERVER_LIST) do
    lspconfig[lsp].setup {
        on_attach = MY_CUSTOM_ON_ATTACH,
        capabilities = capabilities,
    }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
        luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}
EOF

" [ray-x/lsp_signature.nvim]
" https://github.com/ray-x/lsp_signature.nvim
lua << EOF
require "lsp_signature".setup {}
EOF

" [WhoIsSethDaniel/toggle-lsp-diagnostics.nvim]
" https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
lua << EOF
-- turn off lsp diagnostics by default
require'toggle_lsp_diagnostics'.init({ start_on = false })
EOF

" [sakhnik/nvim-gdb]
" https://github.com/sakhnik/nvim-gdb
" disable default keymaps
let g:nvimgdb_disable_start_keymaps = 1
" set debugger keymaps
function! NvimGdbNoTKeymaps()
  tnoremap <silent> <buffer> <esc> <c-\><c-n>
endfunction
let g:nvimgdb_config_override = {
  \ 'key_next': 'n',
  \ 'key_step': 's',
  \ 'key_finish': 'f',
  \ 'key_continue': 'c',
  \ 'key_until': 'u',
  \ 'key_breakpoint': 'b',
  \ 'key_quit': 'q',
  \ 'key_eval': 'e',
  \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
  \ }

" *************************************************************************
" my scripts
" *************************************************************************

" to enable backspace key
" https://vi.stackexchange.com/a/2163
set backspace=indent,eol,start

set novisualbell

" to deal with REPLACE MODE problem on windows cmd or windows terminal
" https://superuser.com/a/1525060
set t_u7=

set t_Co=256
syntax on

set hlsearch

set number
set relativenumber

set nowrap

set tabstop=4
set shiftwidth=4
set expandtab

set autoindent

set wildmode=longest,full
set wildmenu

set mouse=a

set splitbelow

set dictionary+=/usr/share/dict/words
set complete+=k

set listchars=eol:↵,tab:\|\|,trail:~,extends:>,precedes:<,space:·
set list

" Let's save undo info!
" from https://vi.stackexchange.com/a/53
let undodir_path=expand(stdpath("data")."/undo-dir")
if !isdirectory(undodir_path)
    call mkdir(undodir_path, "", 0700)
endif
let &undodir=undodir_path
set undofile

" *************************************************************************
" my functions
" *************************************************************************

" allow toggling between local and default mode
" https://vim.fandom.com/wiki/Toggle_between_tabs_and_spaces
function! TabToggle()
    if &expandtab
        set noexpandtab
    else
        set expandtab
    endif
endfunction

" my wrapper for [sakhnik/nvim-gdb]
function! GdbStartAuto()
    let current_file_path = expand('%:p')
    let current_file_type = &filetype
    let debugger_info = [
    \   {'name':'gdb',      'filetype':['cpp','c','objcpp'],    'cmd':'GdbStart gdb -q'},
    \   {'name':'lldb',     'filetype':['cpp','c','objcpp'],    'cmd':'GdbStartLLDB lldb'},
    \   {'name':'pdb',      'filetype':['python'],              'cmd':'GdbStartPDB python3 -m pdb '.current_file_path},
    \   {'name':'bashdb',   'filetype':['sh'],                  'cmd':'GdbStartBashDB bashdb '.current_file_path},
    \   ]

    " first try to open the related debugger by current filetype
    let counter = 0
    for debugger in debugger_info
        if index(debugger['filetype'], current_file_type) >= 0
            exec(debugger['cmd'])
            break
        else
            let counter += 1
        endif
    endfor

    " if no suitable debugger for the filetype,
    " let the user decide which debugger to use
    if counter >= len(debugger_info)
        echo 'Available debuggers:'
        let debugger_number = 1
        for debugger in debugger_info
            echo '  '.string(debugger_number).'.'.debugger['name'].' '
            let debugger_number += 1
        endfor
        echo '  '.string(debugger_number).'.quit'

        let choosen_number = input('Select a debugger: ')
        let idx = choosen_number - 1
        redraw " flush the old output
        if idx >= 0 && idx < len(debugger_info)
            exec(debugger_info[idx]['cmd'])
        else
            echo 'quit'
        endif
    endif
endfunction

"*************************************************************************
" file types
" *************************************************************************

" scons
augroup scons_ft
    au!
    autocmd BufNewFile,BufRead SConstruct set filetype=python
augroup END

" *************************************************************************
" hotkeys
" *************************************************************************

" functional hotkeys for plugins
nnoremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <F3> <Cmd>exe v:count1 . "ToggleTerm"<CR>
nnoremap <silent> <F4> :UndotreeToggle<CR>
nnoremap <silent> <F5> :AirlineToggle<CR>
nnoremap <silent> <F6> :call GdbStartAuto()<CR>
nnoremap <silent> <F7> :YRShow<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <silent> <F9> :FzfLua<CR>

inoremap <silent> <F2> <Esc>:NvimTreeToggle<CR>
inoremap <silent> <F3> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent> <F4> <Esc>:UndotreeToggle<CR>
inoremap <silent> <F5> <Esc>:AirlineToggle<CR>
inoremap <silent> <F6> <Esc>:call GdbStartAuto()<CR>
inoremap <silent> <F7> <Esc>:YRShow<CR>
inoremap <silent> <F8> <Esc>:TagbarToggle<CR>
inoremap <silent> <F9> <Esc>:FzfLua<CR>

cnoremap <silent> <F6> <C-c>

tnoremap <silent> <F3> <Cmd>exe v:count1 . "ToggleTerm"<CR>
tnoremap <silent> <F9> <Esc>

" enable autocomplete in command mode
cnoremap <C-n> <C-f>a<C-n>
cnoremap <C-p> <C-f>a<C-p>

" use <Esc> to quit terminal mode
tnoremap <Esc> <C-\><C-n>

" quickly open this config file
nnoremap <leader>ve :e $MYVIMRC<CR>
" quickly save and source this config file
nnoremap <leader>vs :wa<Bar>so $MYVIMRC<CR>
inoremap <leader>vs <Esc>:wa<Bar>so $MYVIMRC<CR>a

" toggle list char and indentation mark
inoremap <leader>l <Esc>:set list!<Bar>IndentBlanklineToggle<CR>a
nnoremap <leader>l :set list!<Bar>IndentBlanklineToggle<CR>

" toggle paste mode
inoremap <leader>p <Esc>:set paste!<CR>a
nnoremap <leader>p :set paste!<CR>

" toggle tab/spaces
inoremap <leader>t <Esc>:call TabToggle()<CR>a
nnoremap <leader>t :call TabToggle()<CR>

" auto formatting
vnoremap <leader>f :lua vim.lsp.buf.range_formatting()<CR>
inoremap <leader>F <Esc>:lua vim.lsp.buf.formatting()<CR>a
nnoremap <leader>F :lua vim.lsp.buf.formatting()<CR>

" strip trailing whitespaces
inoremap <leader>s <Esc>:StripWhitespace<CR>a
nnoremap <leader>s :StripWhitespace<CR>

" search the word under the cursor
inoremap <leader>a <Esc>:FzfLua grep_cword<CR>
nnoremap <leader>a :FzfLua grep_cword<CR>
" search the given word
inoremap <leader>A <Esc>:FzfLua live_grep<CR>
nnoremap <leader>A :FzfLua live_grep<CR>

" toggle LSP diagnostics
inoremap <leader>d <Esc>:ToggleDiag<CR>a
nnoremap <leader>d :ToggleDiag<CR>
