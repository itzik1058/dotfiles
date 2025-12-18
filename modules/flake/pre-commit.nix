{
  inputs,
  ...
}:
{
  perSystem =
    { system, ... }:
    {
      checks = {
        pre-commit-check = inputs.git-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            deadnix.enable = true;
            nixfmt-rfc-style.enable = true;
          };
        };
      };
    };
}
