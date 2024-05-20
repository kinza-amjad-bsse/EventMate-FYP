import 'package:event_mate/Exporter/export_page.dart';
import '../../../Exporter/exporter.dart';

// ignore: must_be_immutable
class DoNotHaveAccountWidget extends StatelessWidget {
  DoNotHaveAccountWidget({
    super.key,
    this.color1 = AppColors.primary,
    this.color2 = AppColors.white,
  });
  Color color1;
  Color color2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Don’t have an account?",
            style: AppFonts.poppinsFont.copyWith(
              fontSize: 15.sp,
              color: color1,
              fontWeight: AppFonts.font400,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          InkWell(
            onTap: () {
              Get.to(
                () => const SignUpScreen(),
                duration: 300.milliseconds,
                transition: Transition.circularReveal,
              );
            },
            child: Text(
              "Sign Up",
              style: AppFonts.poppinsFont.copyWith(
                fontSize: 16.sp,
                color: color2,
                fontWeight: AppFonts.font500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
