import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:event_mate/Controller/logged_in_user_controller/logged_in_user_controller.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Model/wallet_model/wallet_model.dart';
import 'package:event_mate/Utils/print_types.dart';
import 'package:event_mate/backend/custom_snack_bar/custom_snack_bar.dart';
import '../../Model/user_model/user_model.dart';
import '../../Screens/widgets/native_loader/native_loader.dart';
import '../../backend/firebase_functions/firebase_authentication.dart';
import '../../backend/firebase_functions/firestore_functions.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  RxBool isCustomer = false.obs,
      isEventManager = false.obs,
      termsCondition = false.obs;

  Country? selectedCountry;

  Future<void> signUpFunction() async {
    debugPrint("SignUp Function Called");
    NativeLoader.showLoader(message: "Signing Up...");

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneNumber.text.isEmpty) {
      CustomSnackBar.show(
        message: "Please fill all the fields!",
      );
      Get.back();

      FocusScope.of(Get.context!).unfocus();
      return;
    }
    if (isCustomer.value == false && isEventManager.value == false) {
      CustomSnackBar.show(
        message: "Please Select Role!",
      );
      Get.back();
      FocusScope.of(Get.context!).unfocus();
      return;
    }
    if (termsCondition.value == false) {
      CustomSnackBar.show(
        message: "Please Accept Terms and Conditions!",
      );
      Get.back();
      FocusScope.of(Get.context!).unfocus();
      return;
    }

    try {
      dynamic resultSignup = await FirebaseAuthentication.signUpUser(
        email: emailController.text,
        password: passwordController.text,
      );
      if (resultSignup == true) {
        loggedInUserController.userModel = UserModel(
          email: emailController.text,
          uid: FirebaseAuthentication.firebaseAuth.currentUser!.uid,
          phoneNumber:
              "${AppVariables.selectedCountryCode.value}${phoneNumber.text}",
          role: isCustomer.value == true
              ? AppRoles.customer
              : AppRoles.eventManager,
          profileImage: UserModel.defaultProfileImage,
          name: "",
          address: "",
          categories: [],
          countryCode: AppVariables.selectedCountryCode.value,
          education: "",
          experience: "",
          featuredImages: [],
          idCardNo: "",
          skills: "",
          about: "",
          featureImage: "",
          isComplete: false,
        );
        bool resultFirestore = await FirestoreFunctions.addUserToFirestore(
          userModel: loggedInUserController.userModel,
        );
        Get.back();

        FocusScope.of(Get.context!).unfocus();
        if (resultFirestore) {
          FirebaseFirestore.instance
              .collection("wallet")
              .doc(
                FirebaseAuthentication.firebaseAuth.currentUser!.uid,
              )
              .set(
                WalletModel(
                  depositAmount: "0.0",
                  earnedAmount: "0.0",
                  withdrawnAmount: "0.0",
                  transactions: [],
                ).toJson(),
              );
          CustomSnackBar.show(
            message: "User Registered Successfully!",
          );
          loggedInUserController.isLoggedIn.value = true;
          loggedInUserController.userModel = loggedInUserController.userModel;
          Get.offAllNamed(
            AppPages.homeScreen,
          );
        } else {
          CustomSnackBar.show(
            message: "Something went wrong!",
          );
        }
      } else {
        Get.back();
        FocusScope.of(Get.context!).unfocus();
        CustomSnackBar.show(
          message: "Something went wrong! $resultSignup",
        );
      }
    } catch (error) {
      Get.back();
      FocusScope.of(Get.context!).unfocus();
      myPrint(
        message: error.toString(),
        type: PrintTypes.error,
      );
      CustomSnackBar.show(
        message: "Something went wrong! $error",
      );
    }
  }

  openCountryPicker({required BuildContext context}) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        selectedCountry = country;
        AppVariables.selectedCountryCode.value = "+${country.phoneCode}";

        myPrint(
          message: 'Select country: ${AppVariables.selectedCountryCode.value}',
          type: PrintTypes.info,
        );
      },
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: AppColors.white,
        textStyle: AppFonts.poppinsFont.copyWith(
          color: AppColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Future<void> signUpWithGoogle() async {
    NativeLoader.showLoader(message: "Signing Up...");
    bool result = await FirebaseAuthentication.googleSignInUser();
    if (result) {
      loggedInUserController.userModel = UserModel(
        email: FirebaseAuthentication.currentUser!.email!,
        uid: FirebaseAuthentication.currentUser!.uid,
        phoneNumber: FirebaseAuthentication.currentUser?.phoneNumber ?? "",
        role: AppRoles.customer,
        profileImage: loggedInUserController.userModel.profileImage,
        name: FirebaseAuthentication.currentUser?.displayName != null
            ? FirebaseAuthentication.currentUser!.displayName!
            : "",
        address: "",
        categories: [],
        countryCode: "",
        education: "",
        experience: "",
        featuredImages: [],
        idCardNo: "",
        about: "",
        skills: "",
        isComplete: false,
        featureImage: "",
      );
      bool resultFirestore = await FirestoreFunctions.addUserToFirestore(
        userModel: loggedInUserController.userModel,
      );
      if (resultFirestore) {
        FirebaseFirestore.instance
            .collection("wallet")
            .doc(
              FirebaseAuthentication.firebaseAuth.currentUser!.uid,
            )
            .set(
              WalletModel(
                depositAmount: "0.0",
                earnedAmount: "0.0",
                withdrawnAmount: "0.0",
                transactions: [],
              ).toJson(),
            );
        Get.back();
        CustomSnackBar.show(
          message: "User Registered Successfully!",
        );
        loggedInUserController.isLoggedIn.value = true;
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
        message: "Something went wrong!",
      );
    }
  }
}
