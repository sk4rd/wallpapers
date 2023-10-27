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
            default = "${cfg.xdg.userDirs.pictures}/wallpapers";
            description =
              "Wallpaper directory path (must be in home directory).";
          };
        };

        config.home.file."${config.wallpaper.directory}".source =
          "${self}/${config.wallpaper.theme}";
      };
  };
}
