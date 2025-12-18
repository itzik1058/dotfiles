{
  plugins.snacks = {
    enable = true;
    settings = {
      bigfile.enabled = true;
      debug.enabled = true;
      image.enabled = true;
      input.enabled = true;
      notifier.enabled = true;
      quickfile.enabled = true;
      scroll.enabled = true;
    };
  };

  autoCmd = [
    {
      event = "BufEnter";
      callback.__raw = builtins.readFile ./callback.lua;
    }
  ];
}
