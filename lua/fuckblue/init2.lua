local M = {}
local colors = {
  -- Base colors: Background and foreground tones
  bg_black = '#000000', -- Main background
  bg_dark = '#262626', -- Darker background (sidebars, popups)
  bg_light = '#303030', -- Lighter background (selections, visual mode)
  bg_lighter = '#4a4a4a', -- Even lighter (cursor line, etc.)
  bg_lighterer = '#a8a8a8', -- Even lighterer

  light_orange = '#ffbb00', -- Main foreground text
  orange = '#e57e00', -- Orange (numbers, booleans)
  dark_orange = '#c28e00', -- Dimmed text (comments,etc)
  bright_orange = '#fcac00', -- brighter text (emphasis)

  -- Neutral grays: For borders and subtle UI elements
  gray = '#3a3a3a', -- Borders, splits
  gray_dark = '#2a2a2a', -- Subtle separators
  gray_light = '#4a4a4a', -- Active borders

  -- Purple tones: Primary accent color
  light_gray = '#d4d4d4', -- Main purple (keywords, operators)
  silver = '#a8a8a8', -- Darker purple (secondary keywords)
  grey_white = '#e8e8e8', -- Light purple (constants, special)
  basically_white = '#e8e8e8', -- Bright magenta (important keywords, tags)

  -- Nature tones: Success, additions, types
  green = '#a9ff09', -- Green (success, strings, additions)
  yellow = '#fff800', -- Cyan (escape sequences, regex)

  -- Alert colors: Errors, warnings, information
  reddish = '#e06c75', -- Red (errors, deletions)
  red_dark = '#fc3b00', -- Dark red (severe errors)
  amber = '#ffd86e', -- Amber (warnings)
  info_green = '#a9ff09', -- Info messages (only place we use blue)
}

-- ============================================================================
-- 2. HELPER FUNCTIONS
-- ============================================================================
-- Utility functions to make highlight group definition cleaner and more maintainable

--- Set a highlight group with the given attributes
--- @param group string The highlight group name
--- @param opts table Table containing fg, bg, sp (special), and style attributes
local function highlight(group, opts)
  local cmd = 'highlight ' .. group

  -- Foreground color
  if opts.fg then
    cmd = cmd .. ' guifg=' .. opts.fg
  end

  -- Background color
  if opts.bg then
    cmd = cmd .. ' guibg=' .. opts.bg
  end

  -- Special color (for underlines, undercurls, etc.)
  if opts.sp then
    cmd = cmd .. ' guisp=' .. opts.sp
  end

  -- Styles: bold, italic, underline, undercurl, strikethrough, reverse, etc.
  if opts.style then
    cmd = cmd .. ' gui=' .. opts.style
  end

  -- Link to another highlight group
  if opts.link then
    cmd = 'highlight! link ' .. group .. ' ' .. opts.link
    vim.cmd(cmd)
    return
  end

  vim.cmd(cmd)
end

--- Load the colorscheme
function M.load()
  -- Reset existing highlighting if switching colorschemes
  if vim.g.colors_name then
    vim.cmd 'highlight clear'
  end

  -- Reset syntax highlighting
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  -- Set colorscheme name
  vim.g.colors_name = 'fuckblue'

  -- Enable true color support (24-bit color)
  vim.o.termguicolors = true

  -- ============================================================================
  -- 3. TERMINAL COLORS
  -- ============================================================================
  -- Set terminal colors for :terminal buffers
  -- These are accessed via g:terminal_color_0 through g:terminal_color_15

  vim.g.terminal_color_0 = colors.bg_dark -- Black
  vim.g.terminal_color_1 = colors.reddish -- Red
  vim.g.terminal_color_2 = colors.green -- Green
  vim.g.terminal_color_3 = colors.amber -- Yellow
  vim.g.terminal_color_4 = colors.light_gray -- Blue (but we use purple)
  vim.g.terminal_color_5 = colors.basically_white -- Magenta
  vim.g.terminal_color_6 = colors.yellow -- Cyan
  vim.g.terminal_color_7 = colors.light_orange -- White

  vim.g.terminal_color_8 = colors.gray -- Bright Black
  vim.g.terminal_color_9 = colors.reddish -- Bright Red
  vim.g.terminal_color_10 = colors.green -- Bright Green
  vim.g.terminal_color_11 = colors.yellow -- Bright Yellow
  vim.g.terminal_color_12 = colors.grey_white -- Bright Blue (purple)
  vim.g.terminal_color_13 = colors.basically_white -- Bright Magenta
  vim.g.terminal_color_14 = colors.yellow -- Bright Cyan
  vim.g.terminal_color_15 = colors.bright_orange -- Bright White

  -- ============================================================================
  -- 4. EDITOR UI HIGHLIGHTS
  -- ============================================================================
  -- These control the appearance of the editor itself (not code syntax)

  -- Base UI
  highlight('Normal', { fg = colors.light_orange, bg = colors.bg_black })
  highlight('NormalFloat', { fg = colors.light_orange, bg = colors.bg_dark }) -- Floating windows
  highlight('NormalNC', { fg = colors.light_orange, bg = colors.bg_black }) -- Non-current windows

  -- Cursor and lines
  highlight('Cursor', { fg = colors.bg_black, bg = colors.light_orange }) -- Cursor character
  highlight('CursorLine', { bg = colors.bg_lighter }) -- Line cursor is on
  highlight('CursorLineNr', { fg = colors.light_gray, style = 'bold' }) -- Line number of cursor line
  highlight('LineNr', { fg = colors.gray }) -- Line numbers
  highlight('CursorColumn', { bg = colors.bg_lighter }) -- Column cursor is on

  -- Selection and search
  highlight('Visual', { bg = colors.bg_light }) -- Visual mode selection
  highlight('VisualNOS', { bg = colors.bg_light }) -- Visual mode not owned by Vim
  highlight('Search', { bg = colors.silver, fg = colors.bg_black }) -- Last search pattern
  highlight('IncSearch', { bg = colors.basically_white, fg = colors.bg_black }) -- Incremental search
  highlight('CurSearch', { bg = colors.basically_white, fg = colors.bg_black }) -- Current search item

  -- Status line and tab line
  highlight('StatusLine', { fg = colors.light_orange, bg = colors.bg_light }) -- Active status line
  highlight('StatusLineNC', { fg = colors.dark_orange, bg = colors.bg_dark }) -- Inactive status line
  highlight('TabLine', { fg = colors.dark_orange, bg = colors.bg_dark }) -- Inactive tabs
  highlight('TabLineFill', { bg = colors.bg_dark }) -- Tab line background
  highlight('TabLineSel', { fg = colors.bright_orange, bg = colors.bg_light, style = 'bold' }) -- Active tab

  -- Columns and separators
  highlight('ColorColumn', { bg = colors.bg_light }) -- Color column (textwidth marker)
  highlight('SignColumn', { bg = colors.bg_black }) -- Column with signs (git, diagnostics)
  highlight('VertSplit', { fg = colors.gray }) -- Vertical split separator
  highlight('WinSeparator', { fg = colors.gray }) -- Window separator

  -- Folds
  highlight('Folded', { fg = colors.dark_orange, bg = colors.bg_light }) -- Folded text
  highlight('FoldColumn', { fg = colors.gray, bg = colors.bg_black }) -- Fold column

  -- Messages and prompts
  highlight('MsgArea', { fg = colors.light_orange, bg = colors.bg_black }) -- Message area
  highlight('ModeMsg', { fg = colors.green, style = 'bold' }) -- Mode message (INSERT, VISUAL, etc.)
  highlight('MoreMsg', { fg = colors.green }) -- More prompt
  highlight('ErrorMsg', { fg = colors.reddish, style = 'bold' }) -- Error messages
  highlight('WarningMsg', { fg = colors.amber, style = 'bold' }) -- Warning messages
  highlight('Question', { fg = colors.green }) -- Question prompt

  -- Popup menu (completion menu)
  highlight('Pmenu', { fg = colors.light_orange, bg = colors.bg_dark }) -- Popup menu normal
  highlight('PmenuSel', { fg = colors.bg_black, bg = colors.light_gray }) -- Popup menu selected item
  highlight('PmenuSbar', { bg = colors.gray_dark }) -- Popup menu scrollbar
  highlight('PmenuThumb', { bg = colors.gray_light }) -- Popup menu scrollbar thumb

  -- Diff highlighting
  highlight('DiffAdd', { fg = colors.green, bg = colors.bg_light }) -- Added lines
  highlight('DiffChange', { fg = colors.amber, bg = colors.bg_light }) -- Changed lines
  highlight('DiffDelete', { fg = colors.reddish, bg = colors.bg_light }) -- Deleted lines
  highlight('DiffText', { fg = colors.yellow, bg = colors.bg_light, style = 'bold' }) -- Changed text within line

  -- Spell checking
  highlight('SpellBad', { sp = colors.reddish, style = 'undercurl' }) -- Misspelled word
  highlight('SpellCap', { sp = colors.amber, style = 'undercurl' }) -- Should start with capital
  highlight('SpellLocal', { sp = colors.yellow, style = 'undercurl' }) -- Wrong spelling for locale
  highlight('SpellRare', { sp = colors.light_gray, style = 'undercurl' }) -- Rare word

  -- Special UI elements
  highlight('Directory', { fg = colors.light_gray }) -- Directory names
  highlight('Title', { fg = colors.basically_white, style = 'bold' }) -- Titles
  highlight('SpecialKey', { fg = colors.gray }) -- Special keys in listings
  highlight('NonText', { fg = colors.gray }) -- Non-text characters
  highlight('Whitespace', { fg = colors.gray_dark }) -- Whitespace characters
  highlight('Conceal', { fg = colors.gray }) -- Concealed text
  highlight('MatchParen', { fg = colors.basically_white, style = 'bold' }) -- Matching parentheses

  -- Wild menu (command-line completion)
  highlight('WildMenu', { fg = colors.bg_black, bg = colors.light_gray }) -- Wild menu

  -- ============================================================================
  -- 5. SYNTAX HIGHLIGHTS
  -- ============================================================================
  -- Standard Vim syntax groups used by most filetypes

  -- Comments and documentation
  highlight('Comment', { fg = colors.dark_orange, style = 'italic' }) -- Any comment
  highlight('SpecialComment', { fg = colors.gray_light, style = 'italic' }) -- Special comment (e.g., TODO)

  -- Constants
  highlight('Constant', { fg = colors.orange }) -- Any constant
  highlight('String', { fg = colors.orange }) -- String literals
  highlight('Character', { fg = colors.green }) -- Character constants
  highlight('Number', { fg = colors.orange }) -- Number constants
  highlight('Boolean', { fg = colors.orange }) -- Boolean constants
  highlight('Float', { fg = colors.orange }) -- Float constants

  -- Identifiers
  highlight('Identifier', { fg = colors.orange }) -- Variable names
  highlight('Function', { fg = colors.orange }) -- Function names

  -- Statements
  highlight('Statement', { fg = colors.light_gray }) -- Any statement
  highlight('Conditional', { fg = colors.light_gray }) -- if, else, switch
  highlight('Repeat', { fg = colors.light_gray }) -- for, while, loop
  highlight('Label', { fg = colors.light_gray }) -- case, default
  highlight('Operator', { fg = colors.light_gray }) -- Operators (+, -, *, /, etc.)
  highlight('Keyword', { fg = colors.basically_white }) -- Other keywords
  highlight('Exception', { fg = colors.basically_white }) -- try, catch, throw

  -- Preprocessor
  highlight('PreProc', { fg = colors.basically_white }) -- Generic preprocessor
  highlight('Include', { fg = colors.basically_white }) -- #include, import, require
  highlight('Define', { fg = colors.basically_white }) -- #define, macro
  highlight('Macro', { fg = colors.basically_white }) -- Macros
  highlight('PreCondit', { fg = colors.basically_white }) -- #if, #ifdef, etc.

  -- Types
  highlight('Type', { fg = colors.orange }) -- int, char, class, etc.
  highlight('StorageClass', { fg = colors.orange }) -- static, const, volatile
  highlight('Structure', { fg = colors.orange }) -- struct, union, enum
  highlight('Typedef', { fg = colors.orange }) -- typedef

  -- Special
  highlight('Special', { fg = colors.basically_white }) -- Any special symbol
  highlight('SpecialChar', { fg = colors.silver }) -- Special char in constant
  highlight('Tag', { fg = colors.basically_white }) -- HTML/XML tags
  highlight('Delimiter', { fg = colors.basically_white }) -- Delimiters (brackets, commas)
  highlight('Debug', { fg = colors.reddish }) -- Debug statements

  -- Other
  highlight('Underlined', { fg = colors.yellow, style = 'underline' }) -- Underlined text
  highlight('Ignore', { fg = colors.gray }) -- Ignored text
  highlight('Error', { fg = colors.reddish, bg = colors.bg_light, style = 'bold' }) -- Error
  highlight('Todo', { fg = colors.basically_white, bg = colors.bg_light, style = 'bold,italic' }) -- TODO, FIXME, etc.

  -- ============================================================================
  -- 6. TREESITTER HIGHLIGHTS
  -- ============================================================================
  -- Modern semantic highlighting using Treesitter
  -- More granular than traditional syntax groups

  -- Treesitter core groups
  highlight('@text', { fg = colors.orange }) -- Normal text
  highlight('@text.strong', { fg = colors.dark_orange, style = 'bold' }) -- Bold text
  highlight('@text.emphasis', { fg = colors.light_orange, style = 'italic' }) -- Italic text
  highlight('@text.underline', { style = 'underline' }) -- Underlined text
  highlight('@text.strike', { style = 'strikethrough' }) -- Strikethrough text
  highlight('@text.title', { fg = colors.basically_white, style = 'bold' }) -- Titles (headers)
  highlight('@text.literal', { fg = colors.green }) -- Literal/verbatim text
  highlight('@text.uri', { fg = colors.yellow, style = 'underline' }) -- URIs/URLs
  highlight('@text.math', { fg = colors.orange }) -- Math blocks
  highlight('@text.reference', { fg = colors.yellow }) -- References
  highlight('@text.environment', { fg = colors.light_gray }) -- Environments
  highlight('@text.environment.name', { fg = colors.teal }) -- Environment names

  -- Comments
  highlight('@comment', { link = 'Comment' }) -- Line and block comments
  highlight('@comment.documentation', { fg = colors.orange, style = 'italic' }) -- Documentation comments
  highlight('@comment.error', { fg = colors.reddish, style = 'bold' }) -- Error in comment
  highlight('@comment.warning', { fg = colors.amber, style = 'bold' }) -- Warning in comment
  highlight('@comment.todo', { fg = colors.basically_white, style = 'bold,italic' }) -- TODO in comment
  highlight('@comment.note', { fg = colors.yellow, style = 'bold,italic' }) -- NOTE in comment

  -- Constants
  highlight('@constant', { fg = colors.orange }) -- Constants
  highlight('@constant.builtin', { fg = colors.orange }) -- Built-in constants (nil, true, false)
  highlight('@constant.macro', { fg = colors.orange }) -- Constants defined by macros

  -- Strings and characters
  highlight('@string', { fg = colors.orange }) -- String literals
  highlight('@string.regex', { fg = colors.orange }) -- Regular expressions
  highlight('@string.escape', { fg = colors.bright_orange }) -- Escape sequences (\n, \t, etc.)
  highlight('@string.special', { fg = colors.bright_orange }) -- Special strings
  highlight('@character', { fg = colors.orange }) -- Character literals
  highlight('@character.special', { fg = colors.orange }) -- Special characters

  -- Numbers
  highlight('@number', { fg = colors.orange }) -- Numbers
  highlight('@number.float', { fg = colors.orange }) -- Floats

  -- Booleans
  highlight('@boolean', { fg = colors.orange }) -- Booleans

  -- Functions
  highlight('@function', { fg = colors.orange }) -- Function definitions
  highlight('@function.builtin', { fg = colors.orange }) -- Built-in functions
  highlight('@function.call', { fg = colors.orange }) -- Function calls
  highlight('@function.macro', { fg = colors.orange }) -- Function-like macros
  highlight('@method', { fg = colors.orange }) -- Method definitions
  highlight('@method.call', { fg = colors.orange }) -- Method calls
  highlight('@constructor', { fg = colors.orange }) -- Constructors

  -- Parameters and variables
  highlight('@parameter', { fg = colors.orange }) -- Function parameters
  highlight('@parameter.reference', { fg = colors.orange }) -- Parameter references
  highlight('@variable', { fg = colors.orange }) -- Variables
  highlight('@variable.builtin', { fg = colors.orange }) -- Built-in variables (self, this)
  highlight('@variable.parameter', { fg = colors.orange }) -- Parameters (alias)
  highlight('@variable.member', { fg = colors.orange }) -- Object/struct members

  -- Keywords
  highlight('@keyword', { fg = colors.bright_orange }) -- Keywords
  highlight('@keyword.function', { fg = colors.bright_orange }) -- Function keywords (function, def, fn)
  highlight('@keyword.operator', { fg = colors.bright_orange }) -- Operator keywords (and, or, not)
  highlight('@keyword.return', { fg = colors.bright_orange }) -- Return keyword
  highlight('@keyword.conditional', { fg = colors.bright_orange }) -- Conditionals (if, else)
  highlight('@keyword.repeat', { fg = colors.bright_orange }) -- Loops (for, while)
  highlight('@keyword.import', { fg = colors.bright_orange }) -- Import statements
  highlight('@keyword.exception', { fg = colors.bright_orange }) -- Exception keywords (try, catch)

  -- Operators
  highlight('@operator', { fg = colors.light_gray }) -- Operators

  -- Punctuation
  highlight('@punctuation.delimiter', { fg = colors.light_gray }) -- Delimiters (;, ,, :)
  highlight('@punctuation.bracket', { fg = colors.light_gray }) -- Brackets ((), [], {})
  highlight('@punctuation.special', { fg = colors.light_gray }) -- Special punctuation

  -- Types
  highlight('@type', { fg = colors.dark_orange }) -- Type names
  highlight('@type.builtin', { fg = colors.dark_orange }) -- Built-in types
  highlight('@type.definition', { fg = colors.dark_orange }) -- Type definitions
  highlight('@type.qualifier', { fg = colors.dark_orange }) -- Type qualifiers (const, static)

  -- Properties and fields
  highlight('@property', { fg = colors.gold }) -- Properties
  highlight('@field', { fg = colors.gold }) -- Fields

  -- Attributes and annotations
  highlight('@attribute', { fg = colors.yellow }) -- Attributes/decorators
  highlight('@annotation', { fg = colors.yellow }) -- Annotations

  -- Namespaces and modules
  highlight('@namespace', { fg = colors.orange }) -- Namespaces
  highlight('@module', { fg = colors.orange }) -- Modules

  -- Tags (HTML/XML)
  highlight('@tag', { fg = colors.basically_white }) -- Tags
  highlight('@tag.attribute', { fg = colors.orange }) -- Tag attributes
  highlight('@tag.delimiter', { fg = colors.light_orange }) -- Tag delimiters (<, >, />)

  -- Labels
  highlight('@label', { fg = colors.light_gray }) -- Labels

  -- Special
  highlight('@none', {}) -- No highlighting
  highlight('@conceal', { link = 'Conceal' }) -- Concealed text

  -- Markup (Markdown, etc.)
  highlight('@markup.strong', { fg = colors.bright_orange, style = 'bold' }) -- Bold
  highlight('@markup.italic', { fg = colors.light_orange, style = 'italic' }) -- Italic
  highlight('@markup.underline', { style = 'underline' }) -- Underline
  highlight('@markup.strike', { style = 'strikethrough' }) -- Strikethrough
  highlight('@markup.heading', { fg = colors.basically_white, style = 'bold' }) -- Headings
  highlight('@markup.heading.1', { fg = colors.basically_white, style = 'bold' }) -- H1
  highlight('@markup.heading.2', { fg = colors.light_gray, style = 'bold' }) -- H2
  highlight('@markup.heading.3', { fg = colors.grey_white, style = 'bold' }) -- H3
  highlight('@markup.heading.4', { fg = colors.gold, style = 'bold' }) -- H4
  highlight('@markup.heading.5', { fg = colors.yellow, style = 'bold' }) -- H5
  highlight('@markup.heading.6', { fg = colors.green, style = 'bold' }) -- H6
  highlight('@markup.quote', { fg = colors.gray_light, style = 'italic' }) -- Quotes
  highlight('@markup.math', { fg = colors.orange }) -- Math
  highlight('@markup.link', { fg = colors.yellow, style = 'underline' }) -- Links
  highlight('@markup.link.label', { fg = colors.yellow }) -- Link labels
  highlight('@markup.link.url', { fg = colors.yellow, style = 'underline' }) -- Link URLs
  highlight('@markup.raw', { fg = colors.green }) -- Raw/code blocks
  highlight('@markup.raw.block', { fg = colors.green }) -- Code blocks
  highlight('@markup.list', { fg = colors.light_gray }) -- List markers
  highlight('@markup.list.checked', { fg = colors.green }) -- Checked list items
  highlight('@markup.list.unchecked', { fg = colors.dark_orange }) -- Unchecked list items

  -- Diff
  highlight('@diff.plus', { fg = colors.green }) -- Added lines
  highlight('@diff.minus', { fg = colors.reddish }) -- Removed lines
  highlight('@diff.delta', { fg = colors.amber }) -- Changed lines

  -- ============================================================================
  -- 7. LSP SEMANTIC TOKENS
  -- ============================================================================
  -- LSP provides additional semantic information about code

  -- Classes and types
  highlight('@lsp.type.class', { fg = colors.teal }) -- Classes
  highlight('@lsp.type.decorator', { fg = colors.yellow }) -- Decorators
  highlight('@lsp.type.enum', { fg = colors.teal }) -- Enums
  highlight('@lsp.type.enumMember', { fg = colors.orange }) -- Enum members
  highlight('@lsp.type.function', { fg = colors.yellow }) -- Functions
  highlight('@lsp.type.interface', { fg = colors.teal }) -- Interfaces
  highlight('@lsp.type.macro', { fg = colors.basically_white }) -- Macros
  highlight('@lsp.type.method', { fg = colors.yellow }) -- Methods
  highlight('@lsp.type.namespace', { fg = colors.teal }) -- Namespaces
  highlight('@lsp.type.parameter', { fg = colors.gold }) -- Parameters
  highlight('@lsp.type.property', { fg = colors.gold }) -- Properties
  highlight('@lsp.type.struct', { fg = colors.teal }) -- Structs
  highlight('@lsp.type.type', { fg = colors.teal }) -- Types
  highlight('@lsp.type.typeParameter', { fg = colors.teal }) -- Type parameters
  highlight('@lsp.type.variable', { fg = colors.light_orange }) -- Variables

  -- Modifiers
  highlight('@lsp.mod.readonly', { fg = colors.orange }) -- Readonly
  highlight('@lsp.mod.deprecated', { fg = colors.gray, style = 'strikethrough' }) -- Deprecated
  highlight('@lsp.mod.static', { fg = colors.light_gray }) -- Static

  -- ============================================================================
  -- 8. PLUGIN INTEGRATION
  -- ============================================================================
  -- Highlights for popular Neovim plugins

  -- Git signs (gitsigns.nvim)
  highlight('GitSignsAdd', { fg = colors.green }) -- Added lines
  highlight('GitSignsChange', { fg = colors.amber }) -- Changed lines
  highlight('GitSignsDelete', { fg = colors.reddish }) -- Deleted lines

  -- Telescope (telescope.nvim)
  highlight('TelescopeBorder', { fg = colors.gray }) -- Border
  highlight('TelescopeSelection', { fg = colors.bright_orange, bg = colors.bg_light, style = 'bold' }) -- Selected item
  highlight('TelescopeSelectionCaret', { fg = colors.light_gray }) -- Selection caret
  highlight('TelescopeMultiSelection', { fg = colors.basically_white }) -- Multi-selection
  highlight('TelescopeMatching', { fg = colors.basically_white, style = 'bold' }) -- Matching text
  highlight('TelescopePromptPrefix', { fg = colors.light_gray }) -- Prompt prefix

  -- Neo-tree (neo-tree.nvim)
  highlight('NeoTreeDirectoryIcon', { fg = colors.light_gray }) -- Directory icon
  highlight('NeoTreeDirectoryName', { fg = colors.light_gray }) -- Directory name
  highlight('NeoTreeFileName', { fg = colors.light_orange }) -- File name
  highlight('NeoTreeFileIcon', { fg = colors.dark_orange }) -- File icon
  highlight('NeoTreeGitAdded', { fg = colors.green }) -- Git added
  highlight('NeoTreeGitModified', { fg = colors.amber }) -- Git modified
  highlight('NeoTreeGitDeleted', { fg = colors.reddish }) -- Git deleted
  highlight('NeoTreeGitUntracked', { fg = colors.gray_light }) -- Git untracked

  -- Which-key (which-key.nvim)
  highlight('WhichKey', { fg = colors.basically_white }) -- Key
  highlight('WhichKeyGroup', { fg = colors.light_gray }) -- Group
  highlight('WhichKeyDesc', { fg = colors.light_orange }) -- Description
  highlight('WhichKeySeparator', { fg = colors.gray }) -- Separator
  highlight('WhichKeyFloat', { bg = colors.bg_dark }) -- Float background

  -- Diagnostics (built-in LSP)
  highlight('DiagnosticError', { fg = colors.reddish }) -- Error
  highlight('DiagnosticWarn', { fg = colors.amber }) -- Warning
  highlight('DiagnosticInfo', { fg = colors.info_green }) -- Info
  highlight('DiagnosticHint', { fg = colors.yellow }) -- Hint
  highlight('DiagnosticUnderlineError', { sp = colors.reddish, style = 'undercurl' }) -- Error underline
  highlight('DiagnosticUnderlineWarn', { sp = colors.amber, style = 'undercurl' }) -- Warning underline
  highlight('DiagnosticUnderlineInfo', { sp = colors.info_green, style = 'undercurl' }) -- Info underline
  highlight('DiagnosticUnderlineHint', { sp = colors.yellow, style = 'undercurl' }) -- Hint underline

  -- Completion (blink.cmp / nvim-cmp)
  highlight('CmpItemAbbrMatch', { fg = colors.basically_white, style = 'bold' }) -- Matching text
  highlight('CmpItemAbbrMatchFuzzy', { fg = colors.light_gray }) -- Fuzzy matching
  highlight('CmpItemKindFunction', { fg = colors.yellow }) -- Function item
  highlight('CmpItemKindMethod', { fg = colors.yellow }) -- Method item
  highlight('CmpItemKindVariable', { fg = colors.light_orange }) -- Variable item
  highlight('CmpItemKindKeyword', { fg = colors.basically_white }) -- Keyword item
  highlight('CmpItemKindClass', { fg = colors.teal }) -- Class item
  highlight('CmpItemKindInterface', { fg = colors.teal }) -- Interface item
  highlight('CmpItemKindText', { fg = colors.light_orange }) -- Text item

  -- Indent guides (indent-blankline.nvim)
  -- Old version (v2)
  highlight('IndentBlanklineChar', { fg = colors.gray_dark }) -- Indent line
  highlight('IndentBlanklineContextChar', { fg = colors.gray }) -- Context indent line
  -- New version (v3+)
  highlight('IblIndent', { fg = colors.gray_dark }) -- Indent line
  highlight('IblScope', { fg = colors.gray }) -- Active scope indent line

  -- Todo comments (todo-comments.nvim)
  highlight('TodoFgTODO', { fg = colors.basically_white }) -- TODO
  highlight('TodoBgTODO', { fg = colors.bg_black, bg = colors.basically_white }) -- TODO background
  highlight('TodoFgFIX', { fg = colors.reddish }) -- FIX/FIXME
  highlight('TodoBgFIX', { fg = colors.bg_black, bg = colors.reddish }) -- FIX background
  highlight('TodoFgNOTE', { fg = colors.yellow }) -- NOTE
  highlight('TodoBgNOTE', { fg = colors.bg_black, bg = colors.yellow }) -- NOTE background
  highlight('TodoFgWARN', { fg = colors.amber }) -- WARN/WARNING
  highlight('TodoBgWARN', { fg = colors.bg_black, bg = colors.amber }) -- WARN background

  -- Debugging (nvim-dap)
  highlight('DapBreakpoint', { fg = colors.reddish }) -- Breakpoint
  highlight('DapStopped', { fg = colors.green }) -- Stopped line
  highlight('DapLogPoint', { fg = colors.yellow }) -- Log point
end

-- ============================================================================
-- SETUP AND RETURN
-- ============================================================================

-- Auto-load the colorscheme when this module is required
M.load()

return M
