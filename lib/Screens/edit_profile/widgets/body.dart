import 'package:event_mate/Controller/edit_profile_controller/edit_profile_controller.dart';
import 'package:event_mate/Controller/logged_in_user_controller/logged_in_user_controller.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Model/user_model/user_model.dart';
import 'package:event_mate/Screens/edit_profile/widgets/submit_button.dart';
import 'cat_options.dart';
import 'image_selection_widget.dart';

// ignore: must_be_immutable
class EditProfileBody extends StatelessWidget {
  EditProfileBody({
    super.key,
  });

  EditProfileController controller = Get.put(
    EditProfileController(),
  );

  @override
  Widget build(BuildContext context) {
    controller.setData();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appTheme,
        title: Text(
          "Edit Profile",
          style: AppFonts.poppinsFont.copyWith(
            color: AppColors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 30.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  loggedInUserController.userModel.email,
                  style: AppFonts.poppinsFont.copyWith(
                    color: AppColors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                "Profile Image",
                style: AppFonts.poppinsFont.copyWith(
                  color: AppColors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => ImageSelectionWidget(
                  width: 1.sw,
                  onTapFunction: () async {
                    await controller.imagePicker();
                  },
                  imageLink: loggedInUserController.userModel.profileImage !=
                          UserModel.defaultProfileImage
                      ? loggedInUserController.userModel.profileImage
                      : "",
                  isFile: controller.profileSelected.value,
                  filePath: controller.selectedFilePath.value,
                  notProfile: false,
                  onDeleteTap: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  bottom: 20.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (loggedInUserController.userModel.role ==
                        AppRoles.eventManager)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Categories",
                            style: AppFonts.poppinsFont.copyWith(
                              color: AppColors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          SizedBox(
                            width: 1.sw,
                            height: 40.h,
                            child: ListView.builder(
                              itemCount: controller.catOptions.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (cnt, index) {
                                return Obx(
                                  () => Padding(
                                    padding: EdgeInsets.only(
                                      right: 10.w,
                                    ),
                                    child: ProfileCategoryBubble(
                                      label: controller.catOptions[index].title,
                                      isSelected: controller
                                          .catOptions[index].isSelected.value,
                                      onPressed: () {
                                        controller.catOptions[index].isSelected
                                                .value =
                                            !controller.catOptions[index]
                                                .isSelected.value;
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 15.h,
                    ),
                    for (int index = 0;
                        index <
                            (controller.isCustomer.value
                                ? controller.customerProfile.length
                                : controller.eventManagerProfile.length);
                        index++)
                      if (index == 1)
                        const SizedBox()
                      else
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 20.h,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loggedInUserController.userModel.role ==
                                        AppRoles.customer
                                    ? controller.customerProfile[index].title
                                    : controller
                                        .eventManagerProfile[index].title,
                                style: AppFonts.poppinsFont.copyWith(
                                  color: AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              loggedInUserController.userModel.role ==
                                      AppRoles.customer
                                  ? controller.customerProfile[index].textField
                                  : controller
                                      .eventManagerProfile[index].textField,
                            ],
                          ),
                        ),
                    if (loggedInUserController.userModel.role ==
                        AppRoles.eventManager)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Featured Image",
                            style: AppFonts.poppinsFont.copyWith(
                              color: AppColors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Obx(
                            () => ImageSelectionWidget(
                              width: 1.sw,
                              onTapFunction: () async {
                                await controller.featureImagePicker();
                              },
                              imageLink: controller.featuredImage.value,
                              isFile: controller.featureImageSelected.value,
                              filePath: controller.featuredImage.value,
                              // imageLink: controller.multiImages.isNotEmpty
                              //     ? controller.multiImages[0].isFeatured
                              //         ? controller.multiImages[0].path.value
                              //         : ""
                              //     : "",
                              // isFile: controller.multiImages.isNotEmpty
                              //     ? controller.multiImages[0].isFeatured &&
                              //         !controller.multiImages[0].isUploaded
                              //     : false,
                              // filePath: controller.multiImages.isNotEmpty
                              //     ? controller.multiImages[0].isFeatured
                              //         ? controller.multiImages[0].path.value
                              //         : ""
                              //     : "",
                              notProfile: true,
                              onDeleteTap: () {
                                controller.deleteFeaturedImage();
                              },
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SubmitButton(
                      onTapFunction: () {
                        controller.updateProfile();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
