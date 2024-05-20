import 'dart:async';
import 'package:event_mate/Exporter/export_page.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../backend/firebase_functions/firebase_authentication.dart';
import '../../backend/shared_pref_keys/shared_pref_keys.dart';

class SplashController extends GetxController {
  navigateToOnBoardingScreen() async {
    Timer(
      2.seconds,
      () async {
        Get.offAll(
          () => FirebaseAuthentication.firebaseAuth.currentUser == null
              ? const OnboardingScreen()
              : const HomeScreen(),
          duration: 300.milliseconds,
          transition: Transition.circularReveal,
        );
      },
    );
  }

  updateValues() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int appOpenedTimes = sharedPreferences.getInt(SharedPrefKeys.appStart) ?? 0;
    debugPrint("App Open Starter: $appOpenedTimes");
    appOpenedTimes++;
    debugPrint("App Open Starter: $appOpenedTimes");
    sharedPreferences.setInt(
      SharedPrefKeys.appStart,
      appOpenedTimes,
    );
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await navigateToOnBoardingScreen();
    await updateValues();
  }
}
