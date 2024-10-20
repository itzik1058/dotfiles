{
  plugins.toggleterm = {
    enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>ToggleTerm<cr>";
      options = {
        desc = "Toggle Terminal Window";
      };
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>ToggleTerm direction=float<cr>";
      options = {
        desc = "Toggle Floating Terminal Window";
      };
    }
  ];
}
