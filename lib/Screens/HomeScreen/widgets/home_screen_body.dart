import 'package:event_mate/Controller/home_screen_controller/home_screen_controller.dart';
import 'package:event_mate/Model/home_screen_categories/home_categories.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Exporter/exporter.dart';
import '../../drawers/home_drawer/home_drawer.dart';

// ignore: must_be_immutable
class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({
    super.key,
  });
  HomeScreenController controller = Get.put(
    HomeScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.homeScreenDrawerKey,
      backgroundColor: AppColors.background,
      drawer: const HomeScreenDrawer(),
      body: Stack(
        // clipBehavior: Clip.none,
        children: [
          Container(
            height: .35.sh,
            width: 1.sw,
            color: AppColors.appTheme,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 36.w,
              left: 36.w,
              top: 60.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.homeScreenDrawerKey.currentState!
                            .openDrawer();
                      },
                      child: SvgPicture.asset(
                        Assets.iconsMenu,
                        height: 46.h,
                      ),
                    ),
                    // SvgPicture.asset(
                    //   Assets.iconsProfile,
                    //   height: 46.h,
                    // ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Text(
                    "EVENTMATE",
                    style: AppFonts.poppinsFont.copyWith(
                      color: AppColors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: .2.sh,
            left: 0,
            child: Container(
              width: 1.sw,
              height: .8.sh,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  top: 15.h,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.categories.length,
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  //   childAspectRatio: 1,
                  //   crossAxisSpacing: 25.w,
                  //   mainAxisSpacing: 25.h,
                  // ),
                  itemBuilder: (context, index) {
                    HomeCategories category = controller.categories[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            category.route,
                            arguments: {
                              "index": index,
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 127.h,
                              decoration: BoxDecoration(
                                // color: const Color(0xFFE6DBDB),
                                color: category.color,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 25.w,
                                  top: 15.h,
                                  bottom: 15.h,
                                  right: 15.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category.title,
                                          style: AppFonts.poppinsFont.copyWith(
                                            color: AppColors.white,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 37.h,
                                          width: .52.sw,
                                          child: Text(
                                            category.description,
                                            style:
                                                AppFonts.poppinsFont.copyWith(
                                              color: AppColors.black,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    category.isSvg
                                        ? SvgPicture.asset(
                                            category.image,
                                            height: 99.h,
                                            width: 99.w,
                                          )
                                        : Image.asset(
                                            category.image,
                                            height: 99.h,
                                            width: 99.w,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -20.h,
                              right: 0,
                              child: Image.asset(
                                Assets.imagesCategoryShadow,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
