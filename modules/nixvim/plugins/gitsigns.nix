{ lib, ... }:
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
      action = lib.nixvim.mkRaw "require('gitsigns').next_hunk";
      options.desc = "Next Git hunk";
    }
    {
      mode = "n";
      key = "[g";
      action = lib.nixvim.mkRaw "require('gitsigns').prev_hunk";
      options.desc = "Previous Git hunk";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action = lib.nixvim.mkRaw "function() require('gitsigns').blame_line { full = true } end";
      options.desc = "View full Git blame";
    }
    {
      mode = "n";
      key = "<leader>gp";
      action = lib.nixvim.mkRaw "require('gitsigns').preview_hunk_inline";
      options.desc = "Preview Git hunk";
    }
    {
      mode = "n";
      key = "<leader>gh";
      action = lib.nixvim.mkRaw "require('gitsigns').reset_hunk";
      options.desc = "Reset Git hunk";
    }
    {
      mode = "n";
      key = "<leader>gr";
      action = lib.nixvim.mkRaw "require('gitsigns').reset_buffer";
      options.desc = "Reset Git buffer";
    }
    {
      mode = "n";
      key = "<leader>gs";
      action = lib.nixvim.mkRaw "require('gitsigns').stage_hunk";
      options.desc = "Stage Git hunk";
    }
    {
      mode = "n";
      key = "<leader>gS";
      action = lib.nixvim.mkRaw "require('gitsigns').stage_buffer";
      options.desc = "Stage Git buffer";
    }
    {
      mode = "n";
      key = "<leader>gu";
      action = lib.nixvim.mkRaw "require('gitsigns').undo_stage_hunk";
      options.desc = "Unstage Git hunk";
    }
    {
      mode = "n";
      key = "<leader>gd";
      action = lib.nixvim.mkRaw "require('gitsigns').diffthis";
      options.desc = "View Git diff";
    }
  ];
}
