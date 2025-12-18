{
  plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        diagnostics = "nvim_lsp";
        offsets = [
          {
            filetype = "NvimTree";
            text = "NvimTree";
            text_align = "left";
            separator = true;
          }
        ];
      };
    };
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Next buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Previous buffer";
      };
    }
  ];
}
