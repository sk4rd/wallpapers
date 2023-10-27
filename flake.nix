{
  description = "Sk4rd's Wallpaper Flake";

  outputs = { self, ... }: {
    homeManagerModules.wallpaper-module = { config, lib, ... }:
      with lib; {
        options = {
          wallpaper.theme = mkOption {
            type = types.enum [ "voxel" "steampunk" "purin" "kuromi" ];
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
          "${self}/${config.wallpaper.theme}";
      };
  };
}
