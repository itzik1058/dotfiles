{
  plugins.oil = {
    enable = true;
    settings.default_file_explorer = false; # keep netrw for scp
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
