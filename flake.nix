{
  description = "Sk4rd's Wallpaper Flake";

  outputs = { self, ... }: {
    homeManagerModules.wallpaper-module = { config, lib, ... }: {
      options.wallpaper.theme = lib.mkOption {
        type = lib.types.str;
        description = "Wallpaper theme to use.";
      };

      config.home.file."${config.xdg.userDirs.pictures}".source = "${self}/wallpapers/${config.wallpaper.theme}";
    };
    
  };
}
