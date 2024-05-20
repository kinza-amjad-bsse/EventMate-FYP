import 'package:event_mate/Controller/logged_in_user_controller/logged_in_user_controller.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Model/user_model/user_model.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTapFunctions,
  });
  final int currentIndex;
  final List<VoidCallback> onTapFunctions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .9.sw,
      height: 80.h,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: EachNavigationWidget(
                isSelectedIndex: true,
                text: "JOBS",
                onTapFun: () {
                  debugPrint("1");
                  onTapFunctions[0]();
                },
                svgAsset: currentIndex == 0
                    ? Assets.svgJobsActive
                    : Assets.svgJobsInactive,
                active: currentIndex,
              ),
            ),
            Expanded(
              child: EachNavigationWidget(
                isSelectedIndex: true,
                text: "PROPOSALS",
                onTapFun: () {
                  debugPrint("2");
                  onTapFunctions[1]();
                },
                svgAsset: currentIndex == 1
                    ? Assets.svgProposalActive
                    : Assets.svgProposalInactive,
                active: currentIndex,
              ),
            ),
            Expanded(
              child: EachNavigationWidget(
                isSelectedIndex: false,
                text: "MESSAGES",
                onTapFun: () {
                  debugPrint("3");
                  onTapFunctions[2]();
                },
                svgAsset: currentIndex == 2
                    ? Assets.svgMessageActive
                    : Assets.svgMessagesInactive,
                active: currentIndex,
              ),
            ),
            Expanded(
              child: EachNavigationWidget(
                isSelectedIndex: false,
                text: "NOTIFICATIONS",
                onTapFun: () {
                  debugPrint("4");
                  onTapFunctions[3]();
                },
                svgAsset: currentIndex == 3
                    ? Assets.svgNotificationActive
                    : Assets.svgNotificationInactive,
                active: currentIndex,
              ),
            ),
            Expanded(
              child: EachNavigationWidget(
                isSelectedIndex: false,
                text: "PROFILE",
                onTapFun: () {
                  debugPrint("5");
                  onTapFunctions[4]();
                },
                active: currentIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EachNavigationWidget extends StatelessWidget {
  const EachNavigationWidget({
    super.key,
    required this.isSelectedIndex,
    required this.text,
    required this.onTapFun,
    this.svgAsset = "",
    required this.active,
  });
  final bool isSelectedIndex;
  final String text;
  final VoidCallback onTapFun;
  final String svgAsset;
  final int active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint(">>> Tapped on $text");
        onTapFun();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: ShapeDecoration(
              color: isSelectedIndex
                  ? const Color(0xFFf2f9ed)
                  : const Color(0xFFfafafa),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Center(
              child: svgAsset != ""
                  ? SvgPicture.asset(
                      svgAsset,
                      width: 20.w,
                      height: 20.h,
                    )
                  : Opacity(
                      opacity: active == 4 ? 1 : 0.5,
                      child: CircleAvatar(
                        radius: 12.r,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                          loggedInUserController.userModel.profileImage == ""
                              ? UserModel.defaultProfileImage
                              : loggedInUserController.userModel.profileImage,
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          FittedBox(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                color: const Color(0xFF4A4A4A),
                fontSize: 8.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
