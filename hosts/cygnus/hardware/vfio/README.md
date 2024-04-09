# VFIO

Configure PCI devices using `ls-iommu-groups`

Download patched image (or install win-virtio and tools manually on VM)

```bash
nix-shell -p quickemu --run "quickget windows 10"
```

## virt-manager

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

### [Looking Glass](https://looking-glass.io/docs/stable/install/)

Install host application on the VM

#### Add shared memory for looking glass

```xml
<shmem name="looking-glass">
    <model type="ivshmem-plain"/>
    <size unit="M">32</size>
</shmem>
```

#### Keyboard/mouse/display/audio

- Make sure `<graphics type='spice'>` is present
- In `<video>` set `<model type='vga'/>`
- Remove `<input type='tablet'/>`
- Create `<input type='mouse' bus='virtio'/>`
- Create `<input type='keyboard' bus='virtio'/>`
- Enable audio support

```xml
<sound model='ich9'>
  <audio id='1'/>
</sound>
<audio id='1' type='spice'/>
```

#### Clipboard sync

```xml
<channel type="spicevmc">
  <target type="virtio" name="com.redhat.spice.0"/>
</channel>
```

#### Memballoon

This causes issues with VFIO and should be disabled

```diff
- <memballoon model="virtio">
-     <address type="pci" domain="0x0000" bus="0x00" slot="0x08" function="0x0"/>
- </memballoon>
+ <memballoon model="none"/>
```
