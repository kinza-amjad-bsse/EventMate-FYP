import 'package:event_mate/Exporter/exporter.dart';
import '../../Exporter/export_page.dart';

class NavigationController extends GetxController {
  static RxInt currentIndex = 0.obs;

  List<Widget> screens = [
    const HomeScreen(),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.yellow,
    ),
    Container(
      color: Colors.orange,
    ),
    // const ProfileScreen(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }

  List<VoidCallback> onTapFunctions = [
    () {
      debugPrint("1");
      currentIndex.value = 0;
    },
    () {
      debugPrint("2");
      currentIndex.value = 1;
    },
    () {
      debugPrint("3");
      currentIndex.value = 2;
    },
    () {
      debugPrint("4");
      currentIndex.value = 3;
    },
    () {
      debugPrint("5");
      currentIndex.value = 4;
    },
  ];
}
