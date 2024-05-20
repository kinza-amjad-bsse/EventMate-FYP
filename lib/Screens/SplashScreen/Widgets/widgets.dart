import 'package:event_mate/Controller/splash_controller/splash_controller.dart';
import 'package:event_mate/Exporter/exporter.dart';

// ignore: must_be_immutable
class SplashBody extends StatelessWidget {
  SplashBody({super.key});
  SplashController controller = Get.put(
    SplashController(),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "SplashScreen",
        style: AppFonts.poppinsFont.copyWith(
          color: AppColors.black,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
