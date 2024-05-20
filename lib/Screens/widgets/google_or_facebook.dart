import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../../Exporter/exporter.dart';

class GoogleOrFaceBook extends StatelessWidget {
  const GoogleOrFaceBook({
    super.key,
    required this.text,
    required this.onTapFun,
  });
  final String text;
  final Callback onTapFun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFun,
      child: Container(
        // width: 161.w,
        width: .37.sw,
        height: 55.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFFD9D9D9),
            ),
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              text == 'Google' ? Assets.imagesGoogle : Assets.imagesFacebook,
              width: 32.w,
              height: 32.h,
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              text,
              style: AppFonts.poppinsFont.copyWith(
                color: Colors.black,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
