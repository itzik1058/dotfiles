{
  flake = {
    modules.homeManager.file-templates =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      with lib;
      let
        cfg = config.home.templateFile;
        homeDirectory = config.home.homeDirectory;
      in
      {
        options = {
          home.templateFile =
            let
              opt = "home.templateFile";
            in
            mkOption {
              description = "Attribute set of jinja2 template files to link into the user home.";
              default = { };
              type = types.attrsOf (
                types.submodule (
                  { name, config, ... }:
                  {
                    options = {
                      enable = mkOption {
                        type = types.bool;
                        default = true;
                        description = ''
                          Whether this file should be generated. This option allows specific
                          files to be disabled.
                        '';
                      };
                      target = mkOption {
                        type = types.str;
                        apply =
                          p:
                          let
                            absPath = if hasPrefix "/" p then p else "${basePath}/${p}";
                          in
                          removePrefix (homeDirectory + "/") absPath;
                        defaultText = literalExpression "name";
                        description = ''
                          Path to target file relative to ${basePathDesc}.
                        '';
                      };
                      text = mkOption {
                        default = null;
                        type = types.nullOr types.lines;
                        description = ''
                          Text of the file. If this option is null then
                          [](#opt-${opt}._name_.source)
                          must be set.
                        '';
                      };
                      source = mkOption {
                        type = types.path;
                        description = ''
                          Path of the source file or directory. If
                          [](#opt-${opt}._name_.text)
                          is non-null then this option will automatically point to a file
                          containing that text.
                        '';
                      };
                      onChange = mkOption {
                        type = types.lines;
                        default = "";
                        description = ''
                          Shell commands to run when file has changed between
                          generations. The script will be run
                          *after* the new files have been linked
                          into place.

                          Note, this code is always run when `recursive` is
                          enabled.
                        '';
                      };
                      force = mkOption {
                        type = types.bool;
                        default = false;
                        description = ''
                          Whether the target path should be unconditionally replaced
                          by the managed file source. Warning, this will silently
                          delete the target regardless of whether it is a file or
                          link.
                        '';
                      };
                      vars = mkOption {
                        type = types.attrs;
                        description = "Attribute set of variables to pass to the jinja2 template.";
                      };
                    };
                    config = {
                      target = mkDefault name;
                      source = mkIf (config.text != null) (
                        mkDefault (
                          pkgs.writeTextFile {
                            inherit (config) text;
                            name = hm.strings.storeFileName name;
                          }
                        )
                      );
                    };
                  }
                )
              );
            };
        };
        config = {
          home.file = mapAttrs (name: value: {
            inherit (value)
              enable
              target
              onChange
              force
              ;
            source =
              let
                jinja2 = lib.getExe' pkgs.jinja2-cli "jinja2";
                data = pkgs.writeTextFile {
                  name = lib.hm.strings.storeFileName "vars.json";
                  text = builtins.toJSON value.vars;
                };
              in
              pkgs.runCommandLocal name { } "${jinja2} ${value.source} ${data} --format json > $out";
          }) cfg;
        };
      };
  };
}
