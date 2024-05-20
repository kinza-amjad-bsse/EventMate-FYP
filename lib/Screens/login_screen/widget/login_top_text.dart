import 'package:event_mate/Exporter/exporter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginTopText extends StatelessWidget {
  const LoginTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                'Hello! Welcome back!',
                style: AppFonts.poppinsFont.copyWith(
                  color: AppColors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            SvgPicture.asset(
              Assets.iconsHandShake,
            ),
          ],
        ),
        SizedBox(
          height: 04.h,
        ),
        Text(
          'Hello again, You’ve been missed!',
          style: AppFonts.poppinsFont.copyWith(
            color: const Color(0xFFA7A2A2),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
