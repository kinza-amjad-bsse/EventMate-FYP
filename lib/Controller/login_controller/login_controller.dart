import 'package:event_mate/Controller/logged_in_user_controller/logged_in_user_controller.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Model/user_model/user_model.dart';
import 'package:event_mate/backend/firebase_functions/firestore_functions.dart';
import '../../Screens/widgets/native_loader/native_loader.dart';
import '../../backend/custom_snack_bar/custom_snack_bar.dart';
import '../../backend/firebase_functions/firebase_authentication.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool rememberMe = false.obs;

  Future<void> loginFunction() async {
    NativeLoader.showLoader(message: "Signing In...");
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.back();
      CustomSnackBar.show(
        message: "Please fill all the fields!",
      );
      return;
    }
    dynamic result = await FirebaseAuthentication.loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    if (result == true) {
      Get.back();
      Get.offAllNamed(
        AppPages.homeScreen,
      );
    } else {
      Get.back();
      CustomSnackBar.show(
        message: "Something went wrong! $result",
      );
    }
  }

  Future<void> loginWithGoogle() async {
    NativeLoader.showLoader(message: "Signing In...");
    bool result = await FirebaseAuthentication.googleSignInUser();
    if (result) {
      // Get User from Firestore and if user is not present then add user to firestore
      loggedInUserController.userModel = await FirestoreFunctions.getUserData();
      if (loggedInUserController.userModel.email == "") {
        Get.back();
        NativeLoader.showLoader(message: "Signing Up...");
        UserModel model = UserModel(
          email: FirebaseAuthentication.firebaseAuth.currentUser!.email!,
          uid: FirebaseAuthentication.firebaseAuth.currentUser!.uid,
          phoneNumber:
              FirebaseAuthentication.firebaseAuth.currentUser?.phoneNumber ??
                  "",
          role: AppRoles.customer,
          profileImage: loggedInUserController.userModel.profileImage,
          name: FirebaseAuthentication.firebaseAuth.currentUser?.displayName !=
                  null
              ? FirebaseAuthentication.firebaseAuth.currentUser!.displayName!
              : "",
          address: "",
          categories: [],
          countryCode: "",
          education: "",
          experience: "",
          featuredImages: [],
          idCardNo: "",
          skills: "",
          isComplete: false,
          about: "",
          featureImage: "",
        );
        loggedInUserController.assignUserModel(userModel: model);
        bool addUserResult = await FirestoreFunctions.addUserToFirestore(
          userModel: loggedInUserController.userModel,
        );
        if (addUserResult) {
          Get.back();
          CustomSnackBar.show(
            message: "You've been Registered Successfully as Customer!",
          );
          Get.offAllNamed(
            AppPages.homeScreen,
          );
        } else {
          Get.back();
          CustomSnackBar.show(
            message: "Something went wrong!",
          );
        }
      } else {
        Get.back();
        CustomSnackBar.show(
          message: "You're Successfully Signed In...",
        );
        Get.offAllNamed(
          AppPages.homeScreen,
        );
      }
    } else {
      Get.back();
      CustomSnackBar.show(
        message: "Something went wrong!",
      );
    }
  }
}
