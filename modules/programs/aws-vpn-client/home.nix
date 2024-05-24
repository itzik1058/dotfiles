{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.aws-vpn-client;
in
{
  options.programs.aws-vpn-client = {
    enable = lib.mkEnableOption "AWS VPN Client";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.buildGoModule rec {
        pname = "awsvpnclient";
        version = "cae3a69821bd2ad78423ae585d212400531fdb8d";

        src = pkgs.fetchFromGitHub {
          owner = "ymatsiuk";
          repo = "aws-vpn-client";
          rev = "${version}";
          sha256 = "sha256-vJRQnTzJuhpYxG8YhH+QcZoRwvuuUzFOpunNo9mrfwI=";
        };

        vendorHash = "sha256-602xj0ffJXQW//cQeByJjtQnU0NjqOrZWTCWLLhqMm0=";

        nativeBuildInputs = [ pkgs.makeWrapper ];

        postInstall = ''
          cp ${src}/awsvpnclient.yml.example $out/awsvpnclient.yml

          substituteInPlace $out/awsvpnclient.yml \
            --replace /home/myname/aws-vpn-client/openvpn "openvpn" \
            --replace /usr/bin/sudo "sudo"

          makeWrapper $out/bin/aws-vpn-client $out/bin/awsvpnclient \
            --run "cd $out" \
            --prefix PATH : "${
              lib.makeBinPath [
                (pkgs.openvpn.overrideAttrs (oldAttrs: {
                  patches = [
                    (pkgs.fetchpatch {
                      url = "https://raw.githubusercontent.com/ymatsiuk/aws-vpn-client/f929e910e3d81928a845f9c69f2edba958344ec6/openvpn-v2.6.8-aws.patch";
                      sha256 = "sha256-pbgmt5o/0k4lZ/mZobl0lgg39kxEASpk5hf6ndopayY=";
                    })
                  ];
                }))
                pkgs.xdg-utils
              ]
            }"
        '';
      })
    ];
  };
}
