{
  plugins.neo-tree = {
    enable = true;
    sources = [
      "filesystem"
      "buffers"
      "git_status"
      "document_symbols"
    ];
    addBlankLineAtTop = false;

    eventHandlers = {
      file_open_requested = ''
        function()
          require("neo-tree.command").execute({ action = "close" })
        end
      '';
    };

    filesystem = {
      bindToCwd = false;
      followCurrentFile = {
        enabled = true;
      };
    };

    defaultComponentConfigs = {
      indent = {
        withExpanders = true;
        expanderCollapsed = "󰅂";
        expanderExpanded = "󰅀";
        expanderHighlight = "NeoTreeExpander";
      };

      gitStatus = {
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

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>e";
      action = "<cmd>Neotree toggle float<cr>";
      options = {
        desc = "Neotree";
      };
    }
  ];
}
