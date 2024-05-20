import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utils {
  static toastMessage({String msg = 'Something went wrong'}) {
    Fluttertoast.showToast(
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      msg: msg,
    );
  }

  static snackBarMsg({String msg = 'Something went wrong'}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
