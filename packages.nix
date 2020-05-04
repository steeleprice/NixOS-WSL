# Fundamental core packages
      environment.systemPackages = with pkgs; [

        # Basic command line tools
        nix-index
        coreutils
        binutils

        # GIT
        #git-full
        #nix-prefetch-git

        # SSH filesystem
        #sshfsFuse

        # Encryption key management
        #gnupg

        # Password hash generator
        #mkpasswd
        #openssl

        # Make NTFS filesystems (e.g., USB drives)
        #ntfs3g

        # Encrypted USB sticks etc
        #cryptsetup

      ];
