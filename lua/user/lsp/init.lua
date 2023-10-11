local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
     -- runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      --   version = 'LuaJIT',
      -- },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
        -- Make the server aware of Neovim runtime files
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "jsonls", "pyright", "tsserver","lua_ls"},
}

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
--    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--    vim.keymap.set('n', '<space>wl', function()
--      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--    end, opts)
--    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
--    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
--    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--    vim.keymap.set('n', '<space>f', function()
--     vim.lsp.buf.format { async = true }
--   end, opts)
  end,
})


-- :which require "user.lsp.configs"
-- require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
