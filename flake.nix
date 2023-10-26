{
  description = "Sk4rd's Wallpaper Flake";

  outputs = { self, ... }:
    let
      pics = config.xdg.userDirs.pictures;
    in
      {
        homeManagerModules.pictures = { config, lib, ... }: {
          options.wallpapers.source = lib.mkOption {
            type = lib.types.path;
            default = "${self}/voxel";
            description = "Wallpaper path";
          };

          config.home.file."${pics}/wallpapers".source = config.wallpapers.source;
        };
      };
}
