{ helpers, ... }:
{
  plugins.gitsigns = {
    enable = true;
    settings = {
      current_line_blame = true;
      signs = {
        add.text = "+";
        change.text = "~";
        delete.text = "_";
        topdelete.text = "‾";
        changedelete.text = "~";
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "]g";
      action = helpers.mkRaw "require('gitsigns').next_hunk";
      options.desc = "Next Git hunk";
    }
    {
      mode = "n";
      key = "[g";
      action = helpers.mkRaw "require('gitsigns').prev_hunk";
      options.desc = "Previous Git hunk";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action = helpers.mkRaw "function() require('gitsigns').blame_line { full = true } end";
      options.desc = "View full Git blame";
    }
    {
      mode = "n";
      key = "<leader>gp";
      action = helpers.mkRaw "require('gitsigns').preview_hunk_inline";
      options.desc = "Preview Git hunk";
    }
    {
      mode = "n";
      key = "<leader>gh";
      action = helpers.mkRaw "require('gitsigns').reset_hunk";
      options.desc = "Reset Git hunk";
    }
    {
      mode = "n";
      key = "<leader>gr";
      action = helpers.mkRaw "require('gitsigns').reset_buffer";
      options.desc = "Reset Git buffer";
    }
    {
      mode = "n";
      key = "<leader>gs";
      action = helpers.mkRaw "require('gitsigns').stage_hunk";
      options.desc = "Stage Git hunk";
    }
    {
      mode = "n";
      key = "<leader>gS";
      action = helpers.mkRaw "require('gitsigns').stage_buffer";
      options.desc = "Stage Git buffer";
    }
    {
      mode = "n";
      key = "<leader>gu";
      action = helpers.mkRaw "require('gitsigns').undo_stage_hunk";
      options.desc = "Unstage Git hunk";
    }
    {
      mode = "n";
      key = "<leader>gd";
      action = helpers.mkRaw "require('gitsigns').diffthis";
      options.desc = "View Git diff";
    }
  ];
}
