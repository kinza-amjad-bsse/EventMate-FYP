import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Utils/print_types.dart';
import '../../../Controller/login_controller/login_controller.dart';
import '../../widgets/checkbox_and_text/checkbox_and_text.dart';
import '../../widgets/dont_have_account/dont_have_account.dart';
import '../../widgets/google_or_facebook.dart';
import '../../widgets/login_signup_button/login_signup_button.dart';
import '../../widgets/my_text_form_field/my_text_form_field.dart';
import '../../widgets/or_with_widget/or_with_widget.dart';
import 'login_top_text.dart';

// ignore: must_be_immutable
class LoginBody extends StatelessWidget {
  LoginBody({super.key});
  LoginController loginController = Get.put(
    LoginController(),
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
          top: 80.h,
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
                const LoginTopText(),
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
                  controller: loginController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Enter your email address',
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
                  controller: loginController.passwordController,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Enter your password',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 14.h,
                    bottom: 40.h,
                  ),
                  child: forgetPasswordRow(),
                ),
                LoginSignupButton(
                  onPressed: loginController.loginFunction,
                  text: 'Login',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 60.h,
                    bottom: 50.h,
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
                      onTapFun: loginController.loginWithGoogle,
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
            DoNotHaveAccountWidget(
              color1: const Color(0xFF9D9393),
              color2: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  forgetPasswordRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CheckBoxAndTextWidget(
            onChangeFunction: (bool? value) {
              loginController.rememberMe.value = value!;
              myPrint(
                message: "Remember Me: ${loginController.rememberMe.value}",
                type: PrintTypes.info,
              );
            },
            value: loginController.rememberMe,
            text: 'Remember Me',
          ),
          Text(
            'Forgot Password',
            style: AppFonts.poppinsFont.copyWith(
              color: const Color(0xFFFF0000),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      );
}
