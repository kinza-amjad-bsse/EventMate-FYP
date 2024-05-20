import 'package:event_mate/Exporter/exporter.dart';

class SignUpTopText extends StatelessWidget {
  const SignUpTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            "Create an Account",
            style: AppFonts.poppinsFont.copyWith(
              color: AppColors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 04.h,
        ),
        Text(
          "Explore the world's largest event marketplace",
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
