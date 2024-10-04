{ config, pkgs, ... }:
{
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

  # Than bind mount will properly work
  environment.etc."/etc/NetworkManager/system-connections".source = pkgs.runCommand "empty-dir" { } ''
    mkdir $out
  '';

  environment.persistence."/persistent" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    enableDebugging = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [ "/etc/machine-id" ];
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
