function organize_imports()
  local params = {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ''
  }
  vim.lsp.buf.execute_command(params)
end

return {
  'neovim/nvim-lspconfig',
  cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  init = function()
    -- Reserve a space in the gutter
    -- This will avoid an annoying layout shift in the screen
    vim.opt.signcolumn = 'yes'
  end,
  config = function()
    --local capabilities = require('blink.cmp').get_lsp_capabilities()
    local lspconfig = require('lspconfig')
    local lsp_defaults = lspconfig.util.default_config

    -- Add cmp_nvim_lsp capabilities settings to lspconfig
    -- This should be executed before you configure any language server
    lsp_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lsp_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    -- LspAttach is where you enable features that only work
    -- if there is a language server active in the file
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

        --Sometimes this pulls up 2 defs. This is a monkey patch to fix that
        --https://github.com/LuaLS/lua-language-server/issues/2451
        local locations_to_items = vim.lsp.util.locations_to_items
        vim.lsp.util.locations_to_items = function(locations, offset_encoding)
          local lines = {}
          local loc_i = 1
          for _, loc in ipairs(vim.deepcopy(locations)) do
            local uri = loc.uri or loc.targetUri
            local range = loc.range or loc.targetSelectionRange
            if lines[uri .. range.start.line] then -- already have a location on this line
              table.remove(locations, loc_i)       -- remove from the original list
            else
              loc_i = loc_i + 1
            end
            lines[uri .. range.start.line] = true
          end

          return locations_to_items(locations, offset_encoding)
        end

        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)


        -- Use fzf for this
        --vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

        vim.keymap.set('n', '<leader>ld', function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
      end,
    })

    require('mason-lspconfig').setup({
      ensure_installed = {},
      handlers = {
        function(server_name)
          -- Custom setup for typescript
          if (server_name == 'ts_ls') then
            require('lspconfig')[server_name].setup(
              {
                commands = {
                  OR = {
                    organize_imports,
                    description = 'Organize Imports',
                  }
                }
              })
          else
            require('lspconfig')[server_name].setup({})
          end
        end,
      }
    })
  end
}
