{ ... }:

{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; 
              priority = 1; 
            };
            
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
