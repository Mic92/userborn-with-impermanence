{ config, ... }: {
  disko.devices.disk.main.device = "/dev/sda";

  services.getty.helpLine = ''
    If you are connect via serial console:
    Type Ctrl-a c to switch to the qemu console
    and `quit` to stop the VM.
  '';

  services.userborn.enable = true;
  services.userborn.passwordFilesLocation = "/var/lib/nixos";

  virtualisation.vmVariantWithDisko = {
    virtualisation.fileSystems."/persistent".neededForBoot = true;
  };

  users.users.user.isNormalUser = true;
  system.etc.overlay.enable = true;
  system.etc.overlay.mutable = true;
  boot.initrd.systemd.enable = true;

  services.getty.autologinUser = "root";

  environment.persistence."/persistent" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      {
        file = "/var/keys/secret_file";
        parentDirectory = {
          mode = "u=rwx,g=,o=";
        };
      }
    ];
    users.user = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "VirtualBox VMs"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        ".local/share/direnv"
      ];
    };
  };
}
