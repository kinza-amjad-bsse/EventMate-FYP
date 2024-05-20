import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Screens/navigation_screen/widgets/bottom_navigation.dart';
import '../../Controller/navigation_controller/navigation_controller.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});
  final NavigationController controller = Get.put(
    NavigationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Obx(
              () => controller.screens[NavigationController.currentIndex.value],
            ),
          ),
          Positioned(
            bottom: 22.h,
            left: 22.w,
            right: 22.w,
            child: Obx(
              () => BottomNavigationBarWidget(
                currentIndex: NavigationController.currentIndex.value,
                onTapFunctions: controller.onTapFunctions,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
