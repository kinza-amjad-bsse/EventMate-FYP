import '../../../Exporter/exporter.dart';

class CheckBoxAndTextWidget extends StatelessWidget {
  const CheckBoxAndTextWidget({
    super.key,
    required this.onChangeFunction,
    required this.value,
    required this.text,
  });

  final dynamic onChangeFunction;
  final RxBool value;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 4.w,
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 10.w,
          ),
          child: SizedBox(
            height: 20.h,
            width: 20.w,
            child: Obx(
              () => Checkbox(
                value: value.value,
                onChanged: onChangeFunction,
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            onChangeFunction(!value.value);
          },
          child: Text(
            text,
            style: AppFonts.poppinsFont.copyWith(
              color: Colors.black,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
