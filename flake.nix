{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = forEachSystem (system: {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
        devenv-test = self.devShells.${system}.default.config.test;
      });

      devShells = forEachSystem
        (system:
          let
            pkgs = import nixpkgs {
              inherit system;
              config = {
                android_sdk.accept_license = true;
                allowUnfree = true;
              };
            };
            buildToolsVersion = "34.0.0";
            androidEnv = pkgs.androidenv.override { licenseAccepted = true; };
            androidComposition = androidEnv.composeAndroidPackages {
              buildToolsVersions = [ "33.0.1" "34.0.0" ];
              platformVersions = [ "34" "35" ];
              abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
            };
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                ({ pkgs, config, ... }: {
                  # This is your devenv configuration
                  env.ANDROID_HOME = "${androidComposition.androidsdk}/libexec/android-sdk";
                  env.GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidComposition.androidsdk}/libexec/android-sdk/build-tools/${buildToolsVersion}/aapt2";

                  # I think this is fine, as I'm using like a hybrid thing with
                  # Arch and Nix, so I need to add this atm.
                  # https://discourse.nixos.org/t/libsqlite3-so-no-such-file-or-directory/58556/6
                  env.LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath (with pkgs; [ sqlite ])}:$LD_LIBRARY_PATH";

                  packages = with pkgs; [ 
                    flutter
                    androidComposition.androidsdk
                    gradle
                    android-tools
                    jdk17
                    sqlite
                  ];
                })
              ];
            };
          });
    };
}
