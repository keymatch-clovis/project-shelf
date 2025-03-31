import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/providers/google_drive/google_auth_client.dart';

class GoogleDriveDataSource {
  Option<GoogleSignInAccount> account;

  GoogleDriveDataSource({this.account = const Option.none()});

  Future<Result<DriveApi, Error>> getDriveApi() async {
    return _signIn().andThenAsync(
      (account) => Result.asyncOf(() async {
        print("Getting Drive API");
        final authHeaders = await account.authHeaders;
        final authenticatedClient = GoogleAuthClient(authHeaders);
        return DriveApi(authenticatedClient);
      }),
    );
  }

  Future<Result<GoogleSignInAccount, Error>> _signIn() async {
    return Result.asyncOf(() async {
      if (account.isNone()) {
        print("Signing in");
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
        account = Option.from(await googleSignIn.signIn());
      }

      return account.unwrapOrElse(() {
        print("User cancelled sign in");
        throw "user cancelled action";
      });
    });
  }
}
