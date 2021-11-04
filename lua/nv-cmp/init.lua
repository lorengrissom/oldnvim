vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- Setup nvim-cmp.
--local has_words_before = function()
--  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--end

--local feedkey = function(key, mode)
--  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
--end
--local luasnip = require'luasnip'
local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      -- vsnip
      --["<Tab>"] = cmp.mapping(function(fallback)
      --  if cmp.visible() then
      --    cmp.select_next_item()
      --  elseif vim.fn["vsnip#available"](1) == 1 then
      --    feedkey("<Plug>(vsnip-expand-or-jump)", "")
      --  elseif luasnip.expand_or_jumpable() then --if work
      --  elseif has_words_before() then
      --    cmp.complete()
      --  else
      --  fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      --  end
      --end, { "i", "s" }),

      --["<S-Tab>"] = cmp.mapping(function()
      --  if cmp.visible() then
      --    cmp.select_prev_item()
      --  elseif vim.fn["vsnip#jumpable"](-1) == 1 then
      --    feedkey("<Plug>(vsnip-jump-prev)", "")
      --  elseif luasnip.jumpable(-1) then --if work
      --    luasnip.jump(-1) --if work
      --  end
      --end, { "i", "s" }),
      -- luasnip
      --["<Tab>"] = cmp.mapping(function(fallback)
      --  if cmp.visible() then
      --    cmp.select_next_item()
      --  elseif luasnip.expand_or_jumpable() then
      --    luasnip.expand_or_jump()
      --  elseif has_words_before() then
      --    cmp.complete()
      --  else
      --    fallback()
      --  end
      --end, { "i", "s" }),

      --["<S-Tab>"] = cmp.mapping(function(fallback)
      --  if cmp.visible() then
      --    cmp.select_prev_item()
      --  elseif luasnip.jumpable(-1) then
      --    luasnip.jump(-1)
      --  else
      --    fallback()
      --  end
      --end, { "i", "s" }),

      --['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      --['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'gh_issues'},
      { name = 'nvim_lua'},
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'nvim_lsp' },
      { name = 'look' },
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer', keyword_length = 4 },
    }),
    native_menu = false,
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require'lspconfig'.html.setup {
    capabilities = capabilities
  }

  require'lspconfig'.pyright.setup {
    capabilities = capabilities
  }

  require'lspconfig'.rust_analyzer.setup{
    capabilities = capabilities
  }

  require'lspconfig'.tsserver.setup{
    capabilities = capabilities
  }
