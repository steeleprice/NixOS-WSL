# NixOS on WSL

I found the existing documentation about how to create a deployable installation 
set for WSL to be confusing.  It is my hope this is easy to follow to get results.

## What we want:

A minimal root filesystem for running NixOS on WSL. 
It is side-loaded or installed with [DistroLauncher](https://github.com/microsoft/WSL-DistroLauncher) as `install.tar.gz`.

It is expected that `/nix/var/nix/profiles/system/activate` is run during
installation, for example as part of the `DistributionInfo::CreateUser`
function.


### systemd support

WSL comes with its own (non-substitutable) init system while NixOS uses systemd.
Simply starting systemd later on does not work out of the box, because systemd
as system instance refuses to start if it is not PID 1. This unfortunate
combination is resolved in two ways:

* the user's default shell is replaced by a wrapper script that acts is init
  system and then drops to the actual shell
* systemd is started in its own PID namespace; therefore, it is PID 1. The shell
  wrapper (see above) enters the systemd namespace before dropping to the shell.


### How to build

`$ nix-build -A system -A config.system.build.tarball ./nixos.nix`

The resulting mini rootfs can then be found under
`./result-2/tarball/nixos-system-x86_64-linux.tar.gz`.

******

### Further links

[DistroLauncher](https://github.com/microsoft/WSL-DistroLauncher)
[A quick way into a systemd "bottle" for WSL](https://github.com/arkane-systems/genie)
[NixOS in Windows Store for Windows Subsystem for Linux](https://github.com/NixOS/nixpkgs/issues/30391)
[wsl2-hacks] (https://github.com/shayne/wsl2-hacks)

