import '../Exporter/exporter.dart';

/// Fonts File

class AppFonts {
  static const font100 = FontWeight.w100,
      font200 = FontWeight.w200,
      font300 = FontWeight.w300,
      font400 = FontWeight.w400,
      font500 = FontWeight.w500,
      font600 = FontWeight.w600,
      font700 = FontWeight.w700,
      font800 = FontWeight.w800,
      font900 = FontWeight.w900;

  static const boldFont = FontWeight.bold;
  static const normalFont = FontWeight.normal;

  static var poppinsFont = GoogleFonts.poppins(
    fontWeight: font500,
    color: AppColors.primary,
    fontSize: 12.sp,
  );

  static var robotoFont = GoogleFonts.roboto(
    fontWeight: font500,
    color: AppColors.primary,
    fontSize: 12.sp,
  );
}
