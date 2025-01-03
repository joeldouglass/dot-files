return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                          -- Only on MacOS or Linux
    config = function()
      require('CopilotChat').setup({
        highlight_headers = false,
        separator = '---',
        error_header = '> [!ERROR] Error',
        -- rest of your config
        mappings = {
          reset = {
            normal = '<C-r>',
            insert = '<C-r>'
          }
        }
      })
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
