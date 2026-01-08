return {
  -- Mason
  { "mason-org/mason.nvim",           version = "^2" },
  { "mason-org/mason-lspconfig.nvim", version = "^2" },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^7',
    lazy = false,
    ft = "rust",
    config = function()
        local cfg = require("rustaceanvim.config")
      local path = require("mason-core.path")
      local settings = require("mason.settings")

      local mason_root = settings.current.install_root_dir
      local extension = path.concat { mason_root, "packages", "codelldb", "extension" }

      local codelldb_path = path.concat { extension, "adapter", "codelldb" }
      local liblldb_path  = path.concat { extension, "lldb", "lib", "liblldb.so" }

      if vim.fn.filereadable(codelldb_path) == 0 then
        vim.notify("codelldb not found. Run :MasonInstall codelldb", vim.log.levels.WARN)
        return
      end

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end
  },

  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },

  {
  "mfussenegger/nvim-dap",
  lazy = false,
  config = function()
    require "configs.dap"   -- вынесем настройки в отдельный файл
  end,
},

{
  "rcarriga/nvim-dap-ui",
  lazy = false,
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  config = function()
    require("dapui").setup()
  end,
},


  {
    'saecki/crates.nvim',
    ft = { "toml" },
    config = function()
      require("crates").setup({
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })


    end
  },

  -- Табы с вкладками сверху
  {
    "akinsho/bufferline.nvim",
    version = "*", -- последняя стабильная
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("bufferline").setup({})
      vim.opt.termguicolors = true
      vim.opt.showtabline = 2
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua", "vim", "rust", "bash", "json", "markdown", "typescript", "javascript", "go", "toml", "xml", "sql"
      },
      highlight = {
        enable = true,
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("diffview").setup({})
    end,
  },


}
