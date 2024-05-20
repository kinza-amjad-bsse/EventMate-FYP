import 'package:event_mate/Controller/logged_in_user_controller/logged_in_user_controller.dart';
import 'package:event_mate/Model/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Utils/my_print.dart';
import '../../Utils/print_types.dart';

class FirebaseAuthentication {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();

  static User? get currentUser => firebaseAuth.currentUser;
  static GoogleSignInAccount? get googleUser => googleSignIn.currentUser;
  static Future<GoogleSignInAuthentication> get googleAuthentication =>
      googleUser!.authentication;

  static Future<bool> googleSignInUser() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        loggedInUserController.userModel.profileImage =
            googleSignInAccount.photoUrl ?? UserModel.defaultProfileImage;
        AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await firebaseAuth.signInWithCredential(authCredential);
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      return false;
    }
  }

  static Future<bool> googleSignOutUser() async {
    try {
      await googleSignIn.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      return false;
    }
  }

  static Future<bool> signOutUser() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      return false;
    }
  }

  static Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      return e;
    }
  }

  static signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      myPrint(
        message: "ERROR While Signing U: ${e.message}",
        type: PrintTypes.error,
      );
      return e.message;
    }
  }
}
