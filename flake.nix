{
  description = "Sk4rd's Wallpaper Flake";

  outputs = { self, ... }: {
    homeManagerModules.wallpapers = { config, lib, ... }: {
      options.wallpapers.source = lib.mkOption {
        type = lib.types.path;
        default = "${self}/voxel";
        description = "Wallpaper path";
      };

      config.home.file."${config.xdg.userDirs.pictures}/wallpapers".source = config.wallpapers.source;
    };
  };
}
