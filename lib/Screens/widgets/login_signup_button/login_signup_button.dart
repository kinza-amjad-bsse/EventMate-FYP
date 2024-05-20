import '../../../Exporter/exporter.dart';

class LoginSignupButton extends StatelessWidget {
  const LoginSignupButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final dynamic onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: 1.sw,
        height: 60.h,
        decoration: ShapeDecoration(
          color: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Center(
          child: Text(
            text,
            style: AppFonts.poppinsFont.copyWith(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
