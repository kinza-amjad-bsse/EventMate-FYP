import '../../Exporter/exporter.dart';
import '../../Model/user_model/user_model.dart';
import '../../backend/firebase_functions/firestore_functions.dart';
import '../home_screen_controller/home_screen_controller.dart';

class CategoriesDetailsController extends GetxController {
  RxList<UserModel> users = <UserModel>[].obs;
  int tapIndex = 0;

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  setUsers(List<UserModel> list) {
    users.clear();
    users.value = list;
  }

  RxBool isFetching = false.obs;

  getUsers(String type) async {
    isFetching.value = true;
    List<UserModel> list = await FirestoreFunctions.getEventUsers(type);
    setUsers(list);
    isFetching.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    tapIndex = Get.arguments["index"];
    getUsers(
      homeScreenController.categories[tapIndex].title,
    );
  }
}
