import 'package:event_mate/Controller/logged_in_user_controller/logged_in_user_controller.dart';

import '../Exporter/exporter.dart';
import '../Exporter/export_page.dart';
import '../Screens/categories_details/categories_details.dart';
import '../Screens/edit_profile/edit_profile.dart';
import '../Screens/recent_messages/recent_messages.dart';

class AppRoutes {
  static generateRoute() => <GetPage<dynamic>>[
        getPage(
          pageName: AppPages.splashScreen,
          pageWidget: const SplashScreen(),
        ),
        getPage(
          pageName: AppPages.homeScreen,
          pageWidget: const HomeScreen(),
        ),
        getPage(
          pageName: AppPages.profileScreen,
          pageWidget: ProfileScreen(
            model: loggedInUserController.userModel,
          ),
        ),
        getPage(
          pageName: AppPages.navigationScreen,
          pageWidget: NavigationScreen(),
        ),
        getPage(
          pageName: AppPages.editProfileScreen,
          pageWidget: const EditProfileScreen(),
        ),
        getPage(
          pageName: AppPages.onboardingScreen,
          pageWidget: const OnboardingScreen(),
        ),
        getPage(
          pageName: AppPages.loginScreen,
          pageWidget: const LoginScreen(),
        ),
        getPage(
          pageName: AppPages.signUpScreen,
          pageWidget: const SignUpScreen(),
        ),
        getPage(
          pageName: AppPages.recentMessages,
          pageWidget: const RecentMessages(),
        ),
        getPage(
          pageName: AppPages.categoriesDetailsScreen,
          pageWidget: const CategoriesDetailsScreen(),
        ),
      ];

  static getPage({
    required String pageName,
    required dynamic pageWidget,
  }) =>
      GetPage(
        name: pageName,
        page: () => pageWidget,
      );
}
