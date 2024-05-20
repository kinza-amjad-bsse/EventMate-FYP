import 'package:event_mate/Controller/logged_in_user_controller/logged_in_user_controller.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Model/user_model/user_model.dart';
import 'package:event_mate/backend/firebase_functions/firestore_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreenController extends GetxController {
  Map<String, dynamic> profileData = {};

  setData(UserModel model) {
    profileData = {
      "About Me": model.about,
      "Education": model.education,
      "Skills": model.skills,
      "Past Experience": model.experience,
    };
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    loggedInUserController.walletModel = await FirestoreFunctions.getUserWallet(
      FirebaseAuth.instance.currentUser!.uid,
    );
  }
}
