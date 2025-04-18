{
  plugins.codecompanion = {
    enable = true;
  };

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>cc";
      action = "<cmd>CodeCompanion<cr>";
      options = {
        desc = "Code Companion";
      };
    }
  ];
}
