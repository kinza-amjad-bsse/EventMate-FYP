import '../../../Exporter/exporter.dart';

class OrWithWidget extends StatelessWidget {
  const OrWithWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        eachDivider(),
        Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          child: Text(
            text,
            style: AppFonts.poppinsFont.copyWith(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        eachDivider(),
      ],
    );
  }

  eachDivider() => Container(
        width: .2.sw,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: .7.w,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: const Color(0xFFCCC0C0),
            ),
          ),
        ),
      );
}
