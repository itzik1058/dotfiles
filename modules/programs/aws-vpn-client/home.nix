{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.programs.aws-vpn-client;
in
{
  options.programs.aws-vpn-client = {
    enable = mkEnableOption "AWS VPN Client";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (buildGoModule rec {
        pname = "awsvpnclient";
        version = "cae3a69821bd2ad78423ae585d212400531fdb8d";

        src = fetchFromGitHub {
          owner = "ymatsiuk";
          repo = "aws-vpn-client";
          rev = "${version}";
          sha256 = "sha256-vJRQnTzJuhpYxG8YhH+QcZoRwvuuUzFOpunNo9mrfwI=";
        };

        vendorHash = "sha256-602xj0ffJXQW//cQeByJjtQnU0NjqOrZWTCWLLhqMm0=";

        nativeBuildInputs = [ makeWrapper ];

        postInstall = ''
          cp ${src}/awsvpnclient.yml.example $out/awsvpnclient.yml

          substituteInPlace $out/awsvpnclient.yml \
            --replace /home/myname/aws-vpn-client/openvpn "openvpn" \
            --replace /usr/bin/sudo "sudo"

          makeWrapper $out/bin/aws-vpn-client $out/bin/awsvpnclient \
            --run "cd $out" \
            --prefix PATH : "${
              lib.makeBinPath [
                (openvpn.overrideAttrs (oldAttrs: rec {
                  patches = [
                    (fetchpatch {
                      url = "https://raw.githubusercontent.com/ymatsiuk/aws-vpn-client/f929e910e3d81928a845f9c69f2edba958344ec6/openvpn-v2.6.8-aws.patch";
                      sha256 = "sha256-pbgmt5o/0k4lZ/mZobl0lgg39kxEASpk5hf6ndopayY=";
                    })
                  ];
                }))
                xdg-utils
              ]
            }"
        '';
      })
    ];
  };
}
