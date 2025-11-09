-- ============================================================================
-- Grayscale - A Minimal Grayscale Neovim Colorscheme
-- ============================================================================
-- A minimal grayscale colorscheme with no bold/italic, uniform gray text,
-- and colored diagnostics.

local M = {}

-- ============================================================================
-- COLOR PALETTE
-- ============================================================================
local colors = {
  -- Backgrounds
  bg_black = '#a3a3a3', -- Pure black main background
  bg_dark = '#787878', -- Dark gray for cursor line
  bg_light = '#606060', -- Lighter gray for selections
  bg_highlight = '#303030', -- Highlighted backgrounds

  -- Main text - all code in same gray
  text_gray = '#1c1c1c', -- Main text color (silver)

  -- Primitives & comments - distinguishable grays
  string_gray = '#000000', -- Strings (white)
  comment_gray = '#1c1c1c', -- Comments (darker gray)

  -- Borders
  subtle_gray = '#d9d9d9', -- Borders
  border_gray = '#f0f0f0', -- Subtle elements

  -- Diagnostics (colored)
  error_red = '#ff0000', -- Errors
  warn_orange = '#ffa500', -- Warnings
  info_blue = '#00bfff', -- Info
  hint_gray = '#a0a0a0', -- Hints (gray)

  -- Git
  git_add = '#90ee90', -- Git additions (light green)
  git_change = '#00bfff', -- Git changes (yellow)
  git_delete = '#ff6b6b', -- Git deletions (light red)
}

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

--- Set a highlight group
--- @param group string The highlight group name
--- @param opts table Table containing fg, bg, sp, and style attributes
local function highlight(group, opts)
  local cmd = 'highlight ' .. group

  if opts.fg then
    cmd = cmd .. ' guifg=' .. opts.fg
  end

  if opts.bg then
    cmd = cmd .. ' guibg=' .. opts.bg
  end

  if opts.sp then
    cmd = cmd .. ' guisp=' .. opts.sp
  end

  if opts.style then
    cmd = cmd .. ' gui=' .. opts.style
  end

  if opts.link then
    cmd = 'highlight! link ' .. group .. ' ' .. opts.link
    vim.cmd(cmd)
    return
  end

  vim.cmd(cmd)
end

--- Load the colorscheme
function M.load()
  -- Reset existing highlighting
  if vim.g.colors_name then
    vim.cmd 'highlight clear'
  end

  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  vim.g.colors_name = 'lightgrayscale'
  vim.o.termguicolors = true

  -- ============================================================================
  -- TERMINAL COLORS
  -- ============================================================================
  vim.g.terminal_color_0 = colors.bg_black
  vim.g.terminal_color_1 = colors.error_red
  vim.g.terminal_color_2 = colors.git_add
  vim.g.terminal_color_3 = colors.git_change
  vim.g.terminal_color_4 = colors.info_blue
  vim.g.terminal_color_5 = colors.text_gray
  vim.g.terminal_color_6 = colors.text_gray
  vim.g.terminal_color_7 = colors.text_gray
  vim.g.terminal_color_8 = colors.comment_gray
  vim.g.terminal_color_9 = colors.error_red
  vim.g.terminal_color_10 = colors.git_add
  vim.g.terminal_color_11 = colors.git_change
  vim.g.terminal_color_12 = colors.info_blue
  vim.g.terminal_color_13 = colors.text_gray
  vim.g.terminal_color_14 = colors.text_gray
  vim.g.terminal_color_15 = colors.string_gray

  -- ============================================================================
  -- EDITOR UI
  -- ============================================================================

  -- Base UI
  highlight('Normal', { fg = colors.text_gray, bg = colors.bg_black })
  highlight('NormalFloat', { fg = colors.text_gray, bg = colors.bg_dark })
  highlight('NormalNC', { fg = colors.text_gray, bg = colors.bg_black })

  -- Cursor and lines
  highlight('Cursor', { fg = colors.bg_black, bg = colors.string_gray })
  highlight('CursorLine', { bg = colors.bg_dark })
  highlight('CursorLineNr', { fg = colors.bg_black, bg = colors.text_gray })
  highlight('LineNr', { fg = colors.subtle_gray })
  highlight('CursorColumn', { bg = colors.bg_dark })

  -- Selection and search (inverted: dark text on light background)
  highlight('Visual', { fg = colors.bg_black, bg = colors.text_gray })
  highlight('VisualNOS', { fg = colors.bg_black, bg = colors.text_gray })
  highlight('Search', { fg = colors.bg_black, bg = colors.border_gray })
  highlight('IncSearch', { fg = colors.bg_black, bg = colors.string_gray })
  highlight('CurSearch', { fg = colors.bg_black, bg = colors.string_gray })

  -- Status line and tab line
  highlight('StatusLine', { fg = colors.text_gray, bg = colors.bg_light })
  highlight('StatusLineNC', { fg = colors.border_gray, bg = colors.bg_dark })
  highlight('TabLine', { fg = colors.border_gray, bg = colors.bg_dark })
  highlight('TabLineFill', { bg = colors.bg_dark })
  highlight('TabLineSel', { fg = colors.bg_black, bg = colors.text_gray })

  -- Columns and separators
  highlight('ColorColumn', { bg = colors.bg_light })
  highlight('SignColumn', { bg = colors.bg_black })
  highlight('VertSplit', { fg = colors.border_gray })
  highlight('WinSeparator', { fg = colors.border_gray })

  -- Folds
  highlight('Folded', { fg = colors.border_gray, bg = colors.bg_light })
  highlight('FoldColumn', { fg = colors.border_gray, bg = colors.bg_black })

  -- Messages and prompts
  highlight('MsgArea', { fg = colors.text_gray, bg = colors.bg_black })
  highlight('ModeMsg', { fg = colors.info_blue })
  highlight('MoreMsg', { fg = colors.info_blue })
  highlight('ErrorMsg', { fg = colors.error_red })
  highlight('WarningMsg', { fg = colors.warn_orange })
  highlight('Question', { fg = colors.info_blue })

  -- Popup menu
  highlight('Pmenu', { fg = colors.text_gray, bg = colors.bg_dark })
  highlight('PmenuSel', { fg = colors.bg_black, bg = colors.text_gray })
  highlight('PmenuSbar', { bg = colors.bg_light })
  highlight('PmenuThumb', { bg = colors.border_gray })

  -- Diff highlighting
  highlight('DiffAdd', { fg = colors.git_add, bg = colors.bg_dark })
  highlight('DiffChange', { fg = colors.git_change, bg = colors.bg_dark })
  highlight('DiffDelete', { fg = colors.git_delete, bg = colors.bg_dark })
  highlight('DiffText', { fg = colors.git_change, bg = colors.bg_dark })

  -- Spell checking
  highlight('SpellBad', { sp = colors.error_red, style = 'undercurl' })
  highlight('SpellCap', { sp = colors.warn_orange, style = 'undercurl' })
  highlight('SpellLocal', { sp = colors.info_blue, style = 'undercurl' })
  highlight('SpellRare', { sp = colors.hint_gray, style = 'undercurl' })

  -- Special UI elements
  highlight('Directory', { fg = colors.text_gray })
  highlight('Title', { fg = colors.text_gray })
  highlight('SpecialKey', { fg = colors.subtle_gray })
  highlight('NonText', { fg = colors.subtle_gray })
  highlight('Whitespace', { fg = colors.bg_dark })
  highlight('Conceal', { fg = colors.subtle_gray })
  highlight('MatchParen', { fg = colors.bg_black, bg = colors.string_gray })
  highlight('WildMenu', { fg = colors.bg_black, bg = colors.text_gray })

  -- ============================================================================
  -- SYNTAX HIGHLIGHTS
  -- ============================================================================

  -- Comments: Darker gray
  highlight('Comment', { fg = colors.comment_gray, style = 'italic' })
  highlight('SpecialComment', { fg = colors.comment_gray, style = 'italic' })

  -- Constants
  highlight('Constant', { fg = colors.text_gray })
  highlight('String', { fg = colors.string_gray }) -- Primitive (white)
  highlight('Character', { fg = colors.string_gray }) -- Primitive (white)
  highlight('Number', { fg = colors.string_gray }) -- Primitive (white)
  highlight('Boolean', { fg = colors.string_gray }) -- Primitive (white)
  highlight('Float', { fg = colors.string_gray }) -- Primitive (white)

  -- Identifiers
  highlight('Identifier', { fg = colors.text_gray })
  highlight('Function', { fg = colors.text_gray })

  -- Statements
  highlight('Statement', { fg = colors.text_gray })
  highlight('Conditional', { fg = colors.text_gray })
  highlight('Repeat', { fg = colors.text_gray })
  highlight('Label', { fg = colors.text_gray })
  highlight('Operator', { fg = colors.text_gray })
  highlight('Keyword', { fg = colors.text_gray })
  highlight('Exception', { fg = colors.text_gray })

  -- Preprocessor
  highlight('PreProc', { fg = colors.text_gray })
  highlight('Include', { fg = colors.text_gray })
  highlight('Define', { fg = colors.text_gray })
  highlight('Macro', { fg = colors.text_gray })
  highlight('PreCondit', { fg = colors.text_gray })

  -- Types
  highlight('Type', { fg = colors.text_gray })
  highlight('StorageClass', { fg = colors.text_gray })
  highlight('Structure', { fg = colors.text_gray })
  highlight('Typedef', { fg = colors.text_gray })

  -- Special
  highlight('Special', { fg = colors.text_gray })
  highlight('SpecialChar', { fg = colors.string_gray })
  highlight('Tag', { fg = colors.text_gray })
  highlight('Delimiter', { fg = colors.text_gray })
  highlight('Debug', { fg = colors.error_red })

  -- Other
  highlight('Underlined', { fg = colors.text_gray, style = 'underline' })
  highlight('Ignore', { fg = colors.subtle_gray })
  highlight('Error', { fg = colors.error_red, bg = colors.bg_dark })
  highlight('Todo', { fg = colors.info_blue, bg = colors.bg_dark })

  -- ============================================================================
  -- TREESITTER HIGHLIGHTS
  -- ============================================================================

  -- Text
  highlight('@text', { fg = colors.text_gray })
  highlight('@text.strong', { fg = colors.text_gray })
  highlight('@text.emphasis', { fg = colors.text_gray })
  highlight('@text.underline', { style = 'underline' })
  highlight('@text.strike', { style = 'strikethrough' })
  highlight('@text.title', { fg = colors.text_gray })
  highlight('@text.literal', { fg = colors.string_gray })
  highlight('@text.uri', { fg = colors.text_gray, style = 'underline' })
  highlight('@text.math', { fg = colors.string_gray })
  highlight('@text.reference', { fg = colors.text_gray })
  highlight('@text.environment', { fg = colors.text_gray })
  highlight('@text.environment.name', { fg = colors.text_gray })

  -- Comments
  highlight('@comment', { fg = colors.comment_gray })
  highlight('@comment.documentation', { fg = colors.comment_gray })
  highlight('@comment.error', { fg = colors.error_red })
  highlight('@comment.warning', { fg = colors.warn_orange })
  highlight('@comment.todo', { fg = colors.warn_orange })
  highlight('@comment.note', { fg = colors.info_blue })

  -- Constants
  highlight('@constant', { fg = colors.text_gray })
  highlight('@constant.builtin', { fg = colors.text_gray })
  highlight('@constant.macro', { fg = colors.text_gray })

  -- Strings and characters (white)
  highlight('@string', { fg = colors.string_gray })
  highlight('@string.regex', { fg = colors.string_gray })
  highlight('@string.escape', { fg = colors.string_gray })
  highlight('@string.special', { fg = colors.string_gray })
  highlight('@character', { fg = colors.string_gray })
  highlight('@character.special', { fg = colors.string_gray })

  -- Numbers (white)
  highlight('@number', { fg = colors.string_gray })
  highlight('@number.float', { fg = colors.string_gray })

  -- Booleans (white)
  highlight('@boolean', { fg = colors.string_gray })

  -- Functions
  highlight('@function', { fg = colors.text_gray })
  highlight('@function.builtin', { fg = colors.text_gray })
  highlight('@function.call', { fg = colors.text_gray })
  highlight('@function.macro', { fg = colors.text_gray })
  highlight('@method', { fg = colors.text_gray })
  highlight('@method.call', { fg = colors.text_gray })
  highlight('@constructor', { fg = colors.text_gray })

  -- Parameters and variables
  highlight('@parameter', { fg = colors.text_gray })
  highlight('@parameter.reference', { fg = colors.text_gray })
  highlight('@variable', { fg = colors.text_gray })
  highlight('@variable.builtin', { fg = colors.text_gray })
  highlight('@variable.parameter', { fg = colors.text_gray })
  highlight('@variable.member', { fg = colors.text_gray })

  -- Keywords
  highlight('@keyword', { fg = colors.text_gray })
  highlight('@keyword.function', { fg = colors.text_gray })
  highlight('@keyword.operator', { fg = colors.text_gray })
  highlight('@keyword.return', { fg = colors.text_gray })
  highlight('@keyword.conditional', { fg = colors.text_gray })
  highlight('@keyword.repeat', { fg = colors.text_gray })
  highlight('@keyword.import', { fg = colors.text_gray })
  highlight('@keyword.exception', { fg = colors.text_gray })

  -- Operators
  highlight('@operator', { fg = colors.text_gray })

  -- Punctuation
  highlight('@punctuation.delimiter', { fg = colors.text_gray })
  highlight('@punctuation.bracket', { fg = colors.text_gray })
  highlight('@punctuation.special', { fg = colors.text_gray })

  -- Types
  highlight('@type', { fg = colors.text_gray })
  highlight('@type.builtin', { fg = colors.text_gray })
  highlight('@type.definition', { fg = colors.text_gray })
  highlight('@type.qualifier', { fg = colors.text_gray })

  -- Properties and fields
  highlight('@property', { fg = colors.text_gray })
  highlight('@field', { fg = colors.text_gray })

  -- Attributes and annotations
  highlight('@attribute', { fg = colors.text_gray })
  highlight('@annotation', { fg = colors.text_gray })

  -- Namespaces and modules
  highlight('@namespace', { fg = colors.text_gray })
  highlight('@module', { fg = colors.text_gray })

  -- Tags (HTML/XML/JSX)
  highlight('@tag', { fg = colors.text_gray })
  highlight('@tag.attribute', { fg = colors.text_gray })
  highlight('@tag.delimiter', { fg = colors.text_gray })

  -- Labels
  highlight('@label', { fg = colors.text_gray })

  -- Special
  highlight('@conceal', { link = 'Conceal' })

  -- Markup (Markdown)
  highlight('@markup.strong', { fg = colors.text_gray })
  highlight('@markup.italic', { fg = colors.text_gray })
  highlight('@markup.underline', { style = 'underline' })
  highlight('@markup.strike', { style = 'strikethrough' })
  highlight('@markup.heading', { fg = colors.text_gray })
  highlight('@markup.heading.1', { fg = colors.text_gray })
  highlight('@markup.heading.2', { fg = colors.text_gray })
  highlight('@markup.heading.3', { fg = colors.text_gray })
  highlight('@markup.heading.4', { fg = colors.text_gray })
  highlight('@markup.heading.5', { fg = colors.text_gray })
  highlight('@markup.heading.6', { fg = colors.text_gray })
  highlight('@markup.quote', { fg = colors.text_gray })
  highlight('@markup.math', { fg = colors.string_gray })
  highlight('@markup.link', { fg = colors.text_gray, style = 'underline' })
  highlight('@markup.link.label', { fg = colors.text_gray })
  highlight('@markup.link.url', { fg = colors.text_gray, style = 'underline' })
  highlight('@markup.raw', { fg = colors.string_gray })
  highlight('@markup.raw.block', { fg = colors.string_gray })
  highlight('@markup.list', { fg = colors.text_gray })
  highlight('@markup.list.checked', { fg = colors.text_gray })
  highlight('@markup.list.unchecked', { fg = colors.text_gray })

  -- Diff
  highlight('@diff.plus', { fg = colors.git_add })
  highlight('@diff.minus', { fg = colors.git_delete })
  highlight('@diff.delta', { fg = colors.git_change })

  -- ============================================================================
  -- LSP SEMANTIC TOKENS
  -- ============================================================================

  -- Base LSP group (must be defined for typemod fallbacks)
  highlight('@lsp', {})

  -- All LSP types in text_gray (no italic)
  highlight('@lsp.type.class', { fg = colors.text_gray })
  highlight('@lsp.type.enum', { fg = colors.text_gray })
  highlight('@lsp.type.interface', { fg = colors.text_gray })
  highlight('@lsp.type.struct', { fg = colors.text_gray })
  highlight('@lsp.type.record', { fg = colors.text_gray })
  highlight('@lsp.type.type', { fg = colors.text_gray })
  highlight('@lsp.type.typeParameter', { fg = colors.text_gray })

  -- Non-type semantic tokens
  highlight('@lsp.type.decorator', { fg = colors.text_gray })
  highlight('@lsp.type.enumMember', { fg = colors.text_gray })
  highlight('@lsp.type.function', { fg = colors.text_gray })
  highlight('@lsp.type.macro', { fg = colors.text_gray })
  highlight('@lsp.type.method', { fg = colors.text_gray })
  highlight('@lsp.type.namespace', { fg = colors.text_gray })
  highlight('@lsp.type.parameter', { fg = colors.text_gray })
  highlight('@lsp.type.property', { fg = colors.text_gray })
  highlight('@lsp.type.variable', { fg = colors.text_gray })

  -- Modifiers
  highlight('@lsp.mod.deprecated', { style = 'strikethrough' })

  -- Declarations (no bold)
  highlight('@lsp.typemod.class.declaration', { fg = colors.text_gray })
  highlight('@lsp.typemod.enum.declaration', { fg = colors.text_gray })
  highlight('@lsp.typemod.record.declaration', { fg = colors.text_gray })
  highlight('@lsp.typemod.interface.declaration', { fg = colors.text_gray })
  highlight('@lsp.typemod.struct.declaration', { fg = colors.text_gray })
  highlight('@lsp.typemod.method.declaration', { fg = colors.text_gray })
  highlight('@lsp.typemod.function.declaration', { fg = colors.text_gray })

  -- Static declarations
  highlight('@lsp.typemod.class.static', { fg = colors.text_gray })
  highlight('@lsp.typemod.enum.static', { fg = colors.text_gray })
  highlight('@lsp.typemod.record.static', { fg = colors.text_gray })
  highlight('@lsp.typemod.method.static', { fg = colors.text_gray })
  highlight('@lsp.typemod.function.static', { fg = colors.text_gray })

  -- Type + Modifier combinations for enum members
  highlight('@lsp.typemod.enumMember.declaration', { fg = colors.text_gray })
  highlight('@lsp.typemod.enumMember.readonly', { fg = colors.text_gray })
  highlight('@lsp.typemod.enumMember.static', { fg = colors.text_gray })
  highlight('@lsp.typemod.enumMember.public', { fg = colors.text_gray })

  -- LSP document highlights (word under cursor)
  highlight('LspReferenceText', { fg = colors.bg_dark, bg = colors.text_gray })
  highlight('LspReferenceRead', { fg = colors.bg_dark, bg = colors.text_gray })
  highlight('LspReferenceWrite', { fg = colors.bg_dark, bg = colors.text_gray })

  -- ============================================================================
  -- PLUGIN INTEGRATION
  -- ============================================================================

  -- Git signs
  highlight('GitSignsAdd', { fg = colors.git_add })
  highlight('GitSignsChange', { fg = colors.git_change })
  highlight('GitSignsDelete', { fg = colors.git_delete })

  -- Telescope
  highlight('TelescopeBorder', { fg = colors.border_gray })
  highlight('TelescopeSelection', { fg = colors.bg_black, bg = colors.text_gray })
  highlight('TelescopeSelectionCaret', { fg = colors.bg_black })
  highlight('TelescopeMultiSelection', { fg = colors.bg_black, bg = colors.border_gray })
  highlight('TelescopeMatching', { fg = colors.string_gray })
  highlight('TelescopePromptPrefix', { fg = colors.text_gray })

  -- Neo-tree
  highlight('NeoTreeDirectoryIcon', { fg = colors.text_gray })
  highlight('NeoTreeDirectoryName', { fg = colors.text_gray })
  highlight('NeoTreeFileName', { fg = colors.text_gray })
  highlight('NeoTreeFileIcon', { fg = colors.border_gray })
  highlight('NeoTreeGitAdded', { fg = colors.git_add })
  highlight('NeoTreeGitModified', { fg = colors.git_change })
  highlight('NeoTreeGitDeleted', { fg = colors.git_delete })
  highlight('NeoTreeGitUntracked', { fg = colors.border_gray })

  -- Which-key
  highlight('WhichKey', { fg = colors.text_gray })
  highlight('WhichKeyGroup', { fg = colors.text_gray })
  highlight('WhichKeyDesc', { fg = colors.text_gray })
  highlight('WhichKeySeparator', { fg = colors.border_gray })
  highlight('WhichKeyFloat', { bg = colors.bg_dark })

  -- Diagnostics: errors red, warnings orange, info blue
  highlight('DiagnosticError', { fg = colors.error_red })
  highlight('DiagnosticWarn', { fg = colors.warn_orange })
  highlight('DiagnosticInfo', { fg = colors.info_blue })
  highlight('DiagnosticHint', { fg = colors.hint_gray })
  highlight('DiagnosticUnderlineError', { sp = colors.error_red, style = 'undercurl' })
  highlight('DiagnosticUnderlineWarn', { sp = colors.warn_orange, style = 'undercurl' })
  highlight('DiagnosticUnderlineInfo', { sp = colors.info_blue, style = 'undercurl' })
  highlight('DiagnosticUnderlineHint', { sp = colors.hint_gray, style = 'undercurl' })

  -- Completion
  highlight('CmpItemAbbrMatch', { fg = colors.bg_black, bg = colors.string_gray })
  highlight('CmpItemAbbrMatchFuzzy', { fg = colors.bg_black, bg = colors.border_gray })
  highlight('CmpItemKindFunction', { fg = colors.text_gray })
  highlight('CmpItemKindMethod', { fg = colors.text_gray })
  highlight('CmpItemKindVariable', { fg = colors.text_gray })
  highlight('CmpItemKindKeyword', { fg = colors.text_gray })
  highlight('CmpItemKindClass', { fg = colors.text_gray })
  highlight('CmpItemKindInterface', { fg = colors.text_gray })
  highlight('CmpItemKindText', { fg = colors.text_gray })

  -- Indent guides
  highlight('IndentBlanklineChar', { fg = colors.bg_dark })
  highlight('IndentBlanklineContextChar', { fg = colors.subtle_gray })
  highlight('IblIndent', { fg = colors.bg_dark })
  highlight('IblScope', { fg = colors.subtle_gray })

  -- Todo comments
  highlight('TodoFgTODO', { fg = colors.info_blue })
  highlight('TodoBgTODO', { fg = colors.bg_black, bg = colors.warn_orange })
  highlight('TodoFgFIX', { fg = colors.error_red })
  highlight('TodoBgFIX', { fg = colors.bg_black, bg = colors.error_red })
  highlight('TodoFgNOTE', { fg = colors.info_blue })
  highlight('TodoBgNOTE', { fg = colors.bg_black, bg = colors.info_blue })
  highlight('TodoFgWARN', { fg = colors.warn_orange })
  highlight('TodoBgWARN', { fg = colors.bg_black, bg = colors.warn_orange })

  -- Debugging
  highlight('DapBreakpoint', { fg = colors.error_red })
  highlight('DapStopped', { fg = colors.git_add })
  highlight('DapLogPoint', { fg = colors.text_gray })
end

-- Load the colorscheme
M.load()

return M
