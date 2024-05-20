import 'package:event_mate/Controller/logged_in_user_controller/logged_in_user_controller.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/backend/firebase_functions/firestore_functions.dart';
import '../../Model/home_screen_categories/home_categories.dart';
import '../../backend/firebase_functions/firebase_authentication.dart';

class HomeScreenController extends GetxController {
  GlobalKey<ScaffoldState> homeScreenDrawerKey = GlobalKey<ScaffoldState>();

  List<HomeCategories> categories = [
    HomeCategories(
      image: Assets.imagesEventManager,
      route: AppPages.categoriesDetailsScreen,
      title: "Event Managers",
      isSvg: false,
      description: "Let Our Expertise Shape Your Perfect Event.",
      color: const Color(0xFFC272D2),
      // bottomRightColor: const Color(0xFFd390cb),
    ),
    HomeCategories(
      image: Assets.imagesWedding,
      route: AppPages.categoriesDetailsScreen,
      title: "Venues",
      isSvg: false,
      description: "Where Dreams Take Shape in Every Hue of Purple",
      color: const Color(0xFFFBBC85),
    ),
    HomeCategories(
      image: Assets.imagesCatering,
      route: AppPages.categoriesDetailsScreen,
      title: "Catering",
      isSvg: false,
      description: "Savor Every Moment with Exquisite Catering.",
      color: const Color(0xFF8CD48C),
    ),
    HomeCategories(
      image: Assets.imagesDecor,
      route: AppPages.categoriesDetailsScreen,
      title: "Decor",
      isSvg: false,
      description: "Transforming Spaces into Enchanted Dreams",
      color: const Color(0xFF8CD48C),
    ),
    HomeCategories(
      image: Assets.imagesPhotography,
      route: AppPages.categoriesDetailsScreen,
      title: "Photography",
      isSvg: false,
      description: "Capturing Love in Every Shade of Purple",
      color: const Color(0xFFCBCB0B),
    ),
  ];

  @override
  void onReady() async {
    super.onReady();
    await FirestoreFunctions.getUserData();
    loggedInUserController.walletModel = await FirestoreFunctions.getUserWallet(
      FirebaseAuthentication.firebaseAuth.currentUser!.uid,
    );
  }
}
