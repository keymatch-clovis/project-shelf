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
            buildToolsVersion = "33.0.1";
            androidEnv = pkgs.androidenv.override { licenseAccepted = true; };
            androidComposition = androidEnv.composeAndroidPackages {
              buildToolsVersions = [ buildToolsVersion ];
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

                  packages = with pkgs; [ 
                    flutter
                    androidComposition.androidsdk
                    android-tools
                    jdk17
                  ];
                })
              ];
            };
          });
    };
}
