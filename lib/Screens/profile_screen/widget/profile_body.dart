import 'package:event_mate/Controller/logged_in_user_controller/logged_in_user_controller.dart';
import 'package:event_mate/Model/user_model/user_model.dart';
import 'package:event_mate/Screens/widgets/my_text_form_field/my_text_form_field.dart';
import '../../../Controller/profile_screen_controller/profile_screen_controller.dart';
import '../../../Exporter/exporter.dart';
import '../../../backend/custom_snack_bar/custom_snack_bar.dart';
import '../../../backend/firebase_functions/firestore_functions.dart';
import '../../chat_screen/chat_screen_new.dart';
import '../../edit_profile/widgets/cat_options.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({
    super.key,
    required this.model,
  });

  final UserModel model;

  final ProfileScreenController controller = Get.put(
    ProfileScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: GetBuilder<LoggedInUserController>(
        init: loggedInUserController,
        builder: (cnt) {
          controller.setData(model);
          return Stack(
            children: [
              Container(
                height: .26.sh,
                width: 1.sw,
                color: AppColors.appTheme,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 36.w,
                  left: 36.w,
                  top: 60.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: 30.sp,
                          ),
                        ),
                        SizedBox(width: 0.1.sw),
                        SizedBox(
                          width: 0.65.sw,
                          height: 40.h,
                          child: Text(
                            model.name != ""
                                ? model.name
                                : model.email.split("@")[0],
                            style: AppFonts.poppinsFont.copyWith(
                              color: AppColors.white,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 30.h,
                          ),
                          child: Text(
                            "Rate: \$ ${model.rate}",
                            style: AppFonts.poppinsFont.copyWith(
                              color: AppColors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 0.18.sw,
                          backgroundColor: AppColors.white,
                          child: CircleAvatar(
                            radius: 0.16.sw,
                            backgroundColor: AppColors.appTheme,
                            backgroundImage: NetworkImage(
                              model.profileImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.02.sh),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 1.sw,
                              height: .22.sh,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    model.featureImage,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 0.02.sh),
                            SizedBox(
                              width: 1.sw,
                              height: 40.h,
                              child: ListView.builder(
                                itemCount: loggedInUserController
                                    .userModel.categories.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (cnt, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: 10.w,
                                    ),
                                    child: ProfileCategoryBubble(
                                      label: loggedInUserController
                                          .userModel.categories[index],
                                      isSelected: loggedInUserController
                                          .userModel.categories[index]
                                          .contains(
                                        loggedInUserController
                                            .userModel.categories[index],
                                      ),
                                      onPressed: () {},
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 0.02.sh),
                            for (var i in controller.profileData.keys)
                              if (controller.profileData[i] != "")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      i,
                                      style: AppFonts.poppinsFont.copyWith(
                                        color: AppColors.appTheme,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 0.01.sh),
                                    Text(
                                      controller.profileData[i],
                                      style: AppFonts.poppinsFont.copyWith(
                                        color: AppColors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 0.02.sh),
                                  ],
                                ),
                            SizedBox(
                              height: 200.h,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (model.uid == loggedInUserController.userModel.uid)
                Padding(
                  padding: EdgeInsets.only(
                    top: 0.13.sh,
                    left: 30.w,
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        AppPages.editProfileScreen,
                      );
                    },
                    child: Container(
                      width: 150.w,
                      height: 51.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: AppFonts.poppinsFont.copyWith(
                            color: AppColors.appTheme,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (model.uid != loggedInUserController.userModel.uid)
                Positioned(
                  bottom: 10.h,
                  left: 0,
                  child: SizedBox(
                    width: 1.sw,
                    height: 52.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => ChatScreenNew(
                                model: model,
                                receiversId: model.uid,
                              ),
                            );
                          },
                          child: Container(
                            // width: 219.w,
                            width: .4.sw,
                            height: 51.h,
                            decoration: BoxDecoration(
                              color: AppColors.appTheme,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                "Message Me",
                                style: AppFonts.poppinsFont.copyWith(
                                  color: AppColors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if ((loggedInUserController
                                        .walletModel.depositAmount ==
                                    "0.0") ||
                                (double.parse(loggedInUserController
                                        .walletModel.depositAmount) <
                                    model.rate)) {
                              CustomSnackBar.show(
                                message:
                                    "You don't have enough balance to hire this person!",
                              );
                              return;
                            }

                            TextEditingController daysCont =
                                TextEditingController();

                            Get.bottomSheet(
                              Container(
                                width: 1.sw,
                                height: 0.3.sh,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 20.h,
                                    left: 20.w,
                                    right: 20.w,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Days to Complete",
                                        style: AppFonts.poppinsFont.copyWith(
                                          color: AppColors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 0.02.sh),
                                      MyTextFormField(
                                        controller: daysCont,
                                        keyboardType: TextInputType.number,
                                        hint:
                                            "Enter Number of Days to Complete",
                                      ),
                                      SizedBox(height: 0.02.sh),
                                      InkWell(
                                        onTap: () async {
                                          var days =
                                              int.tryParse(daysCont.text);
                                          if (days == null ||
                                              daysCont.text.isEmpty) {
                                            // Hide keyboard..
                                            FocusScope.of(context).unfocus();
                                            Get.back();
                                            CustomSnackBar.show(
                                              message:
                                                  "Please enter a valid number of days!",
                                            );
                                            return;
                                          }

                                          try {
                                            Get.back();
                                            await FirestoreFunctions.hireUser(
                                              model: model,
                                              amount: model.rate,
                                              deadline: DateTime.now().add(
                                                Duration(
                                                  days: days,
                                                ),
                                              ),
                                            );
                                            CustomSnackBar.show(
                                              message: "Hired!",
                                            );
                                          } catch (error) {
                                            CustomSnackBar.show(
                                              message: "Something went wrong!",
                                            );
                                          }
                                        },
                                        child: Center(
                                          child: hireMeButton(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: hireMeButton(),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  hireMeButton() => Container(
        width: .4.sw,
        height: 51.h,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            "Hire Me",
            style: AppFonts.poppinsFont.copyWith(
              color: AppColors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
}
