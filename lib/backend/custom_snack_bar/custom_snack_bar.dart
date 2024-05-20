import '../../Exporter/exporter.dart';

class CustomSnackBar {
  static show({
    required String message,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
      ),
    );
    return ScaffoldMessenger.of(
      Get.context!,
    ).showSnackBar(
      snackBar,
    );
  }
}
