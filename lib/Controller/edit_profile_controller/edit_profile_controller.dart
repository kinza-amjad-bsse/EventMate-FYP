import 'package:country_picker/country_picker.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Screens/widgets/native_loader/native_loader.dart';
import 'package:event_mate/backend/custom_snack_bar/custom_snack_bar.dart';
import 'package:event_mate/backend/firebase_functions/firestore_functions.dart';
import 'package:event_mate/backend/firebase_functions/storage_functions.dart';
import 'package:image_picker/image_picker.dart';
import '../../Model/edit_profile_model/edit_profile_model.dart';
import '../../Model/user_model/user_model.dart';
import '../../Utils/print_types.dart';
import '../logged_in_user_controller/logged_in_user_controller.dart';

class EditProfileController extends GetxController {
  RxBool isCustomer = false.obs;
  RxBool profileSelected = false.obs;
  RxBool featureImageSelected = false.obs;
  RxString selectedFilePath = "".obs;
  RxList<MultiImagesModel> multiImages = <MultiImagesModel>[].obs;
  RxString featuredImage = "".obs;

  RxList<OptionsModel> catOptions = [
    OptionsModel(
      title: "Event Managers",
      isSelected: false.obs,
    ),
    OptionsModel(
      title: "Venues",
      isSelected: false.obs,
    ),
    OptionsModel(
      title: "Decor",
      isSelected: false.obs,
    ),
    OptionsModel(
      title: "Catering",
      isSelected: false.obs,
    ),
    OptionsModel(
      title: "Photography",
      isSelected: false.obs,
    ),
  ].obs;

  setData() {
    if (loggedInUserController.userModel.role == AppRoles.customer) {
      customerProfile[0].controller.text =
          loggedInUserController.userModel.name;
      customerProfile[1].controller.text =
          loggedInUserController.userModel.email;
      customerProfile[2].controller.text =
          loggedInUserController.userModel.phoneNumber;
      customerProfile[3].controller.text =
          loggedInUserController.userModel.address;
    } else if (loggedInUserController.userModel.role == AppRoles.eventManager) {
      eventManagerProfile[0].controller.text =
          loggedInUserController.userModel.name;

      customerProfile[1].controller.text =
          loggedInUserController.userModel.email;

      eventManagerProfile[2].controller.text =
          loggedInUserController.userModel.phoneNumber;

      eventManagerProfile[3].controller.text =
          loggedInUserController.userModel.address;

      eventManagerProfile[4].controller.text =
          loggedInUserController.userModel.idCardNo;

      eventManagerProfile[5].controller.text =
          loggedInUserController.userModel.education;

      eventManagerProfile[6].controller.text =
          loggedInUserController.userModel.skills;

      eventManagerProfile[7].controller.text =
          loggedInUserController.userModel.about;

      eventManagerProfile[8].controller.text =
          loggedInUserController.userModel.rate.toString();

      eventManagerProfile[9].controller.text =
          loggedInUserController.userModel.experience;

      featuredImage.value = loggedInUserController.userModel.featureImage;

      for (var element in loggedInUserController.userModel.featuredImages) {
        multiImages.add(
          MultiImagesModel(
            path: element.obs,
            isUploaded: true,
          ),
        );
      }

      for (int i = 0; i < catOptions.length; i++) {
        if (loggedInUserController.userModel.categories
            .contains(catOptions[i].title)) {
          catOptions[i].isSelected.value = true;
        }
      }

      update();
    }
  }

  List<EditProfileModel> customerProfile = [
    EditProfileModel(
      title: "Name",
      isOptional: false,
    ),
    EditProfileModel(
      title: "Email Address",
      enabled: false,
      isOptional: false,
    ),
    EditProfileModel(
      title: "Phone Number",
      isPhoneNumber: true,
      isOptional: false,
    ),
    EditProfileModel(
      title: "Address",
      isOptional: true,
    ),
  ];

  List<EditProfileModel> eventManagerProfile = [
    EditProfileModel(
      // 1
      title: "Name",
      isOptional: false,
      keyboardType: TextInputType.name,
    ),
    EditProfileModel(
      // 2
      title: "Email Address",
      enabled: false,
      isOptional: false,
      keyboardType: TextInputType.emailAddress,
    ),
    EditProfileModel(
      // 3
      title: "Phone Number",
      isPhoneNumber: true,
      isOptional: false,
      keyboardType: TextInputType.phone,
    ),
    EditProfileModel(
      // 4
      title: "Address",
      isOptional: true,
      keyboardType: TextInputType.streetAddress,
    ),
    EditProfileModel(
      // 5
      title: "ID Card No.",
      isOptional: true,
      keyboardType: TextInputType.number,
    ),
    EditProfileModel(
      // 6
      title: "Education",
      isOptional: true,
      keyboardType: TextInputType.text,
    ),
    EditProfileModel(
      // 7
      title: "Skills (separated by comma)",
      isOptional: true,
    ),
    EditProfileModel(
      // 8
      title: "About Yourself",
      isOptional: true,
      keyboardType: TextInputType.multiline,
    ),
    EditProfileModel(
      // 9
      title: "Rate (\$)",
      isOptional: true,
      keyboardType: TextInputType.number,
    ),
    EditProfileModel(
      // 10
      title: "Past Experience",
      isOptional: true,
      keyboardType: TextInputType.multiline,
    ),
  ];

  Country selectedCountry = Country.worldWide;

  /// Ask User to Pick an image and return the path of the image
  Future<String> imagePicker() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileSelected.value = true;
      selectedFilePath.value = pickedFile.path;
      return pickedFile.path;
    }
    profileSelected.value = false;
    selectedFilePath.value = "";
    return "";
  }

  Future<String> featureImagePicker() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      featureImageSelected.value = true;
      featuredImage.value = pickedFile.path;
      return pickedFile.path;
    }
    featureImageSelected.value = false;
    featuredImage.value = "";
    return "";
    // if (pickedFile != null) {
    //   featuredImage.value = pickedFile.path;
    //
    // if (multiImages.isNotEmpty) {
    //   if (multiImages[0].isFeatured) {
    //     multiImages[0].path = pickedFile.path.obs;
    //   }
    // } else {
    //   multiImages.add(
    //     MultiImagesModel(
    //       path: pickedFile.path.obs,
    //       isUploaded: false,
    //       isFeatured: true,
    //     ),
    //   );
    // }
    //   return pickedFile.path;
    // }
    // return "";
  }

  Future<bool> multiImagePicker() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage();
    if (pickedFile.isNotEmpty) {
      for (var element in pickedFile) {
        multiImages.add(
          MultiImagesModel(
            path: element.path.obs,
            isUploaded: false,
          ),
        );
      }
      update();
      return true;
    }
    return false;
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

  @override
  void onInit() {
    if (loggedInUserController.userModel.role == AppRoles.customer) {
      isCustomer.value = true;
    } else {
      isCustomer.value = false;
    }
    setData();
    super.onInit();
  }

  Future<void> updateProfile() async {
    NativeLoader.showLoader(message: "Updating Profile...");
    loggedInUserController.userModel.countryCode =
        AppVariables.selectedCountryCode.value;

    if (profileSelected.value) {
      String downloadableUrl = await FirebaseStorageFunctions.uploadImage(
        path: selectedFilePath.value,
      );
      loggedInUserController.userModel.profileImage = downloadableUrl == ""
          ? UserModel.defaultProfileImage
          : downloadableUrl;
    }
    try {
      if (isCustomer.value) {
        loggedInUserController.userModel.name =
            customerProfile[0].controller.text;
        loggedInUserController.userModel.phoneNumber =
            customerProfile[2].controller.text;
        loggedInUserController.userModel.address =
            customerProfile[3].controller.text;
      } else {
        loggedInUserController.userModel.name =
            eventManagerProfile[0].controller.text;

        loggedInUserController.userModel.phoneNumber =
            eventManagerProfile[2].controller.text;

        loggedInUserController.userModel.countryCode =
            AppVariables.selectedCountryCode.value;

        loggedInUserController.userModel.address =
            eventManagerProfile[3].controller.text;

        loggedInUserController.userModel.idCardNo =
            eventManagerProfile[4].controller.text;

        loggedInUserController.userModel.education =
            eventManagerProfile[5].controller.text;

        loggedInUserController.userModel.skills =
            eventManagerProfile[6].controller.text;

        loggedInUserController.userModel.about =
            eventManagerProfile[7].controller.text;

        loggedInUserController.userModel.rate =
            double.parse(eventManagerProfile[8].controller.text);

        loggedInUserController.userModel.experience =
            eventManagerProfile[9].controller.text;

        for (var element in catOptions) {
          if (element.isSelected.value) {
            if (!loggedInUserController.userModel.categories
                .contains(element.title)) {
              loggedInUserController.userModel.categories.add(
                element.title,
              );
            }
          } else {
            if (loggedInUserController.userModel.categories
                .contains(element.title)) {
              loggedInUserController.userModel.categories.removeWhere(
                (element2) => element2 == element.title,
              );
            }
          }
        }

        if (multiImages.isNotEmpty) {
          List<String> images = [];
          for (var element in multiImages) {
            if (!element.isUploaded) {
              String downloadableUrl =
                  await FirebaseStorageFunctions.uploadImage(
                      path: element.path.value);
              images.add(downloadableUrl);
            } else {
              images.add(element.path.value);
            }
          }
          loggedInUserController.userModel.featuredImages = [];
          loggedInUserController.userModel.featuredImages = images;
        }
        if (featureImageSelected.value) {
          String downloadableUrl = await FirebaseStorageFunctions.uploadImage(
            path: featuredImage.value,
          );
          loggedInUserController.userModel.featureImage = downloadableUrl;
          featureImageSelected.value = false;
          featuredImage.value = downloadableUrl;
        }
      }

      if (loggedInUserController.userModel.name != "" &&
          loggedInUserController.userModel.phoneNumber != "" &&
          loggedInUserController.userModel.idCardNo != "" &&
          loggedInUserController.userModel.education != "" &&
          loggedInUserController.userModel.about != "" &&
          loggedInUserController.userModel.skills != "" &&
          loggedInUserController.userModel.rate != 0.0 &&
          loggedInUserController.userModel.experience != "") {
        loggedInUserController.userModel.isComplete = true;
      } else {
        loggedInUserController.userModel.isComplete = false;
      }
      bool updated = await FirestoreFunctions.updateUser(
        loggedInUserController.userModel,
      );
      if (updated) {
        CustomSnackBar.show(message: "Profile Updated Successfully");
      } else {
        CustomSnackBar.show(message: "Unable to Update");
      }
      FocusScope.of(Get.context!).unfocus();
      Get.back();
      Get.back();
      loggedInUserController.update();
    } catch (error) {
      FocusScope.of(Get.context!).unfocus();
      Get.back();
      Get.back();
      loggedInUserController.update();
      CustomSnackBar.show(message: "Unable to Update: $error");
    }
  }

  void deleteFeaturedImage() {
    featuredImage.value = "";
    featureImageSelected.value = false;
    // if (multiImages.isNotEmpty) {
    //   if (multiImages[0].isFeatured) {
    //     multiImages.removeAt(0);
    //   }
    // }
    update();
  }
}

class MultiImagesModel {
  RxString path;
  bool isUploaded = false;
  bool isFeatured = false;

  MultiImagesModel({
    required this.path,
    required this.isUploaded,
    this.isFeatured = false,
  });
}

class OptionsModel {
  String title;
  RxBool isSelected;

  OptionsModel({
    required this.title,
    required this.isSelected,
  });
}
