{
  flake = {
    modules.homeManager.swaync = {
      config = {
        services.swaync = {
          enable = true;
          style = builtins.readFile ./style.css;
          settings = {
            widgets = [
              "title"
              "dnd"
              "backlight"
              "volume"
              "mpris"
              "notifications"
            ];
            widget-config = {
              title = {
                text = "Notifications";
                clear-all-buttons = true;
                button-text = "Clear All";
              };
              dnd.text = "Do Not Disturb";
              backlight = {
                label = "󰃞";
                device = "intel_backlight";
                min = 10;
              };
              volume.label = "";
              mpris = {
                image-size = 96;
                image-radius = 12;
              };
            };
          };
        };
      };
    };
  };
}
