-- ============================================================================
-- No Blue-
-- ============================================================================

local M = {}

-- ============================================================================
-- COLOR PALETTE
-- ============================================================================
local colors = {
  -- Backgrounds: Black to grayish black
  bg_black = '#000000', -- Pure black main background
  bg_dark = '#303030', -- Dark gray for cursor line
  bg_light = '#4a4a4a', -- Lighter gray for selections
  bg_lighter = '#949494', -- Even lighter
  bg_highlight = '#d4d4d4', -- Highlighted backgrounds

  -- Orange spectrum for code
  red_orange = '#ff6a00',
  orange = '#ff8000', -- Dark orange for types
  faint_orange = '#b35900', -- Faint orange for brackets, non-control keywords, comments

  -- Grays for subtle elements
  gray = '#3a3a3a', -- Subtle gray
  gray_dark = '#2a2a2a', -- Dark gray for floats
  gray_light = '#4a4a4a', -- Light gray

  -- Borders: Whiteish gray/silver
  light_gray = '#d4d4d4', -- Light gray border
  silver = '#a8a8a8', -- Silver border
  grey_white = '#e8e8e8', -- Almost white
  basically_white = '#e8e8e8', -- White-ish

  -- Blues (minimal usage)
  dark_blue = '#02007a', -- Dark blue
  blue = '#0400ff', -- Blue
  info_green = '#138c00', -- Info messages
  light_blue = '#3bc4ff', -- Warnings
  pink = '#f53bff', -- Errors

  -- Primitives and git
  green = '#a9ff09', -- Git additions, success
  -- Alerts
  reddish = '#ff6b9c', -- amber
  red_dark = '#ff0000', -- Git deletions
  amber = '#ffd86e', -- Amber
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
    pcall(vim.cmd, cmd)
    return
  end

  pcall(vim.cmd, cmd)
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

  vim.g.colors_name = 'noblue'
  vim.o.termguicolors = true

  -- Set cursor shape and color
  vim.opt.guicursor = {
    'n-v-c:block-Cursor/lCursor',
    'i-ci-ve:ver25-Cursor/lCursor',
    'r-cr:hor20-Cursor/lCursor',
    'o:hor50-Cursor/lCursor',
    'a:blinkwait700-blinkoff400-blinkon250',
  }

  -- ============================================================================
  -- TERMINAL COLORS
  -- ============================================================================
  vim.g.terminal_color_0 = colors.bg_black
  vim.g.terminal_color_1 = colors.red_dark
  vim.g.terminal_color_2 = colors.green
  vim.g.terminal_color_3 = colors.silver
  vim.g.terminal_color_4 = colors.orange
  vim.g.terminal_color_5 = colors.pink
  vim.g.terminal_color_6 = colors.orange
  vim.g.terminal_color_7 = colors.light_gray
  vim.g.terminal_color_8 = colors.gray
  vim.g.terminal_color_9 = colors.red_dark
  vim.g.terminal_color_10 = colors.green
  vim.g.terminal_color_11 = colors.silver
  vim.g.terminal_color_12 = colors.orange
  vim.g.terminal_color_13 = colors.pink
  vim.g.terminal_color_14 = colors.orange
  vim.g.terminal_color_15 = colors.grey_white

  -- ============================================================================
  -- EDITOR UI
  -- ============================================================================

  -- Base UI
  highlight('Normal', { fg = colors.light_gray, bg = colors.bg_black })
  highlight('NormalFloat', { fg = colors.light_gray, bg = colors.bg_dark })
  highlight('NormalNC', { fg = colors.light_gray, bg = colors.bg_black })

  -- Cursor and lines

  highlight('TermCursor', { fg = colors.basically_white, bg = colors.orange })
  highlight('Cursor', { fg = colors.basically_white, bg = colors.orange })
  highlight('lCursor', { fg = colors.basically_white, bg = colors.orange })
  highlight('CursorIME', { fg = colors.basically_white, bg = colors.orange })
  highlight('CursorLine', { bg = colors.bg_dark })
  highlight('CursorLineNr', { fg = colors.orange, style = 'bold' })
  highlight('LineNr', { fg = colors.silver })
  highlight('CursorColumn', { bg = colors.bg_dark })

  -- Selection and search
  highlight('Visual', { bg = colors.gray })
  highlight('VisualNOS', { bg = colors.gray })
  highlight('Search', { bg = colors.orange, fg = colors.bg_black })
  highlight('IncSearch', { bg = colors.orange, fg = colors.bg_black })
  highlight('CurSearch', { bg = colors.orange, fg = colors.bg_black })

  -- Status line and tab line
  highlight('StatusLine', { fg = colors.light_gray, bg = colors.gray })
  highlight('StatusLineNC', { fg = colors.silver, bg = colors.gray_dark })
  highlight('TabLine', { fg = colors.silver, bg = colors.gray_dark })
  highlight('TabLineFill', { bg = colors.gray_dark })
  highlight('TabLineSel', { fg = colors.grey_white, bg = colors.gray, style = 'bold' })

  -- Columns and separators (silver borders)
  highlight('ColorColumn', { bg = colors.gray })
  highlight('SignColumn', { bg = colors.bg_black })
  highlight('VertSplit', { fg = colors.silver })
  highlight('WinSeparator', { fg = colors.silver })

  -- Folds
  highlight('Folded', { fg = colors.silver, bg = colors.gray })
  highlight('FoldColumn', { fg = colors.silver, bg = colors.bg_black })

  -- Messages and prompts
  highlight('MsgArea', { fg = colors.light_gray, bg = colors.bg_dark })
  highlight('ModeMsg', { fg = colors.light_gray, style = 'bold' })
  highlight('MoreMsg', { fg = colors.light_gray })
  highlight('ErrorMsg', { fg = colors.red_dark, style = 'bold' })
  highlight('WarningMsg', { fg = colors.amber, style = 'bold' })
  highlight('Question', { fg = colors.light_blue })

  -- Popup menu
  highlight('Pmenu', { fg = colors.light_gray, bg = colors.bg_dark })
  highlight('PmenuSel', { fg = colors.bg_highlight, bg = colors.bg_dark })
  highlight('PmenuSbar', { bg = colors.gray })
  highlight('PmenuThumb', { bg = colors.silver })

  -- Diff highlighting
  highlight('DiffAdd', { fg = colors.green, bg = colors.gray_dark })
  highlight('DiffChange', { fg = colors.orange, bg = colors.gray_dark })
  highlight('DiffDelete', { fg = colors.red_dark, bg = colors.gray_dark })
  highlight('DiffText', { fg = colors.silver, bg = colors.gray_dark, style = 'bold' })

  -- Spell checking
  highlight('SpellBad', { sp = colors.red_dark, style = 'undercurl' })
  highlight('SpellCap', { sp = colors.light_blue, style = 'undercurl' })
  highlight('SpellLocal', { sp = colors.light_blue, style = 'undercurl' })
  highlight('SpellRare', { sp = colors.light_blue, style = 'undercurl' })

  -- Special UI elements
  highlight('Directory', { fg = colors.orange })
  highlight('Title', { fg = colors.orange, style = 'bold' })
  highlight('SpecialKey', { fg = colors.faint_orange })
  highlight('NonText', { fg = colors.faint_orange })
  highlight('Whitespace', { fg = colors.silver })
  highlight('Conceal', { fg = colors.gray })
  highlight('MatchParen', { fg = colors.orange, style = 'bold' })
  highlight('WildMenu', { fg = colors.bg_black, bg = colors.orange })

  -- ============================================================================
  -- SYNTAX HIGHLIGHTS
  -- ============================================================================

  -- Comments: Faint orange, italic
  highlight('Comment', { fg = colors.faint_orange, style = 'italic' })
  highlight('SpecialComment', { fg = colors.faint_orange, style = 'italic' })

  -- Constants: Types use dark orange
  highlight('Constant', { fg = colors.orange })
  highlight('String', { fg = colors.silver }) -- Primitive
  highlight('Character', { fg = colors.silver }) -- Primitive
  highlight('Number', { fg = colors.silver }) -- Primitive
  highlight('Boolean', { fg = colors.silver }) -- Primitive
  highlight('Float', { fg = colors.silver }) -- Primitive

  -- Identifiers
  highlight('Identifier', { fg = colors.orange }) -- Variables
  highlight('Function', { fg = colors.orange, style = 'bold' }) -- Methods

  -- Statements: Control keywords are red-orange bold
  highlight('Statement', { fg = colors.orange, style = 'bold' })
  highlight('Conditional', { fg = colors.orange, style = 'bold' }) -- if, else, switch
  highlight('Repeat', { fg = colors.orange, style = 'bold' }) -- for, while, loop
  highlight('Label', { fg = colors.orange, style = 'bold' }) -- case, default
  highlight('Operator', { fg = colors.orange, style = 'bold' }) -- Operators
  highlight('Keyword', { fg = colors.faint_orange }) -- Non-control keywords (faint)
  highlight('Exception', { fg = colors.orange, style = 'bold' }) -- try, catch, throw

  -- Preprocessor: Faint for non-control
  highlight('PreProc', { fg = colors.faint_orange })
  highlight('Include', { fg = colors.faint_orange })
  highlight('Define', { fg = colors.faint_orange })
  highlight('Macro', { fg = colors.orange }) -- Annotations
  highlight('PreCondit', { fg = colors.faint_orange })

  -- Types: Dark orange
  highlight('Type', { fg = colors.orange })
  highlight('StorageClass', { fg = colors.faint_orange }) -- static, const (faint)
  highlight('Structure', { fg = colors.orange })
  highlight('Typedef', { fg = colors.orange })

  -- Special
  highlight('Special', { fg = colors.orange })
  highlight('SpecialChar', { fg = colors.orange })
  highlight('Tag', { fg = colors.orange, style = 'bold' }) -- HTML/XML tags
  highlight('Delimiter', { fg = colors.faint_orange }) -- Brackets (faint)
  highlight('Debug', { fg = colors.light_blue })

  -- Other
  highlight('Underlined', { fg = colors.orange, style = 'underline' })
  highlight('Ignore', { fg = colors.gray })
  highlight('Error', { fg = colors.red_dark, bg = colors.gray_dark, style = 'bold' })
  highlight('Todo', { fg = colors.light_blue, bg = colors.gray_dark, style = 'bold,italic' })

  -- ============================================================================
  -- TREESITTER HIGHLIGHTS
  -- ============================================================================

  -- Text
  highlight('@text', { fg = colors.light_gray })
  highlight('@text.strong', { fg = colors.grey_white, style = 'bold' })
  highlight('@text.emphasis', { fg = colors.light_gray, style = 'italic' })
  highlight('@text.underline', { style = 'underline' })
  highlight('@text.strike', { style = 'strikethrough' })
  highlight('@text.title', { fg = colors.orange, style = 'bold' })
  highlight('@text.literal', { fg = colors.silver })
  highlight('@text.uri', { fg = colors.orange, style = 'underline' })
  highlight('@text.math', { fg = colors.silver })
  highlight('@text.reference', { fg = colors.orange })
  highlight('@text.environment', { fg = colors.orange })
  highlight('@text.environment.name', { fg = colors.orange })

  -- Comments: Faint orange, italic
  -- TODO: example
  -- NOTE:
  -- WARNING:
  -- BUG:
  --
  highlight('@comment', { fg = colors.faint_orange, style = 'italic' })
  highlight('@comment.documentation', { fg = colors.faint_orange, style = 'italic' })
  highlight('@comment.error', { fg = colors.red_dark, style = 'bold' })
  highlight('@comment.warning', { fg = colors.amber, style = 'bold' })
  highlight('@comment.todo', { fg = colors.light_blue, style = 'bold,italic' })
  highlight('@comment.note', { fg = colors.light_blue, style = 'bold,italic' })

  -- Constants: Dark orange for named constants
  highlight('@constant', { fg = colors.orange })
  highlight('@constant.builtin', { fg = colors.orange })
  highlight('@constant.macro', { fg = colors.orange })

  -- Strings and characters: silver (primitives)
  highlight('@string', { fg = colors.silver })
  highlight('@string.regex', { fg = colors.silver })
  highlight('@string.escape', { fg = colors.orange })
  highlight('@string.special', { fg = colors.silver })
  highlight('@character', { fg = colors.silver })
  highlight('@character.special', { fg = colors.silver })

  -- Numbers: silver (primitives)
  highlight('@number', { fg = colors.silver })
  highlight('@number.float', { fg = colors.silver })

  -- Booleans: silver (primitives)
  highlight('@boolean', { fg = colors.silver })

  -- Functions: Bright orange, bold
  highlight('@function', { fg = colors.orange, style = 'bold' })
  highlight('@function.builtin', { fg = colors.orange, style = 'bold' })
  highlight('@function.call', { fg = colors.orange, style = 'bold' })
  highlight('@function.macro', { fg = colors.orange })
  highlight('@method', { fg = colors.orange, style = 'bold' })
  highlight('@method.call', { fg = colors.orange, style = 'bold' })
  highlight('@constructor', { fg = colors.orange })

  -- Parameters and variables
  highlight('@parameter', { fg = colors.orange }) -- Parameters (light orange)
  highlight('@parameter.reference', { fg = colors.orange })
  highlight('@variable', { fg = colors.orange }) -- Variables (mid orange)
  highlight('@variable.builtin', { fg = colors.faint_orange })
  highlight('@variable.parameter', { fg = colors.orange })
  highlight('@variable.member', { fg = colors.orange })

  -- Keywords
  highlight('@keyword', { fg = colors.faint_orange }) -- Non-control keywords (faint)
  highlight('@keyword.function', { fg = colors.faint_orange })
  highlight('@keyword.operator', { fg = colors.orange, style = 'bold' }) -- Operator keywords
  highlight('@keyword.return', { fg = colors.orange, style = 'bold' })
  highlight('@keyword.conditional', { fg = colors.orange, style = 'bold' }) -- Control: if, else
  highlight('@keyword.repeat', { fg = colors.orange, style = 'bold' }) -- Control: for, while
  highlight('@keyword.import', { fg = colors.faint_orange })
  highlight('@keyword.exception', { fg = colors.orange, style = 'bold' }) -- Control: try, catch

  -- Operators: Red-orange, bold
  highlight('@operator', { fg = colors.orange, style = 'bold' })

  -- Punctuation: Faint orange (brackets, delimiters)
  highlight('@punctuation.delimiter', { fg = colors.faint_orange }) -- Faint
  highlight('@punctuation.bracket', { fg = colors.faint_orange }) -- Faint
  highlight('@punctuation.special', { fg = colors.orange })

  -- Types: Dark orange
  highlight('@type', { fg = colors.orange })
  highlight('@type.builtin', { fg = colors.orange })
  highlight('@type.definition', { fg = colors.orange })
  highlight('@type.qualifier', { fg = colors.faint_orange })

  -- Properties and fields
  highlight('@property', { fg = colors.orange })
  highlight('@field', { fg = colors.orange })

  -- Ensure these don't get linked elsewhere
  vim.api.nvim_set_hl(0, '@property', { fg = colors.orange })
  vim.api.nvim_set_hl(0, '@field', { fg = colors.orange })

  -- Attributes and annotations: silver-orange
  highlight('@attribute', { fg = colors.orange })
  highlight('@annotation', { fg = colors.orange })

  -- Namespaces and modules
  highlight('@namespace', { fg = colors.orange })
  highlight('@module', { fg = colors.orange })

  -- Tags (HTML/XML/JSX)
  highlight('@tag', { fg = colors.orange, style = 'bold' }) -- Tags: red-orange bold
  highlight('@tag.attribute', { fg = colors.orange }) -- Attribute names: light orange
  highlight('@tag.delimiter', { fg = colors.faint_orange }) -- Tag delimiters: faint

  -- Labels
  highlight('@label', { fg = colors.orange, style = 'bold' })

  -- Special
  highlight('@conceal', { link = 'Conceal' })

  -- Markup (Markdown)
  -- Text styles
  highlight('@markup.strong', { fg = colors.grey_white, style = 'bold' })
  highlight('@markup.italic', { fg = colors.light_gray, style = 'italic' })
  highlight('@markup.underline', { fg = colors.light_gray, style = 'underline' })
  highlight('@markup.strike', { fg = colors.gray_light, style = 'strikethrough' })

  -- Headings with hierarchy
  highlight('@markup.heading', { fg = colors.red_orange, style = 'bold' })
  highlight('@markup.heading.1', { fg = colors.red_orange, style = 'bold' })
  highlight('@markup.heading.2', { fg = colors.orange, style = 'bold' })
  highlight('@markup.heading.3', { fg = colors.orange, style = 'bold' })
  highlight('@markup.heading.4', { fg = colors.faint_orange, style = 'bold' })
  highlight('@markup.heading.5', { fg = colors.faint_orange })
  highlight('@markup.heading.6', { fg = colors.faint_orange })

  -- Quotes and content blocks
  highlight('@markup.quote', { fg = colors.silver, style = 'italic', bg = colors.gray_dark })
  highlight('@markup.math', { fg = colors.green, bg = colors.gray_dark })

  -- Links
  highlight('@markup.link', { fg = colors.light_blue, style = 'underline' })
  highlight('@markup.link.label', { fg = colors.light_blue, style = 'bold' })
  highlight('@markup.link.url', { fg = colors.light_blue, style = 'underline' })

  -- Code blocks
  highlight('@markup.raw', { fg = colors.green, bg = colors.gray_dark })
  highlight('@markup.raw.block', { fg = colors.green, bg = colors.gray_dark })
  highlight('@markup.raw.markdown_inline', { fg = colors.green, bg = colors.gray_dark })

  -- Lists
  highlight('@markup.list', { fg = colors.orange })
  highlight('@markup.list.checked', { fg = colors.info_green, style = 'bold' })
  highlight('@markup.list.unchecked', { fg = colors.silver })
  highlight('@markup.list.markdown', { fg = colors.orange })

  -- Additional markdown elements
  highlight('@markup.environment', { fg = colors.orange })
  highlight('@markup.environment.name', { fg = colors.orange, style = 'bold' })
  highlight('@markup', { fg = colors.light_gray })

  -- Markdown-specific
  highlight('@text.title.markdown', { fg = colors.red_orange, style = 'bold' })
  highlight('@text.literal.markdown', { fg = colors.green, bg = colors.gray_dark })
  highlight('@text.literal.markdown_inline', { fg = colors.green, bg = colors.gray_dark })
  highlight('@text.uri.markdown', { fg = colors.light_blue, style = 'underline' })
  highlight('@punctuation.special.markdown', { fg = colors.faint_orange })
  highlight('@text.quote.markdown', { fg = colors.silver, style = 'italic', bg = colors.gray_dark })

  -- Diff
  highlight('@diff.plus', { fg = colors.green })
  highlight('@diff.minus', { fg = colors.red_dark })
  highlight('@diff.delta', { fg = colors.orange })

  -- ============================================================================
  -- LSP SEMANTIC TOKENS
  -- ============================================================================

  -- Types: Type usages in variables/arguments are orange + italic
  highlight('@lsp.type.class', { fg = colors.orange, style = 'italic' })
  highlight('@lsp.type.enum', { fg = colors.orange, style = 'italic' })
  highlight('@lsp.type.interface', { fg = colors.orange, style = 'italic' })
  highlight('@lsp.type.struct', { fg = colors.orange, style = 'italic' })
  highlight('@lsp.type.record', { fg = colors.orange, style = 'italic' })
  highlight('@lsp.type.type', { fg = colors.orange, style = 'italic' })
  highlight('@lsp.type.typeParameter', { fg = colors.orange, style = 'italic' })

  -- Non-type semantic tokens
  highlight('@lsp.type.decorator', { fg = colors.orange })
  highlight('@lsp.type.enumMember', { fg = colors.orange })
  highlight('@lsp.type.function', { fg = colors.orange, style = 'bold' })
  highlight('@lsp.type.macro', { fg = colors.orange })
  highlight('@lsp.type.method', { fg = colors.orange, style = 'bold' })
  highlight('@lsp.type.namespace', { fg = colors.orange })
  highlight('@lsp.type.parameter', { fg = colors.orange })
  highlight('@lsp.type.property', { fg = colors.orange })
  highlight('@lsp.type.variable', { fg = colors.orange })

  -- Modifiers (don't override colors, let typemod combinations handle it)
  highlight('@lsp.mod.readonly', {})
  highlight('@lsp.mod.deprecated', { style = 'strikethrough' })
  highlight('@lsp.mod.static', {})

  -- Declarations: class/enum/record/method/function declarations are orange + bold (NOT italic)
  highlight('@lsp.typemod.class.declaration', { fg = colors.orange, style = 'bold' })
  highlight('@lsp.typemod.enum.declaration', { fg = colors.orange, style = 'bold' })
  highlight('@lsp.typemod.record.declaration', { fg = colors.orange, style = 'bold' })
  highlight('@lsp.typemod.interface.declaration', { fg = colors.orange, style = 'bold' })
  highlight('@lsp.typemod.struct.declaration', { fg = colors.orange, style = 'bold' })
  highlight('@lsp.typemod.method.declaration', { fg = colors.orange, style = 'bold' })
  highlight('@lsp.typemod.function.declaration', { fg = colors.orange, style = 'bold' })

  -- Static declarations should still be orange + bold (not faint)
  highlight('@lsp.typemod.class.static', { fg = colors.orange })
  highlight('@lsp.typemod.enum.static', { fg = colors.orange })
  highlight('@lsp.typemod.record.static', { fg = colors.orange })
  highlight('@lsp.typemod.method.static', { fg = colors.orange })
  highlight('@lsp.typemod.function.static', { fg = colors.orange })

  -- Type + Modifier combinations for enum members (ensure consistent color)
  highlight('@lsp.typemod.enumMember.declaration', { fg = colors.orange, style = 'bold' })
  highlight('@lsp.typemod.enumMember.readonly', { fg = colors.orange })
  highlight('@lsp.typemod.enumMember.static', { fg = colors.orange })
  highlight('@lsp.typemod.enumMember.public', { fg = colors.orange })

  -- ============================================================================
  -- PLUGIN INTEGRATION
  -- ============================================================================

  -- Git signs: Green/red
  highlight('GitSignsAdd', { fg = colors.green })
  highlight('GitSignsChange', { fg = colors.orange })
  highlight('GitSignsDelete', { fg = colors.red_dark })

  -- Telescope
  highlight('TelescopeBorder', { fg = colors.silver })
  highlight('TelescopeSelection', { fg = colors.grey_white, bg = colors.gray, style = 'bold' })
  highlight('TelescopeSelectionCaret', { fg = colors.orange })
  highlight('TelescopeMultiSelection', { fg = colors.orange })
  highlight('TelescopeMatching', { fg = colors.orange, style = 'bold' })
  highlight('TelescopePromptPrefix', { fg = colors.orange })

  -- Neo-tree
  highlight('NeoTreeDirectoryIcon', { fg = colors.silver })
  highlight('NeoTreeDirectoryName', { fg = colors.orange })
  highlight('NeoTreeFileName', { fg = colors.orange })
  highlight('NeoTreeFileIcon', { fg = colors.silver })
  highlight('NeoTreeGitAdded', { fg = colors.green })
  highlight('NeoTreeGitModified', { fg = colors.light_blue })
  highlight('NeoTreeGitDeleted', { fg = colors.red_dark })
  highlight('NeoTreeGitUntracked', { fg = colors.light_blue })

  -- Which-key
  highlight('WhichKey', { fg = colors.orange })
  highlight('WhichKeyGroup', { fg = colors.orange })
  highlight('WhichKeyDesc', { fg = colors.orange })
  highlight('WhichKeySeparator', { fg = colors.silver })
  highlight('WhichKeyFloat', { bg = colors.bg_dark })

  -- Diagnostics: Info light blue, warnings amber, errors red
  highlight('DiagnosticError', { fg = colors.red_dark })
  highlight('DiagnosticWarn', { fg = colors.amber })
  highlight('DiagnosticInfo', { fg = colors.light_blue })
  highlight('DiagnosticHint', { fg = colors.light_blue })
  highlight('DiagnosticUnderlineError', { sp = colors.red_dark, style = 'undercurl' })
  highlight('DiagnosticUnderlineWarn', { sp = colors.amber, style = 'undercurl' })
  highlight('DiagnosticUnderlineInfo', { sp = colors.light_blue, style = 'undercurl' })
  highlight('DiagnosticUnderlineHint', { sp = colors.light_blue, style = 'undercurl' })

  -- Completion
  highlight('CmpItemAbbrMatch', { fg = colors.orange, style = 'bold' })
  highlight('CmpItemAbbrMatchFuzzy', { fg = colors.orange })
  highlight('CmpItemKindFunction', { fg = colors.orange })
  highlight('CmpItemKindMethod', { fg = colors.orange, style = 'bold' })
  highlight('CmpItemKindVariable', { fg = colors.orange })
  highlight('CmpItemKindKeyword', { fg = colors.faint_orange })
  highlight('CmpItemKindClass', { fg = colors.orange })
  highlight('CmpItemKindInterface', { fg = colors.orange })
  highlight('CmpItemKindText', { fg = colors.light_gray })

  -- Indent guides
  highlight('IndentBlanklineChar', { fg = colors.gray })
  highlight('IndentBlanklineContextChar', { fg = colors.gray })
  highlight('IblIndent', { fg = colors.gray })
  highlight('IblScope', { fg = colors.gray })

  -- Todo comments
  -- TODO: example of a thin
  -- NOTE: a nother thing
  -- WARNING: akdjfkdjf
  -- BUG: afjdkfjdkjf
  highlight('TodoFgTODO', { fg = colors.light_blue }) -- TODO: test
  highlight('TodoBgTODO', { fg = colors.bg_black, bg = colors.light_blue }) -- NOTE: fjkdjfk
  highlight('TodoFgFIX', { fg = colors.red_dark })
  highlight('TodoBgFIX', { fg = colors.bg_black, bg = colors.red_dark })
  highlight('TodoFgNOTE', { fg = colors.light_blue })
  highlight('TodoBgNOTE', { fg = colors.bg_black, bg = colors.light_blue })
  highlight('TodoFgWARN', { fg = colors.amber })
  highlight('TodoBgWARN', { fg = colors.bg_black, bg = colors.amber })

  -- Debugging
  highlight('DapBreakpoint', { fg = colors.light_blue })
  highlight('DapStopped', { fg = colors.red_dark })
  highlight('DapLogPoint', { fg = colors.amber })
end

-- ============================================================================
-- SETUP AND RETURN
-- ============================================================================

M.load()

return M
