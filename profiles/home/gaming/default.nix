{ ... }: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      toggle_hud = "Shift_L+F11";
      no_display = true;
      full = true;
    };
  };
}
