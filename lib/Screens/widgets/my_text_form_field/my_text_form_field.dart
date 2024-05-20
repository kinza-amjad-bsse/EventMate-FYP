import 'package:event_mate/Exporter/exporter.dart';

// ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  MyTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hint,
    this.isPhoneNumber = false,
    this.onTapFunction,
    this.enabled = true,
  });
  bool enabled = true;
  TextEditingController controller;
  TextInputType keyboardType;
  String hint;
  bool isPhoneNumber = false;
  dynamic onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFD9D9D9),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        children: [
          if (isPhoneNumber)
            InkWell(
              onTap: () {
                onTapFunction();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 11.w,
                      right: 13.w,
                    ),
                    child: Obx(
                      () => Text(
                        AppVariables.selectedCountryCode.value,
                        style: AppFonts.poppinsFont.copyWith(
                          color: const Color(0xFFA8ADB2),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                    height: 28.h,
                    child: const VerticalDivider(
                      color: Color(0xFFD9D9D9),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            width: 08.w,
          ),
          Expanded(
            child: Theme(
              data: ThemeData(hintColor: Colors.white),
              child: TextFormField(
                enabled: enabled,
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  hintText: hint,
                  hintStyle: AppFonts.poppinsFont.copyWith(
                    // color: AppColors.black,
                    color: const Color(0xFF959AA1),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixStyle: AppFonts.poppinsFont.copyWith(
                    color: AppColors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
