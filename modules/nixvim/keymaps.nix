{
  keymaps = [
    {
      mode = [
        "n"
        "x"
      ];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Down>";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Up>";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "H";
      action = "^";
      options.silent = true;
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "L";
      action = "$";
      options.silent = true;
    }
    {
      mode = [ "n" ];
      key = "<Esc>";
      action = ":noh<CR>";
      options = {
        desc = "Stop hightlighting";
      };
    }
  ];
}
