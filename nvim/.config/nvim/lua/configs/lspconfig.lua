require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- LSP servers to configure
local servers = { "html", "cssls", "ts_ls", "clangd", "tailwindcss", "prismals", "sqlls" }

-- Enable snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Emmet-LS configuration
lspconfig.emmet_ls.setup {
  capabilities = capabilities,
  filetypes = {
    "eruby",
    "javascriptreact",
    "less",
    "sass",
    "svelte",
    "pug",
    "typescriptreact",
    "vue",
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
}

-- General setup for all servers
local nvlsp = require "nvchad.configs.lspconfig"

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
