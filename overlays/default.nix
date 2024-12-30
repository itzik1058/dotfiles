{ ghostty, ... }:
[
  (final: prev: {
    ghostty = ghostty.packages.${prev.system}.default;
  })
]
