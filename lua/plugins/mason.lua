return {
  {'neovim/nvim-lspconfig'},
  {'williamboman/mason.nvim', config = function() require('mason').setup() end},
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'jdtls', 'pyright', 'rust_analyzer', 'clangd', 'gopls',
          'emmet_ls', 'html', 'cssls', 'jsonls', 'solargraph', 'sqlls',
          'yamlls', 'bashls', 'dockerls', 'elixirls', 'vimls', 'lua_ls',
          'eslint', 'graphql', 'phpactor', 'perlnavigator', 'terraformls',
          'hls', 'volar', 'kotlin_language_server', 'tailwindcss',
          'marksman', 'svelte', 'texlab', 'lemminx',
        },
        automatic_installation = true,
	auto_install = true,
      })
require('mason-lspconfig').setup_handlers({
    function (server_name)
        require('lspconfig')[server_name].setup {
            on_attach = function(client, bufnr)
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
                
                -- Enable completion triggered by <c-x><c-o>
                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
                
                -- Other setup like key mappings, etc.
            end,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }
    end,
})

    end
  },
  {
    'nvimdev/lspsaga.nvim',
    dependencies = { 'nvim-lspconfig' },
    config = function()
      require('lspsaga').setup({
        lightbulb = {
        enable = true,  -- Disable the lightbulb to avoid shaking
        sign = false,
        virtual_text = true,  -- You can keep virtual text if you prefer
    },
    })
    end
  },
  {
    'folke/trouble.nvim',
    dependencies = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require('trouble').setup({
        -- your trouble config here
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').ts_ls.setup{
  -- Any specific settings you want to include
}
require('lspconfig')['jdtls'].setup({
    cmd = { 'jdtls' },  -- Mason will automatically handle the path
    root_dir = function(fname)
        return require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}, fname)
    end,
    settings = {
        java = {
            contentProvider = { preferred = 'fernflower' },
        },
    },
    on_attach = function(client, bufnr)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    end,
})
require'lspconfig'.pyright.setup{
  root_dir = function(fname)
    -- Find the git directory or any of the common Python project files
    return require('lspconfig.util').find_git_ancestor(fname)
    or require('lspconfig.util').root_pattern('pyproject.toml', 'setup.py', 'requirements.txt', '.git')(fname)
    or require('lspconfig.util').path.dirname(fname)
  end,
}
require'lspconfig'.kotlin_language_server.setup{
    cmd = {"kotlin-language-server"},
    root_dir = require'lspconfig'.util.root_pattern("build.gradle", "settings.gradle", ".git"),
}
require('lspconfig').sourcekit.setup{
    cmd = { "xcrun", "sourcekit-lsp" },
    filetypes = { "swift" },
    root_dir = require('lspconfig').util.root_pattern("Package.swift", ".git"),
}
require'lspconfig'.dartls.setup {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  root_dir = function(fname)
    return require'lspconfig'.util.root_pattern("pubspec.yaml", ".git")(fname)
      or require'lspconfig'.util.path.dirname(fname)  -- Fallback to file's directory
  end,
  init_options = {
    closingLabels = true,
    flutterOutline = true,
    onlyAnalyzeProjectsWithOpenFiles = true,
    outline = true,
    suggestFromUnimportedLibraries = true,
  },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true
    }
  }
}
require'lspconfig'.metals.setup{
  root_dir = function(fname)
    return require'lspconfig'.util.root_pattern("build.sbt", "build.sc", ".git")(fname)
      or require'lspconfig'.util.path.dirname(fname)  -- Fallback to file's directory
  end,
  settings = {
    metals = {
      showImplicitArguments = true,
      superMethodLensesEnabled = true,
      showInferredType = true
    }
  }
}
require'lspconfig'.sqlls.setup{
  root_dir = function(fname)
    return require'lspconfig'.util.root_pattern('.sql_project', '.git')(fname) or require'lspconfig'.util.path.dirname(fname)
  end
}
    end
  }
}
