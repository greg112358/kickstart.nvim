local luasnip = require 'luasnip'
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local M = {}

M.ts = function()
  return {
    s('dfun', { t 'function ', i(1, 'name'), t { '() {', '\t', '}' } }),
    s('afun', { t 'const ', i(1, 'name'), t { ' = () => {', '\t', '}' } }),
    s('iface', { t 'interface ', i(1, 'Name'), t { ' {', '\t', '}' } }),
    s('dtype', { t 'type ', i(1, 'Name'), t ' = ' }),
    s('imp', { t "import { ", i(1), t " } from '", i(2, 'module'), t "'" }),
    s('log', { t 'console.log(', i(1), t ')' }),
    s('fore', { t '.forEach((', i(1, 'item'), t { ') => {', '\t', '})' } }),
    s('map', { t '.map((', i(1, 'item'), t { ') => {', '\t', '})' } }),
    s('fil', { t '.filter((', i(1, 'item'), t { ') => {', '\t', '})' } }),
    s('try', { t { 'try {', '\t' }, i(1), t { '', '} catch (', '' }, i(2, 'e'), t { ') {', '\t', '}' } }),
    s('prom', { t 'new Promise((resolve, reject) => {', t { '', '\t' }, i(1), t { '', '})' } }),
    s('asyn', { t 'async function ', i(1, 'name'), t { '() {', '\t', '}' } }),
    s('await', { t 'const ', i(1, 'result'), t ' = await ', i(2) }),
  }
end

M.js = function()
  return {
    s('dfun', { t 'function ', i(1, 'name'), t { '() {', '\t', '}' } }),
    s('afun', { t 'const ', i(1, 'name'), t { ' = () => {', '\t', '}' } }),
    s('imp', { t "import { ", i(1), t " } from '", i(2, 'module'), t "'" }),
    s('req', { t "const ", i(1, 'mod'), t " = require('", i(2, 'module'), t "')" }),
    s('log', { t 'console.log(', i(1), t ')' }),
    s('fore', { t '.forEach((', i(1, 'item'), t { ') => {', '\t', '})' } }),
    s('map', { t '.map((', i(1, 'item'), t { ') => {', '\t', '})' } }),
    s('fil', { t '.filter((', i(1, 'item'), t { ') => {', '\t', '})' } }),
    s('try', { t { 'try {', '\t' }, i(1), t { '', '} catch (', '' }, i(2, 'e'), t { ') {', '\t', '}' } }),
    s('asyn', { t 'async function ', i(1, 'name'), t { '() {', '\t', '}' } }),
    s('await', { t 'const ', i(1, 'result'), t ' = await ', i(2) }),
  }
end

M.typescriptreact = function()
  return {
    s('comp', { t 'export function ', i(1, 'Name'), t { '() {', '\treturn (', '\t\t<div>', '\t\t\t' }, i(2), t { '', '\t\t</div>', '\t)', '}' } }),
    s('us', { t 'const [', i(1, 'state'), t ', set', i(2, 'State'), t '] = useState(', i(3), t ')' }),
    s('ue', { t { 'useEffect(() => {', '\t' }, i(1), t { '', '}, [', '' }, i(2), t '])' }),
    s('ur', { t 'const ', i(1, 'ref'), t ' = useRef(', i(2, 'null'), t ')' }),
    s('um', { t { 'const ', '' }, i(1, 'value'), t { ' = useMemo(() => {', '\treturn ' }, i(2), t { '', '}, [', '' }, i(3), t '])' }),
    s('uc', { t { 'const ', '' }, i(1, 'fn'), t { ' = useCallback((' }, i(2), t { ') => {', '\t' }, i(3), t { '', '}, [', '' }, i(4), t '])' }),
    s('cn', { t "className={", i(1), t '}' }),
    s('frag', { t { '<>', '\t' }, i(1), t { '', '</>' } }),
    s('map', { t '{', i(1, 'items'), t '.map((', i(2, 'item'), t { ') => (', '\t' }, i(3), t { '', '))}' } }),
    s('cond', { t '{', i(1, 'condition'), t ' && (', i(2), t ')}' }),
    s('tern', { t '{', i(1, 'condition'), t ' ? ', i(2, 'a'), t ' : ', i(3, 'b'), t '}' }),
  }
end

M.html = function()
  return {
    s('div', { t '<div>', i(1), t '</div>' }),
    s('divc', { t '<div class="', i(1), t '">', i(2), t '</div>' }),
    s('span', { t '<span>', i(1), t '</span>' }),
    s('a', { t '<a href="', i(1), t '">', i(2, 'link'), t '</a>' }),
    s('img', { t '<img src="', i(1), t '" alt="', i(2), t '" />' }),
    s('inp', { t '<input type="', i(1, 'text'), t '" name="', i(2), t '" />' }),
    s('btn', { t '<button type="', i(1, 'button'), t '">', i(2, 'Click'), t '</button>' }),
    s('ul', { t { '<ul>', '\t<li>' }, i(1), t { '</li>', '</ul>' } }),
    s('ol', { t { '<ol>', '\t<li>' }, i(1), t { '</li>', '</ol>' } }),
    s('form', { t { '<form action="', '' }, i(1), t { '" method="', '' }, i(2, 'post'), t { '">', '\t' }, i(3), t { '', '</form>' } }),
    s('label', { t '<label for="', i(1), t '">', i(2), t '</label>' }),
    s('sel', { t { '<select name="', '' }, i(1), t { '">', '\t<option value="', '' }, i(2), t '">', i(3), t { '</option>', '</select>' } }),
    s('sec', { t { '<section>', '\t' }, i(1), t { '', '</section>' } }),
    s('nav', { t { '<nav>', '\t' }, i(1), t { '', '</nav>' } }),
  }
end

M.lua = function()
  return {
    s('dfun', { t 'function ', i(1, 'name'), t { '()', '\t' }, i(2), t { '', 'end' } }),
    s('lfun', { t 'local function ', i(1, 'name'), t { '()', '\t' }, i(2), t { '', 'end' } }),
    s('afun', { t 'local ', i(1, 'name'), t { ' = function()', '\t' }, i(2), t { '', 'end' } }),
    s('if', { t 'if ', i(1), t { ' then', '\t' }, i(2), t { '', 'end' } }),
    s('ife', { t 'if ', i(1), t { ' then', '\t' }, i(2), t { '', 'else', '\t' }, i(3), t { '', 'end' } }),
    s('for', { t 'for ', i(1, 'i'), t ' = ', i(2, '1'), t ', ', i(3, '10'), t { ' do', '\t' }, i(4), t { '', 'end' } }),
    s('forp', { t 'for ', i(1, 'k'), t ', ', i(2, 'v'), t ' in pairs(', i(3, 'tbl'), t { ') do', '\t' }, i(4), t { '', 'end' } }),
    s('fori', { t 'for ', i(1, 'i'), t ', ', i(2, 'v'), t ' in ipairs(', i(3, 'tbl'), t { ') do', '\t' }, i(4), t { '', 'end' } }),
    s('req', { t "local ", i(1, 'mod'), t " = require '", i(2, 'module'), t "'" }),
    s('mod', { t { 'local M = {}', '', '' }, i(1), t { '', '', 'return M' } }),
    s('pr', { t 'print(', i(1), t ')' }),
  }
end

M.elixir = function()
  return {
    s('dfun', { t 'def ', i(1, 'name'), t { '() do', '\t' }, i(2), t { '', 'end' } }),
    s('dfunp', { t 'defp ', i(1, 'name'), t { '() do', '\t' }, i(2), t { '', 'end' } }),
    s('dmod', { t 'defmodule ', i(1, 'Name'), t { ' do', '\t' }, i(2), t { '', 'end' } }),
    s('if', { t 'if ', i(1), t { ' do', '\t' }, i(2), t { '', 'end' } }),
    s('case', { t 'case ', i(1), t { ' do', '\t' }, i(2, 'pattern'), t ' -> ', i(3), t { '', 'end' } }),
    s('cond', { t { 'cond do', '\t' }, i(1, 'condition'), t ' -> ', i(2), t { '', 'end' } }),
    s('pipe', { t '|> ', i(1) }),
    s('ins', { t 'IO.inspect(', i(1), t ')' }),
    s('doc', { t { '@doc """', '' }, i(1), t { '', '"""' } }),
    s('test', { t 'test "', i(1, 'description'), t { '" do', '\t' }, i(2), t { '', 'end' } }),
    s('desc', { t 'describe "', i(1, 'description'), t { '" do', '\t' }, i(2), t { '', 'end' } }),
  }
end

M.java = function()
  return {
    s('dmethod', { i(1, 'public'), t ' ', i(2, 'void'), t ' ', i(3, 'name'), t { '() {', '\t', '}' } }),
    s('smethod', { i(1, 'public'), t ' static ', i(2, 'void'), t ' ', i(3, 'name'), t { '() {', '\t', '}' } }),
    s('main', { t { 'public static void main(String[] args) {', '\t' }, i(1), t { '', '}' } }),
    s('sout', { t 'System.out.println(', i(1), t ');' }),
    s('if', { t 'if (', i(1), t { ') {', '\t' }, i(2), t { '', '}' } }),
    s('ife', { t 'if (', i(1), t { ') {', '\t' }, i(2), t { '', '} else {', '\t' }, i(3), t { '', '}' } }),
    s('for', { t 'for (int ', i(1, 'i'), t ' = 0; ', i(2, 'i'), t ' < ', i(3, 'n'), t '; ', i(4, 'i'), t { '++) {', '\t' }, i(5), t { '', '}' } }),
    s('fore', { t 'for (', i(1, 'Type'), t ' ', i(2, 'item'), t ' : ', i(3, 'items'), t { ') {', '\t' }, i(4), t { '', '}' } }),
    s('try', { t { 'try {', '\t' }, i(1), t { '', '} catch (', '' }, i(2, 'Exception e'), t { ') {', '\t' }, i(3), t { '', '}' } }),
    s('class', { t 'public class ', i(1, 'Name'), t { ' {', '\t' }, i(2), t { '', '}' } }),
    s('ctor', { t 'public ', i(1, 'Name'), t { '() {', '\t' }, i(2), t { '', '}' } }),
  }
end

M.zig = function()
  return {
    s('dfun', { t 'fn ', i(1, 'name'), t '() ', i(2, 'void'), t { ' {', '\t' }, i(3), t { '', '}' } }),
    s('pfun', { t 'pub fn ', i(1, 'name'), t '() ', i(2, 'void'), t { ' {', '\t' }, i(3), t { '', '}' } }),
    s('test', { t 'test "', i(1, 'description'), t { '" {', '\t' }, i(2), t { '', '}' } }),
    s('if', { t 'if (', i(1), t { ') {', '\t' }, i(2), t { '', '}' } }),
    s('ife', { t 'if (', i(1), t { ') {', '\t' }, i(2), t { '', '} else {', '\t' }, i(3), t { '', '}' } }),
    s('for', { t 'for (', i(1, 'items'), t ') |', i(2, 'item'), t { '| {', '\t' }, i(3), t { '', '}' } }),
    s('while', { t 'while (', i(1), t { ') {', '\t' }, i(2), t { '', '}' } }),
    s('sw', { t 'switch (', i(1), t { ') {', '\t' }, i(2, 'val'), t ' => ', i(3), t { ',', '}' } }),
    s('struct', { t 'const ', i(1, 'Name'), t { ' = struct {', '\t' }, i(2), t { '', '};' } }),
    s('enum', { t 'const ', i(1, 'Name'), t { ' = enum {', '\t' }, i(2), t { '', '};' } }),
    s('pr', { t 'std.debug.print("', i(1, '{}'), t '", .{', i(2), t '});' }),
    s('log', { t 'std.log.info("', i(1, '{}'), t '", .{', i(2), t '});' }),
    s('err', { t 'return error.', i(1, 'Error'), t ';' }),
    s('defer', { t 'defer ', i(1), t ';' }),
    s('catch', { i(1), t ' catch |', i(2, 'err'), t '| ', i(3) }),
    s('orelse', { i(1), t ' orelse ', i(2) }),
    s('imp', { t '@import("', i(1, 'std'), t '")' }),
  }
end

return M
