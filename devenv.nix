{ pkgs, lib, config, inputs, ... }:

{
    env.GRADLE_USER_HOME = "/home/goldencoderam/.gradle";
    android = {
        enable = true;
        flutter.enable = true;

        platforms.version = [ "34" ];
        abis = [ "arm64-v8a" ];
        cmdLineTools.version = "11.0";
        tools.version = "26.1.1";
        platformTools.version = "34.0.5";
        buildTools.version = [ "34.0.0" ];
        googleAPIs.enable = true;
        emulator.enable = false;
        sources.enable = false;
        android-studio.enable = false;
    };
}
