{
  description = "Sk4rd's Wallpaper Flake";

  outputs = { self, ... }: {
    homeManagerModules.wallpapers = { config, lib, ... }: {
      options.wallpapers.selection = lib.mkOption {
        type = lib.types.enum [ "voxel" "steampunk" "purin" "kuromi" ];
        default = "voxel";
        description = "Select the wallpaper directory theme";
      };

      config = {
        pictures.source = let
          picMap = {
            voxel = "${self}/voxel";
            steampunk = "${self}/steampunk";
            purin = "${self}/purin";
            kuromi = "${self}/kuromi";
          };
        in
          picMap.${config.wallpapers.selection};
        
        home.file."${config.xdg.userDirs.pictures}/wallpapers" = config.wallpapers.source;
      };
    };
  };
}
