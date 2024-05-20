import 'package:event_mate/Controller/signup_controller/signup_controller.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Screens/signup_screen/widget/signup_top_text.dart';
import 'package:event_mate/Screens/widgets/already_have_accounts/already_have_accounts.dart';
import '../../widgets/checkbox_and_text/checkbox_and_text.dart';
import '../../widgets/google_or_facebook.dart';
import '../../widgets/login_signup_button/login_signup_button.dart';
import '../../widgets/my_text_form_field/my_text_form_field.dart';
import '../../widgets/or_with_widget/or_with_widget.dart';

class SignUpScreenBody extends StatelessWidget {
  SignUpScreenBody({super.key});
  final SignUpController signUpController = Get.put(
    SignUpController(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 30.h,
          top: 50.h,
          left: 30.w,
          right: 30.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignUpTopText(),
                Padding(
                  padding: EdgeInsets.only(
                    top: 30.h,
                    bottom: 8.h,
                  ),
                  child: Text(
                    'Email Address',
                    style: AppFonts.poppinsFont.copyWith(
                      color: AppColors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                MyTextFormField(
                  controller: signUpController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Enter your email address',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.h,
                    bottom: 8.h,
                  ),
                  child: Text(
                    'Mobile Number',
                    style: AppFonts.poppinsFont.copyWith(
                      color: AppColors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                MyTextFormField(
                  controller: signUpController.phoneNumber,
                  keyboardType: TextInputType.phone,
                  hint: 'Enter your mobile number',
                  isPhoneNumber: true,
                  onTapFunction: () {
                    signUpController.openCountryPicker(
                      context: context,
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.h,
                    bottom: 8.h,
                  ),
                  child: Text(
                    "Role",
                    style: AppFonts.poppinsFont.copyWith(
                      color: AppColors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckBoxAndTextWidget(
                        onChangeFunction: (bool? value) {
                          signUpController.isCustomer.value = value!;
                          signUpController.isEventManager.value =
                              !signUpController.isCustomer.value;
                          debugPrint(
                            "As a Customer: ${signUpController.isCustomer.value}",
                          );
                        },
                        value: signUpController.isCustomer,
                        text: 'As a Customer',
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CheckBoxAndTextWidget(
                        onChangeFunction: (bool? value) {
                          signUpController.isEventManager.value = value!;
                          signUpController.isCustomer.value =
                              !signUpController.isEventManager.value;
                          debugPrint(
                            "As a Event Manager: ${signUpController.isEventManager.value}",
                          );
                        },
                        value: signUpController.isEventManager,
                        text: 'As a Freelancer',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.h,
                    bottom: 8.h,
                  ),
                  child: Text(
                    'Password',
                    style: AppFonts.poppinsFont.copyWith(
                      color: AppColors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                MyTextFormField(
                  controller: signUpController.passwordController,
                  keyboardType: TextInputType.text,
                  hint: 'Enter your password',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 30.h,
                    bottom: 15.h,
                  ),
                  child: CheckBoxAndTextWidget(
                    onChangeFunction: (bool? value) {
                      signUpController.termsCondition.value = value!;
                      debugPrint(
                        "I agree to the terms and conditions: ${signUpController.termsCondition.value}",
                      );
                    },
                    value: signUpController.termsCondition,
                    text: 'I agree to the terms and conditions',
                  ),
                ),
                LoginSignupButton(
                  onPressed: signUpController.signUpFunction,
                  text: 'Sign Up',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.h,
                    bottom: 30.h,
                  ),
                  child: const OrWithWidget(
                    text: 'Or Login With',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GoogleOrFaceBook(
                      text: 'Google',
                      onTapFun: signUpController.signUpWithGoogle,
                    ),
                    // SizedBox(
                    //   width: 19.w,
                    // ),
                    // GoogleOrFaceBook(
                    //   text: 'Facebook',
                    //   onTapFun: () {},
                    // ),
                  ],
                )
              ],
            ),
            AlreadyHaveAccountWidget(
              color1: const Color(0xFF9D9393),
              color2: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
