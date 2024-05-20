import 'package:event_mate/Exporter/export_page.dart';
import 'package:event_mate/Exporter/exporter.dart';
import '../../../Controller/categories_details_controller/categories_details_controller.dart';

// ignore: must_be_immutable
class CategoriesDetailsBody extends StatelessWidget {
  CategoriesDetailsBody({super.key});

  CategoriesDetailsController controller = Get.put(
    CategoriesDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
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
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                      size: 30.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              Center(
                child: Text(
                  controller.homeScreenController
                      .categories[controller.tapIndex].title,
                  style: AppFonts.poppinsFont.copyWith(
                    color: AppColors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => controller.isFetching.value
              ? SizedBox(
                  width: 1.sw,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Fetching Data",
                        style: AppFonts.poppinsFont.copyWith(
                          color: AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : controller.users.isEmpty
                  ? SizedBox(
                      width: 1.sw,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            color: AppColors.black,
                            size: 50,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "No User Found!",
                            style: AppFonts.poppinsFont.copyWith(
                              color: AppColors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Positioned(
                      top: .22.sh,
                      left: 0,
                      child: SizedBox(
                        width: 1.sw,
                        height: .77.sh,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 25.w,
                            right: 25.w,
                          ),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.users.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 25.w,
                              mainAxisSpacing: 25.h,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    ProfileScreen(
                                      model: controller.users[index],
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6DBDB),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 50.r,
                                        backgroundImage: NetworkImage(
                                          controller.users[index].profileImage,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        controller.users[index].name,
                                        style: AppFonts.poppinsFont.copyWith(
                                          color: AppColors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "\$ ${controller.users[index].rate}",
                                        style: AppFonts.poppinsFont.copyWith(
                                          color: AppColors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
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
        )
      ],
    );
  }
}
