return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "L3MON4D3/LuaSnip", version = "v2.*" },
    },
    opts = {
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {},
      },
      keymap = {
        preset = "super-tab",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        kind_icons = {
          -- Copilot = "",
        },
      },
      -- Optimización de rendimiento
      completion = {
        list = { selection = { preselect = true, auto_insert = true } },
        menu = {
          border = "single",
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "single",
          },
        },
      },
    },
    config = function(_, opts)
      local ok, ls = pcall(require, "luasnip")
      if ok then
        ls.config.setup({
          region_check_events = "CursorMoved,InsertEnter",
          delete_check_events = "TextChanged,InsertLeave",
        })
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Custom snippets
        require("snippets.js_ts").register({
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        })
        require("snippets.go").register()
        require("snippets.terraform").register()
      end
      require("blink.cmp").setup(opts)
    end,
  },
}
