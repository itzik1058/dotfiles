# VFIO

Configure PCI devices using `ls-iommu-groups`

Download patched image (or install win-virtio and tools manually on VM)

```bash
nix-shell -p quickemu --run "quickget windows 10"
```

## virt-manager

Use i440fx chipset

### Virtio

Change disk target bus from `sata` to `virtio` and address type to `pci` after Windows recognizes virtio driver.

In case of BSOD add dummy virtio drive and reboot in safe mode
https://superuser.com/questions/1057959/windows-10-in-kvm-change-boot-disk-to-virtio

```bash
bcdedit /set "{current}" safeboot minimal
```

Shutdown the VM, remove dummy drive and change sata disk to virtio

Disable safe boot

```bash
bcdedit /deletevalue "{current}" safeboot
```

### Share mouse and keyboard

Remove tablet and add evdev devices for mouse and keyboard

```xml
<input type="evdev">
    <source dev="/dev/input/by-id/usb-???-event-mouse"/>
</input>
<input type="evdev">
    <source dev="/dev/input/by-id/usb-???-event-kbd" grab="all" grabToggle="ctrl-ctrl" repeat="on"/>
</input>
```

### Looking Glass

Add shared memory for looking glass

```xml
<shmem name="looking-glass">
    <model type="ivshmem-plain"/>
    <size unit="M">32</size>
</shmem>
```
