{ pkgs, ... }:
pkgs.writeShellScriptBin "ls-iommu-groups" ''
  #!/bin/bash
  shopt -s nullglob
  for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
      echo "IOMMU Group ''${g##*/}:"
      for d in $g/devices/*; do
          echo -e "\t$(${pkgs.pciutils}/sbin/lspci -nns ''${d##*/})"
      done;
  done;
''
