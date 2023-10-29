{
  description = "Sk4rd's Wallpaper Flake";

  outputs = { self, ... }: {
    homeManagerModules.wallpaper-module = { config, lib, ... }:
      with lib; {
        options = {
          wallpaper.enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable the wallpaper module";
          };
          wallpaper.theme = mkOption {
            type =
              types.enum [ "voxel" "steampunk" "fractals" "purin" "kuromi" ];
            default = "voxel";
            description = "Wallpaper theme to use.";
          };
          wallpaper.directory = mkOption {
            type = types.path;
            default = "${config.xdg.userDirs.pictures}";
            description =
              "Wallpaper directory path (must be in home directory).";
          };
        };

        config.home.file."${config.wallpaper.directory}/wallpapers".source =
          mkIf config.wallpaper.enable "${self}/${config.wallpaper.theme}";
      };
  };
}
