import '../../../Exporter/exporter.dart';
import '../../widgets/already_have_accounts/already_have_accounts.dart';
import 'get_started.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: AppColors.primary,
      child: Padding(
        padding: EdgeInsets.only(top: 35.h, bottom: 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                Assets.imagesOnboardingTopImage,
                width: .85.sw,
              ),
            ),
            const GetStartedOnBoarding(),
            AlreadyHaveAccountWidget(
              color1: const Color(0xFFC2C2C2),
            ),
          ],
        ),
      ),
    );
  }
}
