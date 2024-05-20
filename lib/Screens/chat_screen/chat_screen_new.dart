import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mate/Controller/chat_controller/chat_controller.dart';
import 'package:event_mate/Exporter/export_page.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Screens/widgets/my_text_form_field/my_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Model/chat_model/chat_model.dart';
import '../../Model/user_model/user_model.dart';

class ChatScreenNew extends StatelessWidget {
  ChatScreenNew({
    super.key,
    required this.receiversId,
    required this.model,
  });
  final String receiversId;
  // , image, name;
  final UserModel model;

  final ChatController controller = Get.put(
    ChatController(),
  );

  @override
  Widget build(BuildContext context) {
    controller.receiverId.value = receiversId;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: .15.sh,
            width: 1.sw,
            color: AppColors.appTheme,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 10.w,
              left: 10.w,
              top: 60.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.dispose();
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    InkWell(
                      onTap: () {
                        if (model.role == AppRoles.eventManager) {
                          Get.to(
                            () => ProfileScreen(model: model),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25.r,
                            backgroundImage: NetworkImage(
                              model.profileImage,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          FittedBox(
                            child: Text(
                              model.name == "" ? model.email : model.name,
                              style: AppFonts.poppinsFont.copyWith(
                                color: AppColors.white,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                  child: SizedBox(
                    width: 1.sw,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('messages')
                          .doc(
                            controller.getChatRoomId(
                              FirebaseAuth.instance.currentUser!.uid,
                              receiversId,
                            ),
                          )
                          .collection('messages')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          debugPrint(">>> Error: ${snapshot.error}");
                          return const Text(
                            'Something went wrong',
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          debugPrint(">>> Waiting");
                          return Column(
                            children: [
                              SizedBox(
                                height: 40.h,
                              ),
                              SizedBox(
                                width: 50.w,
                                height: 50.h,
                                child: const CircularProgressIndicator(),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Loading...",
                                style: AppFonts.poppinsFont.copyWith(
                                  color: AppColors.black,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          );
                        }

                        return ListView(
                          reverse: true,
                          children: snapshot.data!.docs.map(
                            (DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              debugPrint(">>> Data: $data");
                              ChatModel message = ChatModel.fromJson(data);
                              if (message.unread &&
                                  message.senderId !=
                                      FirebaseAuth.instance.currentUser!.uid) {
                                controller.updateMessage(message);
                              }
                              return BubbleSpecialOne(
                                text: message.message,
                                isSender: message.senderId ==
                                    FirebaseAuth.instance.currentUser!.uid,
                                color: AppColors.appTheme,
                                textStyle: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                                seen: !message.unread,
                                constraints: BoxConstraints(
                                  minWidth: 90.w,
                                  minHeight: 30.h,
                                ),
                              );
                            },
                          ).toList(),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 05.w,
                    ),
                    Expanded(
                      child: MyTextFormField(
                        controller: controller.messageController,
                        keyboardType: TextInputType.text,
                        hint: "Enter your Message here...",
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {
                        controller.sendMessage(receiversId);
                      },
                      child: Container(
                        height: 55.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: AppColors.appTheme,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.send_rounded,
                          color: AppColors.white,
                          size: 25.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
