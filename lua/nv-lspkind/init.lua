local cmp = require 'cmp'
local lspkind = require 'lspkind'
require('lspkind').init({
    --enables text annotations
    --default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = " Text",
      Method = " Method",
      Function = " Function",
      Constructor = " Constructor",
      Field = "ﰠ Field",
      Variable = " Variable",
      Class = "ﴯ Class",
      Interface = " Interface",
      Module = " Module",
      Property = "ﰠ Property",
      Unit = "塞Unit",
      Value = " Value",
      Enum = " Enum",
      Keyword = " Keyword",
      Snippet = " Snippet",
      Color = " Color",
      File = " File",
      Reference = " Reference",
      Folder = " Folder",
      EnumMember = " EnumMember",
      Constant = " Constant",
      Struct = "פּ Struct",
      Event = " Event",
      Operator = " Operator",
      TypeParameter = ""
    },
})
cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      --vim_item.kind = 'kind'
      --vim_item.menu = 'menu'

      vim_item.kind = lspkind.presets.default[vim_item.kind]
      vim_item.menu = ({
      nvim_lsp = "[LSP]",
      look = "[Dict]",
      buffer = "[Buffer]",
      nvim_lua = "[Api]",
      luasnip = "[Snip]",
      gh_issues = "[Issues]",
      nvim = "[CMD]"
      })[entry.source.name]
      return vim_item
    end
  },
experimental = {
  native_menu = false,
  ghost_text = true,
},
})
