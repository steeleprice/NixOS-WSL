# NixOS on WSL

I found the existing documentation about how to create a deployable installation 
set for WSL to be confusing.  

It is my hope this is easy to follow to get results.

There are several good deployments out there, [Ubuntu](https://ubuntu.com/wsl) and [Debian](https://salsa.debian.org/debian/WSL) are two such examples.

> **I am working heavily in the language learning, syntax and semantics fields of computer science.** I am also moving more and more into **functional programming** and working with it in cross-platform ways. *I need a better package system, one I can evaluate as a language expression, and able to work across distributed systems and distros.*

# Nix
> "Nix is a powerful package manager for Linux and other Unix systems that makes package management reliable and reproducible. It provides atomic upgrades and rollbacks, side-by-side installation of multiple versions of a package, multi-user package management and easy setup of build environments."

# NixOS
> "NixOS is a Linux distribution with a unique approach to package and configuration management. Built on top of the Nix package manager, it is completely declarative, makes upgrading systems reliable, [and has many other advantages](https://nixos.org/nixos/about.html)."

## What we want:

> By building entire system configurations from a Nix expression, NixOS ensures that such configurations don’t overwrite each other, can be rolled back, and so on.

A minimal root filesystem for running NixOS on WSL. 
It is side-loaded or installed with [DistroLauncher](https://github.com/microsoft/WSL-DistroLauncher) as `install.tar.gz`.

It is expected that `/nix/var/nix/profiles/system/activate` is run during
installation, for example as part of the `DistributionInfo::CreateUser` function.

### **systemd** support

WSL comes with its own (non-substitutable) init system while NixOS uses systemd.
Simply starting systemd later on does not work out of the box, because systemd
as system instance refuses to start if it is not PID 1. This unfortunate
combination is resolved in two ways:

* the user's default shell is replaced by a wrapper script that acts is init
  system and then drops to the actual shell
* systemd is started in its own PID namespace; therefore, it is PID 1. The shell
  wrapper (see above) enters the systemd namespace before dropping to the shell.

### How to build the file system

`$ nix-build -A system -A config.system.build.tarball ./nixos.nix`

The resulting mini rootfs can then be found as
`./result-2/tarball/nixos-system-x86_64-linux.tar.gz`.

`cp ./result-2/tarball/nixos-system-x86_64-linux.tar.gz <repo>/x64/install.tar.gz`

******

### Further links

- [DistroLauncher](https://github.com/microsoft/WSL-DistroLauncher)

- [A quick way into a systemd "bottle" for WSL](https://github.com/arkane-systems/genie)

- [NixOS in Windows Store for Windows Subsystem for Linux](https://github.com/NixOS/nixpkgs/issues/30391)

- [wsl2-hacks](https://github.com/shayne/wsl2-hacks)

