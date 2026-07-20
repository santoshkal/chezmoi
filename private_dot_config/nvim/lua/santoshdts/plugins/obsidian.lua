return {
  "obsidian-nvim/obsidian.nvim",
  -- events = {
  --   "BufReadPre " .. vim.fn.expand("~") .. "/Dropbox/devops/**/*.md",
  -- },
  -- version = "*", -- TODO: Re-enable after next release (fix for fzf template callback)
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "Saghen/blink.cmp",
  },
  keys = {
    { "<leader>oo",       "<cmd>Obsidian open<CR>",               desc = "Open on App" },
    { "<leader>os",       "<cmd>Obsidian search<CR>",             desc = "Obsidian Search" },
    { "<leader>on",       "<cmd>Obsidian new<CR>",                desc = "New Note" },
    { "<leader>oN",       "<cmd>Obsidian new_from_template<CR>",  desc = "New Note (Template)" },
    { "<leader>o<space>", "<cmd>Obsidian quick_switch<CR>",       desc = "Find Files" },
    { "<leader>ob",       "<cmd>Obsidian backlinks<CR>",          desc = "Backlinks" },
    { "<leader>ot",       "<cmd>Obsidian tags<CR>",               desc = "Tags" },
    { "<leader>oT",       "<cmd>Obsidian template<CR>",           desc = "Template" },
    { "<leader>oL",       "<cmd>Obsidian link<CR>",               mode = "v",                              desc = "Link" },
    { "<leader>oi",       "<cmd>Obsidian links<CR>",              desc = "Links" },
    { "<S-CR>",           "<cmd>Obsidian follow_link vsplit<CR>", desc = "[F]ollow Link in Verticle Split" },

    {
      "<leader>oe",
      "<cmd>Obsidian link_new<CR>",
      mode = "v",
      desc = "Extract and Link New Note",
    },
    { "<leader>od", "<cmd>Obsidian workspace DevOps<CR>", desc = "Switch to [D]evOps Workspace" },
    { "<leader>ow", "<cmd>Obsidian workspace work<CR>",   desc = "Switch to [W]prk Workspace" },
    { "<leader>ol", "<cmd>Obsidian workspace<CR>",        desc = "[L]ist Workspaces" },
    { "<leader>or", "<cmd>Obsidian rename<CR>",           desc = "Rename" },
    { "<leader>oR", "<cmd>ObsidianRandom<CR>",            desc = "Open Random Note" },
    -- Removed global <CR> and gd mappings - now set in config function for markdown buffers only
    -- { "<CR>", "<cmd>Obsidian follow_link vsplit<CR>", desc = "Follow link" },

    -- { prefix .. "i", "<cmd>Obsidian paste_img<CR>", desc = "Paste Image" },
    -- { prefix .. "d", "<cmd>Obsidian dailies<CR>", desc = "Daily Notes" },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Register command for use from command line
    vim.api.nvim_create_user_command("ObsidianRandom", function()
      require("santoshdts.core.utils").open_random_note()
    end, {})

    -- Set <CR> and gd keybindings ONLY in markdown buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function(event)
        -- Only set these keymaps if we're in an Obsidian workspace
        local bufpath = vim.api.nvim_buf_get_name(event.buf)
        if bufpath:match("Dropbox/devops") or bufpath:match("Dropbox/work") then
          vim.keymap.set("n", "<CR>", function()
            return require("obsidian").util.smart_action()
          end, { buffer = event.buf, expr = true, desc = "Obsidian: Follow link" })

          vim.keymap.set("n", "gd", function()
            return require("obsidian").util.gf_passthrough()
          end, { buffer = event.buf, noremap = false, expr = true, desc = "Obsidian: Go to definition" })
        end
      end,
    })
  end,
  opts = {
    checkbox = { create_new = false },

    ui = {
      enabled = false,
    },
    workspaces = {
      {
        name = "DevOps",
        path = "~/Dropbox/devops",
        overrides = { notes_subdir = "00-Inbox" },
      },
      {
        name = "work",
        path = "~/Dropbox/work",
        overrides = { notes_subdir = "00-Inbox" },
      },
    },
    notes_subdir = "00-Inbox",
    frontmatter = {
      enabled = false,
    },

    -- completion = {
    --   nvim_cmp = false, -- switch on the built-in CMP source
    --   blink = true,
    -- },
    note_id_func = function(title)
      if title ~= nil then
        return title
      else
        return os.date("%Y%m%d%H%M")
      end
    end,
    legacy_commands = false,
    templates = {
      folder = "templates",
      date_format = "%Y%m%d%H%M",
    },
    picker = {
      name = "fzf-lua",
      note_mappings = {
        new = "<C-x>",
        insert_link = "<C-l>",
      },
    },
    -- … your other obsidian.nvim settings …
  },
}
