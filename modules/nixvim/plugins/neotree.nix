{
  plugins.neo-tree = {
    enable = true;

    settings = {
      sources = [
        "filesystem"
        "buffers"
        "git_status"
        "document_symbols"
      ];
      add_blank_line_at_top = false;
      event_handlers = {
        file_open_requested.__raw = ''
          function()
            require("neo-tree.command").execute({ action = "close" })
          end
        '';
      };
      filesystem = {
        bind_to_cwd = false;
        follow_current_file = {
          enabled = true;
        };
      };
      default_component_configs = {
        indent = {
          with_expanders = true;
          expander_collapsed = "󰅂";
          expander_expanded = "󰅀";
          expander_highlight = "NeoTreeExpander";
        };

        git_status = {
          symbols = {
            added = " ";
            conflict = "󰩌 ";
            deleted = "󱂥";
            ignored = " ";
            modified = " ";
            renamed = "󰑕";
            staged = "󰩍";
            unstaged = "";
            untracked = " ";
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>e";
      action = "<cmd>Neotree toggle reveal float<cr>";
      options = {
        desc = "Neotree";
      };
    }
  ];
}
