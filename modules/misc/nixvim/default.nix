{
  inputs,
  ...
}:
let
  nixvimModule = import ./_;
in
{
  flake = {
    modules.homeManager.nixvim = {
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
