import 'dart:io';

import 'package:event_mate/Exporter/exporter.dart';

class ImageSelectionWidget extends StatelessWidget {
  const ImageSelectionWidget({
    super.key,
    required this.width,
    required this.onTapFunction,
    required this.imageLink,
    required this.isFile,
    required this.filePath,
    required this.notProfile,
    required this.onDeleteTap,
  });

  final bool isFile;
  final bool notProfile;
  final double width;
  final String imageLink;
  final String filePath;
  final VoidCallback onTapFunction;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      child: imageLink == "" && filePath == ""
          ? Container(
              width: width,
              height: 0.2.sh,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.appTheme,
                  width: 4.w,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: .5 * width,
                    height: .08.sh,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.appTheme,
                        width: 4.w,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: AppColors.appTheme,
                        size: 30.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Select Image",
                    style: AppFonts.poppinsFont.copyWith(
                      color: AppColors.appTheme,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          : notProfile
              ? Center(
                  child: SizedBox(
                    width: width,
                    height: 0.2.sh,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        if (!isFile)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.network(
                              imageLink,
                              fit: BoxFit.cover,
                              // scale: 1,
                            ),
                          )
                        else
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.file(
                              File(filePath),
                              fit: BoxFit.cover,
                              // scale: 1,
                            ),
                          ),
                        Positioned(
                          top: 6,
                          right: -12,
                          child: RawMaterialButton(
                            onPressed: onDeleteTap,
                            elevation: 2.0,
                            fillColor: const Color(0xFFF5F6F9),
                            padding: const EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: SizedBox(
                    width: 150.w,
                    height: 150.h,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        !isFile
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                  imageLink,
                                  scale: 1,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  File(filePath),
                                  scale: 1,
                                ),
                              ),
                        Positioned(
                          bottom: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: onTapFunction,
                            elevation: 2.0,
                            fillColor: const Color(0xFFF5F6F9),
                            padding: const EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
