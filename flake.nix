{
  description = "Sk4rd's Wallpaper Flake";

  outputs = { self, ... }: {
    homeManagerModules.wallpaper-module = { config, lib, ... }:
      let
        opt = "options";
        cfg = "config";
        hf = "${cfg}.home.file";
      in with lib; {
        opt.wallpaper.theme = mkOption {
          type = types.enum [ "voxel" "steampunk" "purin" "kuromi" ];
          default = "voxel";
          description = "Wallpaper theme to use.";
        };
        opt.wallpaper.directory = mkOption {
          type = types.path;
          default = "${cfg.xdg.userDirs.pictures}/wallpapers";
          description = "Wallpaper directory path (must be in home directory).";
        };

        hf."${cfg.wallpaper.directory}".source =
          "${self}/${cfg.wallpaper.theme}";
      };
  };
}
