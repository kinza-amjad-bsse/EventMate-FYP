import 'package:firebase_auth/firebase_auth.dart';
import 'Exporter/exporter.dart';
import 'Routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(AppVariables.suWidth, AppVariables.suHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Event Mate',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(
              fontSizeFactor: 1.sp,
            ),
          ),
          initialRoute: getInitRoute(),
          getPages: AppRoutes.generateRoute(),
        );
      },
    );
  }

  getInitRoute() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AppPages.homeScreen;
    }
    return AppPages.loginScreen;
  }
}
