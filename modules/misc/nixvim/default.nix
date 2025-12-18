{
  inputs,
  ...
}:
let
  nixvimModule = import ./_;
in
{
  flake = {
    modules.nixos.nixvim = {
      imports = [ inputs.nixvim.nixosModules.nixvim ];
    };
    modules.homeManager.nixvim = {
      imports = [ inputs.nixvim.homeModules.nixvim ];
      config = {
        programs.nixvim = nixvimModule;
      };
    };
    test = nixvimModule;
  };

  perSystem =
    {
      inputs',
      system,
      ...
    }:
    {
      checks = {
        nvim = inputs.nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule {
          inherit system;
          module = nixvimModule;
        };
      };

      packages.nvim = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
        inherit system;
        module = nixvimModule;
      };
    };
}
