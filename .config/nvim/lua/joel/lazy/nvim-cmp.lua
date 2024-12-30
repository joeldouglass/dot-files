return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      sources = {
        { name = 'nvim_lsp' },
      },
      completion = {
        autocomplete = false
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = 'select' })
          else
            cmp.complete()
          end
        end, { 'i', 's' }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
    })
  end
}
