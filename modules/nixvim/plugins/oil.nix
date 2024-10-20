{
  plugins.oil = {
    enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>Oil<cr>";
      options.desc = "Browse files";
    }
  ];
}
