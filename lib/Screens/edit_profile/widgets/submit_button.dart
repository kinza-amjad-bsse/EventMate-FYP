import 'package:event_mate/Exporter/exporter.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onTapFunction,
  });
  final VoidCallback onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTapFunction,
        child: Container(
          width: 219.w,
          height: 51.h,
          decoration: BoxDecoration(
            color: AppColors.appTheme,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(
              "Submit",
              style: AppFonts.poppinsFont.copyWith(
                color: AppColors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
