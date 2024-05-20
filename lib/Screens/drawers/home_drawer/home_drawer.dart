import 'package:event_mate/Controller/logged_in_user_controller/logged_in_user_controller.dart';
import 'package:event_mate/Model/user_model/user_model.dart';
import 'package:event_mate/Screens/wallet_screen/wallet_screen.dart';
import 'package:event_mate/backend/custom_snack_bar/custom_snack_bar.dart';
import 'package:event_mate/backend/firebase_functions/firebase_authentication.dart';
import 'package:event_mate/backend/firebase_functions/firestore_functions.dart';
import '../../../Controller/home_screen_controller/home_screen_controller.dart';
import '../../../Exporter/exporter.dart';
import '../../profile_screen/profile_screen.dart';
import '../../recent_messages/recent_messages.dart';
import '../../widgets/native_loader/native_loader.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 0.7.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 0.7.sw,
                height: 0.2.sh,
                color: AppColors.appTheme,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 60.h,
                    left: 36.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello,",
                        style: AppFonts.poppinsFont.copyWith(
                          color: AppColors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        loggedInUserController.userModel.name != ""
                            ? loggedInUserController.userModel.name
                            : loggedInUserController.userModel.email
                                .split("@")[0],
                        style: AppFonts.poppinsFont.copyWith(
                          color: AppColors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<LoggedInUserController>(
                    init: loggedInUserController,
                    builder: (controller) {
                      return ListTile(
                        title: Text(
                          loggedInUserController.userModel.role ==
                                  AppRoles.customer
                              ? 'Switch to Freelancer'
                              : 'Switch to Customer',
                          style: AppFonts.poppinsFont.copyWith(
                            color: AppColors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () async {
                          NativeLoader.showLoader(
                            message:
                                "Switching to ${loggedInUserController.userModel.role == AppRoles.customer ? "Customer" : "Event Manager"}...",
                          );
                          loggedInUserController.userModel.role =
                              loggedInUserController.userModel.role ==
                                      AppRoles.customer
                                  ? AppRoles.eventManager
                                  : AppRoles.customer;
                          bool updated = await FirestoreFunctions.updateUser(
                            loggedInUserController.userModel,
                          );
                          Get.back();
                          Get.back();
                          CustomSnackBar.show(
                            message: updated ? "Updated" : "Failed to update",
                          );

                          loggedInUserController.update();
                        },
                      );
                    },
                  ),
                  Container(
                    height: 1.h,
                    width: .7.sw,
                    color: AppColors.grey,
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  'Profile',
                  style: AppFonts.poppinsFont.copyWith(
                    color: AppColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.to(
                    // AppPages.editProfileScreen,
                    // AppPages.profileScreen,
                    () => ProfileScreen(
                      model: loggedInUserController.userModel,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.wallet),
                title: Text(
                  'My Wallet',
                  style: AppFonts.poppinsFont.copyWith(
                    color: AppColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.to(
                    () => const WalletScreen(),
                    duration: const Duration(milliseconds: 500),
                    transition: Transition.rightToLeftWithFade,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat),
                title: Text(
                  'Messages',
                  style: AppFonts.poppinsFont.copyWith(
                    color: AppColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.to(
                    () => const RecentMessages(),
                    duration: const Duration(milliseconds: 500),
                    transition: Transition.rightToLeftWithFade,
                  );
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.shopping_bag),
              //   title: Text(
              //     'Orders',
              //     style: AppFonts.poppinsFont.copyWith(
              //       color: AppColors.black,
              //       fontSize: 18.sp,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              //   onTap: () {
              //     Get.back();
              //     Get.to(
              //       () => const OrderHistoryScreen(),
              //       duration: const Duration(milliseconds: 500),
              //       transition: Transition.rightToLeftWithFade,
              //     );
              //   },
              // ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: 36.w,
                  bottom: 36.h,
                ),
                child: InkWell(
                  onTap: () async {
                    NativeLoader.showLoader(message: "Logging out...");
                    bool result = await FirebaseAuthentication.signOutUser() ||
                        await FirebaseAuthentication.googleSignOutUser();
                    if (result) {
                      Get.back();
                      HomeScreenController homeScreenController =
                          Get.find<HomeScreenController>();
                      homeScreenController.homeScreenDrawerKey.currentState!
                          .closeDrawer();
                      Get.offAllNamed(
                        AppPages.loginScreen,
                      );
                    } else {
                      Get.back();
                      Get.back();
                    }
                  },
                  child: Text(
                    "Log Out",
                    style: AppFonts.poppinsFont.copyWith(
                      color: AppColors.appTheme,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
