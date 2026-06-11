---@type LazySpec
return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- Picker for search, backlinks, etc.
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      disable_frontmatter = true,
      workspaces = {
        {
          name = "ohara",
          path = "/home/sijan/Documents/Ohara-Notes",
        },
      },

      -- see below for full list of options 👇
      ui = {
        enable = true, -- set to false to disable all additional syntax highlighting
        update_debounce = 200, -- update delay after a text change in ms
        -- Define how various check-boxes are rendered
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "[", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#c792ea" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },

      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },

      templates = {
        subdir = "Templates",
      },

      note_id_func = function(title)
        return title and title:gsub("%s+", "-"):lower() or os.date("%Y-%m-%d-%H%M%S")
      end,

      picker = {
        name = "telescope.nvim",
      },
      mappings = {
        ["<Leader>od"] = { action = "<Cmd>ObsidianToday<CR>", opts = { buffer = true, desc = "Open today's daily note" } },
        ["<Leader>on"] = { action = "<Cmd>ObsidianNew<CR>", opts = { buffer = true, desc = "Create a new note" } },
        ["<Leader>os"] = { action = "<Cmd>ObsidianSearch<CR>", opts = { buffer = true, desc = "Search notes" } },
        ["<Leader>ob"] = { action = "<Cmd>ObsidianBacklinks<CR>", opts = { buffer = true, desc = "Show backlinks" } },
        ["<Leader>ol"] = { action = "<Cmd>ObsidianFollowLink<CR>", opts = { buffer = true, desc = "Follow link under cursor" } },
        ["<Leader>oo"] = { action = "<Cmd>ObsidianOpen<CR>", opts = { buffer = true, desc = "Open in Obsidian app" } },
        ["<Leader>ot"] = { action = "<Cmd>ObsidianTags<CR>", opts = { buffer = true, desc = "Show tags" } },
        ["<Leader>oq"] = { action = "<Cmd>ObsidianQuickSwitch<CR>", opts = { buffer = true, desc = "Quick switch notes" } },
        ["<Leader>oc"] = { action = "<Cmd>ObsidianToggleCheckbox<CR>", opts = { buffer = true, desc = "Toggle checkbox" } },
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt.conceallevel = 2
        end,
      })
    end,
  },

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })

      -- include the default astronvim config that calls the setup call
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      local astro = require "astrocore"
      maps.n["<Leader><Leader>"] = {
        function()
          astro.toggle_term_cmd { cmd = "opencode", direction = "float", dir = vim.fn.getcwd() }
        end,
        desc = "ToggleTerm opencode",
      }
      if vim.fn.executable "lazygit" == 1 then
        local function lazygit_callback()
          local worktree = astro.file_worktree()
          local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir) or ""
          local dir = worktree and worktree.toplevel or vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
          dir = (worktree or vim.v.shell_error == 0) and dir or vim.fn.getcwd()
          astro.toggle_term_cmd { cmd = "lazygit" .. flags, direction = "float", dir = dir }
        end
        maps.n["<Leader>gg"] = { lazygit_callback, desc = "ToggleTerm lazygit (repo root)" }
        maps.n["<Leader>tl"] = { lazygit_callback, desc = "ToggleTerm lazygit (repo root)" }
      end
    end,
  },
}
