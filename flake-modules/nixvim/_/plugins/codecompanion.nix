{
  plugins.codecompanion = {
    enable = true;
  };

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>cct";
      action = "<cmd>CodeCompanionChat Toggle<cr>";
      options = {
        desc = "CodeCompanion Chat Toggle";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>cca";
      action = "<cmd>CodeCompanionActions<cr>";
      options = {
        desc = "CodeCompanion Actions";
      };
    }
  ];
}
