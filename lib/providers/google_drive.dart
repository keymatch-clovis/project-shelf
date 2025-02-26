import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/providers/google_drive/google_auth_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "google_drive.g.dart";

class GoogleDriveState {
  Option<GoogleSignInAccount> account;

  GoogleDriveState({this.account = const Option.none()});
}

@Riverpod(keepAlive: true)
class GoogleDrive extends _$GoogleDrive {
  @override
  Future<GoogleDriveState> build() async {
    return GoogleDriveState();
  }

  Future<DriveApi> getDriveApi() async {
    debugPrint("Getting drive API");
    await signIn();

    final state = await future;
    final account = state.account.unwrap();
    final authHeaders = await account.authHeaders;
    final authenticatedClient = GoogleAuthClient(authHeaders);
    return DriveApi(authenticatedClient);
  }

  Future<void> signIn() async {
    final state = await future;
    debugPrint(state.toString());

    if (state.account.isNone()) {
      debugPrint("Signing in...");
      //  > The application data folder is a special hidden folder that your app
      //  > can use to store application-specific data, such as configuration
      //  > files. The application data folder is automatically created when you
      //  > attempt to create a file in it. Use this folder to store any files
      //  > that the user shouldn't directly interact with. This folder is only
      //  > accessible by your application and its contents are hidden from the
      //  > user and from other Drive apps.
      // See more: https://developers.google.com/drive/api/guides/appdata
      final googleSignIn =
          GoogleSignIn.standard(scopes: [DriveApi.driveAppdataScope]);
      final account = await googleSignIn.signIn();
      debugPrint(account.toString());

      state.account = Option.from(account);

      ref.notifyListeners();
      await future;
    }
  }
}
