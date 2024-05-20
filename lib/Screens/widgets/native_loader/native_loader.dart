import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../../../Exporter/exporter.dart';

class BeautifulLoader extends StatelessWidget {
  final String message;

  const BeautifulLoader({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                message,
                maxLines: 5,
                textAlign: TextAlign.left,
                style: AppFonts.poppinsFont.copyWith(
                  color: AppColors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // iOS implementation
      return CupertinoAlertDialog(
        content: Row(
          children: [
            const CupertinoActivityIndicator(),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                message,
                maxLines: 5,
                textAlign: TextAlign.left,
                style: AppFonts.poppinsFont.copyWith(
                  color: AppColors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class NativeLoader {
  static void showLoader({required String message}) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return BeautifulLoader(
          message: message,
        );
      },
    );
  }
}
