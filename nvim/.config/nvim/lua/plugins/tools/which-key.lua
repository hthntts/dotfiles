local which_key = require('which-key')
local icons = require('lib.icons')

local setup = {
    plugins = {
        marks = true,
        registers = true,
        spelling = {
            enabled = true,
            suggestions = 30,
        },
        presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
        },
    },
    key_labels = {
        ['<leader>'] = icons.ui.Rocket,
        ['<space>'] = '<spc>',
        ['<Tab>'] = '<tab>',
    },
    icons = {
        breadcrumb = icons.ui.ArrowOpen,
        separator = icons.ui.Arrow,
        group = '',
    },
    popup_mappings = {
        scroll_down = '<c-d>',
        scroll_up = '<c-u>',
    },
    window = {
        border = 'shadow',
        position = 'bottom',
        margin = { 0, 0, 0, 0 },
        padding = { 1, 2, 1, 2 },
        winblend = 10,
    },
    layout = {
        height = { min = 4, max = 24 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = 'center',
    },
    ignore_missing = false,
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', '^:', '^ ', '^call ', '^lua ' },
    show_help = true,
    show_keys = true,
    triggers = 'auto',
    triggers_nowait = {
        -- marks
        '`',
        "'",
        'g`',
        "g'",
        -- registers
        '"',
        '<c-r>',
        -- spelling
        'z=',
    },
    triggers_blacklist = {
        i = { 'j', 'j' },
        v = { 'j', 'j' },
    },
}

local i = {
    [' '] = 'Whitespace',
    ['"'] = 'Balanced "',
    ["'"] = "Balanced '",
    ['`'] = 'Balanced `',
    ['('] = 'Balanced (',
    [')'] = 'Balanced ) including white-space',
    ['>'] = 'Balanced > including white-space',
    ['<lt>'] = 'Balanced <',
    [']'] = 'Balanced ] including white-space',
    ['['] = 'Balanced [',
    ['}'] = 'Balanced } including white-space',
    ['{'] = 'Balanced {',
    ['?'] = 'User Prompt',
    _ = 'Underscore',
    a = 'Argument',
    b = 'Balanced ), ], }',
    c = 'Class',
    f = 'Function',
    o = 'Block, conditional, loop',
    q = 'Quote `, ", \'',
    t = 'Tag',
}

local a = vim.deepcopy(i)
for k, v in pairs(a) do
    a[k] = v:gsub(' including.*', '')
end

local ic = vim.deepcopy(i)
local ac = vim.deepcopy(a)

for key, name in pairs({ n = 'Next', l = 'Last' }) do
    i[key] = vim.tbl_extend('force', { name = 'Inside ' .. name .. ' textobject' }, ic)
    a[key] = vim.tbl_extend('force', { name = 'Around ' .. name .. ' textobject' }, ac)
end

local opts = {
    mode = 'n',
    prefix = '<leader>',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local mappings = {
    ['.'] = { '<cmd>lua require("telescope").extensions.menufacture.find_files()<cr>', icons.documents.Files .. 'Find file' },
    ['/'] = { '<cmd>lua require("telescope").extensions.menufacture.live_grep()<cr>', icons.ui.Telescope .. 'Search project' },
    [','] = { '<cmd>Telescope buffers<cr>', icons.documents.SymlinkFolder .. 'Switch buffer' },
    ['<space>'] = { '<cmd>Telescope find_files<cr>', icons.ui.Search .. 'Find files' },
    ['e'] = { '<cmd>NvimTreeToggle<cr>', icons.documents.Folder .. 'Explorer' },
    x = { '<cmd>x<cr>', icons.ui.Pencil .. 'Write and Quit' },
    b = {
        name = icons.ui.Collection .. 'Buffer',
        d = { '<cmd>bw<cr>', 'Kill buffer' },
        K = { '<cmd>:%bdelete<cr>', 'Kill all buffer' },
        N = { '<cmd>enew<cr>', 'New empty buffer' },
        y = { '<cmd>%y+<cr>', 'Yank buffer' },
    },
    c = {
        name = icons.ui.Gear .. 'LSP',
        a = { '<cmd>Lspsaga code_action<cr>', 'Code Action' },
        d = { '<cmd>Lspsaga peek_definition<cr>', 'Peek Definition' },
        D = { '<cmd>Lspsaga goto_definition<cr>', 'Goto Definition' },
        f = { '<cmd>Lspsaga finder<cr>', 'Finder' },
        F = { '<cmd>Telescope lsp_references<cr>', 'References' },
        h = { '<cmd>Lspsaga hover_doc<cr>', 'Hover' },
        i = { '<cmd>Telescope diagnostics<cr>', 'Diagnostics' },
        I = { '<cmd>Lspsaga show_workspace_diagnostics<cr>', 'Workspace Diagnostics' },
        j = { '<cmd>Lspsaga diagnostic_jump_next<cr>', 'Next Diagnostic' },
        k = { '<cmd>Lspsaga diagnostic_jump_prev<cr>', 'Prev Diagnostic' },
        l = { "<cmd>lua require('lsp_lines').toggle()<cr>", 'Toggle LSP Lines' },
        L = { '<cmd>LspInfo<cr>', 'LSP Info' },
        o = { '<cmd>Lspsaga outline<cr>', 'Outline' },
        p = { '<cmd>Telescope lsp_incoming_calls<cr>', 'Incoming Calls' },
        P = { '<cmd>Telescope lsp_outgoing_calls<cr>', 'Outgoing Calls' },
        r = { '<cmd>Lspsaga rename<cr>', 'Rename' },
        R = { '<cmd>Lspsaga project_replace<cr>', 'Replace' },
        s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
        S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workspace Symbols' },
        t = { '<cmd>Lspsaga peek_type_definition<cr>', 'Peek Type Definition' },
        T = { '<cmd>Lspsaga goto_type_definition<cr>', 'Goto Type Definition' },
    },
    d = {
        name = icons.ui.Bug .. 'Debug',
        b = { '<cmd>DapToggleBreakpoint<cr>', 'Breakpoint' },
        c = { '<cmd>DapContinue<cr>', 'Continue' },
        i = { '<cmd>DapStepInto<cr>', 'Into' },
        l = { "<cmd>lua require'dap'.run_last()<cr>", 'Last' },
        o = { '<cmd>DapStepOver<cr>', 'Over' },
        O = { '<cmd>DapStepOut<cr>', 'Out' },
        r = { '<cmd>DapToggleRepl<cr>', 'Repl' },
        R = { '<cmd>DapRestartFrame<cr>', 'Restart Frame' },
        t = { '<cmd>DapUIToggle<cr>', 'Debugger' },
        x = { '<cmd>DapTerminate<cr>', 'Exit' },
    },
    f = {
        name = icons.documents.File .. 'File',
        f = { '<cmd>Telescope find_files<cr>', 'Find files' },
        r = { '<cmd>Telescope oldfiles<cr>', 'Recent files' },
        s = { '<cmd>w<cr>', 'Save file' },
        y = { '<cmd>CApath<cr>', 'Yank file path' },
        Y = { '<cmd>CRpath<cr>', 'Yank file path from project' },
    },
    g = {
        name = icons.git.Octoface .. 'Git',
        ['['] = { '<cmd>Gitsigns prev_hunk<cr>', 'Jump to previous hunk' },
        [']'] = { '<cmd>Gitsigns next_hunk<cr>', 'Jump to next hunk' },
        A = { '<cmd>CoAuthor<cr>', 'Add Co Author' },
        b = { '<cmd>Gitsigns blame_line<cr>', 'Git blame line' },
        B = { '<cmd>Telescope git_branches<cr>', 'Git checkout branch' },
        f = { '<cmd>lua require("telescope").extensions.menufacture.git_files()<cr>', 'Git find files' },
        F = { '<cmd>Git fetch<cr>', 'Git fetch' },
        g = { '<cmd>Git<cr>', 'Git status' },
        L = { '<cmd>Telescope git_commits<cr>', 'Git log' },
        R = { '<cmd>Gitsigns reset_buffer<cr>', 'Revert file' },
        S = { '<cmd>Gitsigns stage_buffer<cr>', 'Git stage file' },
        t = {
            name = 'Git Toggle',
            b = { '<cmd>Gitsigns toggle_current_line_blame<cr>', 'Blame' },
            d = { '<cmd>Gitsigns toggle_deleted<cr>', 'Deleted' },
            l = { '<cmd>Gitsigns toggle_linehl<cr>', 'Line HL' },
            n = { '<cmd>Gitsigns toggle_numhl<cr>', 'Number HL' },
            s = { '<cmd>Gitsigns toggle_signs<cr>', 'Signs' },
            w = { '<cmd>Gitsigns toggle_word_diff<cr>', 'Word Diff' },
        },
        U = { '<cmd>Gitsigns undo_stage_hunk<cr>', 'Git unstage file' },
        y = { '<cmd>lua require"gitlinker".get_buf_range_url()<cr>', 'Copy link to remote' },
    },
    m = {
        name = icons.kind.Field .. 'Modes',
        c = { '<cmd>CccHighlighterToggle<cr>', 'Highlight Colors' },
        d = { '<cmd>Dashboard<cr>', 'Dashboard' },
        h = { '<cmd>Hardtime toggle<cr>', 'Hardtime' },
        m = { '<cmd>MarkdownPreviewToggle<cr>', 'Markdown Preview' },
        n = { '<cmd>Telescope notify<cr>', 'Notifications' },
        r = { '<cmd>%SnipRun<cr>', 'Run File' },
        s = { '<cmd>set spell!<cr>', 'Spellcheck' },
        t = { '<cmd>Telescope<cr>', 'Telescope' },
    },
    n = {
        name = icons.ui.Note .. 'Notes',
        d = { '<cmd>Tdo<cr>', "Today's Todo" },
        e = { '<cmd>TdoEntry<cr>', "Today's Entry" },
        f = { '<cmd>TdoFiles<cr>', 'All Notes' },
        g = { '<cmd>TdoFind<cr>', 'Find Notes' },
        h = { '<cmd>Tdo -1<cr>', "Yesterday's Todo" },
        j = { "<cmd>put =strftime('%a %d %b %r')<cr>", 'Insert Human Date' },
        J = { "<cmd>put =strftime('%F')<cr>", 'Insert Date' },
        k = { "<cmd>put =strftime('%r')<cr>", 'Insert Human Time' },
        K = { "<cmd>put =strftime('%F-%H-%M')<cr>", 'Insert Time' },
        l = { '<cmd>Tdo 1<cr>', "Tomorrow's Todo" },
        n = { '<cmd>TdoNote<cr>', 'New Note' },
        s = {
            '<cmd>lua require("tdo").run_with("commit " .. vim.fn.expand("%:p")) vim.notify("Committed!")<cr>',
            'Commit Note',
        },
        t = { '<cmd>TdoTodos<cr>', 'Incomplete Todos' },
        x = { '<cmd>TdoToggle<cr>', 'Toggle Todo' },
    },
    o = {
        name = icons.documents.OpenFolder .. 'Open',
        ['-'] = { '<cmd>Fern . -drawer -reveal=% -toggle<cr>', 'Fern' },
        o = { '<cmd>!open .<cr><cr>', 'Reveal in Finder' },
        t = { '<cmd>Sterm<cr>', 'Open Sterm' },
        T = { '<cmd>Fterm<cr>', 'Open Fterm here' },
    },
    p = {
        name = icons.ui.Package .. 'Packages',
        c = { '<cmd>Lazy check<cr>', 'Check' },
        d = { '<cmd>Lazy debug<cr>', 'Debug' },
        p = { '<cmd>Lazy<cr>', 'Plugins' },
        P = { '<cmd>Lazy profile<cr>', 'Profile' },
        m = { '<cmd>Mason<cr>', 'Mason' },
        i = { '<cmd>Lazy install<cr>', 'Install' },
        l = { '<cmd>Lazy log<cr>', 'Log' },
        r = { '<cmd>Lazy restore<cr>', 'Restore' },
        s = { '<cmd>Lazy sync<cr>', 'Sync' },
        u = { '<cmd>Lazy update<cr>', 'Update' },
        x = { '<cmd>Lazy clean<cr>', 'Clean' },
    },
    q = {
        name = icons.ui.Close .. 'Quit/Session',
        q = { '<cmd>q<cr>', 'Quit Nvim' },
        Q = { '<cmd>qa!<cr>', 'Force Quit Nvim' },
    },
    r = {
        name = icons.diagnostics.Hint .. 'Refactor',
        b = { "<cmd>lua require('spectre').open_file_search()<cr>", 'Replace Buffer' },
        S = { "<cmd>lua require('spectre').open()<cr>", 'Replace' },
        s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], 'Replace Word' },
        w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", 'Replace Word' },
    },
    s = {
        name = icons.ui.Search .. 'Search',
        ['"'] = { '<cmd>Telescope registers<cr>', 'Registers' },
        ['.'] = { '<cmd>Telescope symbols<cr>', 'Search emojis' },
        [','] = { '<cmd>Nerdy<cr>', 'Search Nerd Glyphs' },
        B = { '<cmd>Telescope live_grep grep_open_files=true<cr>', 'Search all open buffers' },
        H = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
        K = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
        L = { '<cmd>Telescope loclist<cr>', 'Location List' },
        h = { '<cmd>Telescope help_tags<cr>', 'Help' },
        k = { '<cmd>Telescope commands<cr>', 'Commands' },
        l = { '<cmd>Telescope resume<cr>', 'Last Search' },
        p = { '<cmd>Telescope<cr>', 'Panel' },
        u = { '<cmd>Telescope undo<cr>', 'Undo History' },
    },
    w = {
        name = icons.ui.Windows .. 'Window',
        w = { '<cmd>NavigatorPrevious<cr>', 'Previous Window' },
        s = { '<C-w>s', 'Split Below' },
        v = { '<C-w>v', 'Split Right' },
        d = { '<C-w>c', 'Close Window' },
        h = { '<C-w>h', 'Move Left' },
        j = { '<C-w>j', 'Move Down' },
        k = { '<C-w>k', 'Move Up' },
        l = { '<C-w>l', 'Move Right' },
    },
}

local vopts = {
    mode = 'v',
    prefix = '<leader>',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local vmappings = {
    l = {
        name = icons.ui.Gear .. 'LSP',
        a = '<cmd><C-U>Lspsaga range_code_action<CR>',
    },
    r = {
        name = icons.diagnostics.Hint .. 'Refactor',
        r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", 'Refactor Commands' },
        e = { "<esc><cmd>lua require('refactoring').refactor('Extract Function')<CR>", 'Extract Function' },
        f = { "<esc><cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", 'Extract To File' },
        v = { "<esc><cmd>lua require('refactoring').refactor('Extract Variable')<CR>", 'Extract Variable' },
        i = { "<esc><cmd>lua require('refactoring').refactor('Inline Variable')<CR>", 'Inline Variable' },
    },
    s = { "<esc><cmd>'<,'>SnipRun<cr>", icons.ui.Play .. 'Run Code' },
    q = { '<cmd>q<cr>', icons.ui.Close .. 'Quit' },
    Q = { '<cmd>qa!<cr>', icons.ui.Power .. 'Force Quit!' },
    x = { '<cmd>x<cr>', icons.ui.Pencil .. 'Write and Quit' },
    y = {
        name = icons.ui.Clipboard .. 'Yank',
        g = { '<cmd>lua require"gitlinker".get_buf_range_url()<cr>', 'Copy Git URL' },
    },
}

local no_leader_opts = {
    mode = 'n',
    prefix = '',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local no_leader_mappings = {
    ['<S-h>'] = { '<cmd>bprevious<cr>', 'Previous Buffer' },
    ['<S-l>'] = { '<cmd>bnext<cr>', 'Next Buffer' },

    ['['] = {
        name = icons.ui.ArrowLeft .. 'Previous',
        b = { '<cmd>bprevious<cr>', 'Buffer' },
        B = { '<cmd>bfirst<cr>', 'First Buffer' },
        d = { '<cmd>Lspsaga diagnostic_jump_prev<cr>', 'Diagnostic' },
        e = { 'g;', 'Edit' },
        g = { '<cmd>Gitsigns prev_hunk<cr>', 'Git Hunk' },
        j = { '<C-o>', 'Jump' },
    },
    [']'] = {
        name = icons.ui.ArrowRight .. 'Next',
        b = { '<cmd>bnext<cr>', 'Buffer' },
        B = { '<cmd>blast<cr>', 'Buffer' },
        d = { '<cmd>Lspsaga diagnostic_jump_next<cr>', 'Diagnostic' },
        e = { 'g,', 'Edit' },
        g = { '<cmd>Gitsigns next_hunk<cr>', 'Git Hunk' },
        j = { '<C-i>', 'Jump' },
    },

    K = { '<cmd>Lspsaga hover_doc<cr>', 'LSP Hover' },
    U = { '<cmd>redo<cr>', 'Redo' },
}

if vim.fn.exists('$TMUX') == 1 then
    local tmux_mappings = {
        ['<A-h>'] = { '<cmd>NavigatorLeft<cr>', 'Move Left' },
        ['<A-j>'] = { '<cmd>NavigatorDown<cr>', 'Move Down' },
        ['<A-k>'] = { '<cmd>NavigatorUp<cr>', 'Move Up' },
        ['<A-l>'] = { '<cmd>NavigatorRight<cr>', 'Move Right' },
        ['<A-m>'] = { '<cmd>NavigatorPrevious<cr>', 'Goto Previous' },
    }
    no_leader_mappings = vim.tbl_extend('force', no_leader_mappings, tmux_mappings)
end

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
which_key.register(no_leader_mappings, no_leader_opts)
which_key.register({ mode = { 'o', 'x' }, i = i, a = a })
