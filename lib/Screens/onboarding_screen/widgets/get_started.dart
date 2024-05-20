import 'package:event_mate/Exporter/export_page.dart';
import 'package:event_mate/Exporter/exporter.dart';

class GetStartedOnBoarding extends StatelessWidget {
  const GetStartedOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 210.94,
            child: Text(
              'Let’s Get \nStarted',
              style: AppFonts.poppinsFont.copyWith(
                color: Colors.white,
                fontSize: 45.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 25.h,
              bottom: 25.h,
            ),
            child: Text(
              'Lets make our event more special for our special one’s.',
              style: AppFonts.poppinsFont.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.off(
                () => const SignUpScreen(),
                duration: 300.milliseconds,
                transition: Transition.circularReveal,
              );
            },
            child: Container(
              width: 1.sw,
              height: 53.h,
              decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Center(
                child: Text(
                  'Join Now',
                  style: AppFonts.poppinsFont.copyWith(
                    color: AppColors.primary.withOpacity(0.8),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
