return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pylsp"}
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      
      -- Lua LSP Config
      vim.lsp.config("lua_ls", {})
      vim.lsp.enable("lua_ls")
      -- Python LSP Config
      vim.lsp.config("pylsp", {})
      vim.lsp.enable("pylsp")
    end
  }
}
