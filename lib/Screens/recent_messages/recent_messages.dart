import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Model/user_model/user_model.dart';
import 'package:event_mate/Screens/chat_screen/chat_screen_new.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecentMessages extends StatelessWidget {
  const RecentMessages({super.key});

  Future<DocumentSnapshot<Object?>> getSpecificUsersImageAndName(
      String uid) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return documentSnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: .21.sh,
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
                  height: 5.h,
                ),
                Center(
                  child: Text(
                    "MESSAGES",
                    style: AppFonts.poppinsFont.copyWith(
                      color: AppColors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Expanded(
                  child: SizedBox(
                    width: 1.sw,
                    child: StreamBuilder(
                      // Recent Chats with user profile image, and name
                      stream: FirebaseFirestore.instance
                          .collection('messages')
                          .where(
                            'participants',
                            arrayContains:
                                FirebaseAuth.instance.currentUser!.uid,
                          )
                          // .orderBy('lastMessageTime', descending: true)
                          .snapshots(),
                      builder: (
                        context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text(
                                "No Chats Yet",
                                style: AppFonts.poppinsFont.copyWith(
                                  color: AppColors.black,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          } else {
                            snapshot.data!.docs.sort(
                              (a, b) => b['lastMessageTime'].compareTo(
                                a['lastMessageTime'],
                              ),
                            );
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                    future: getSpecificUsersImageAndName(
                                      snapshot.data!.docs[index]['participants']
                                                  [0] ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? snapshot.data!.docs[index]
                                              ['participants'][1]
                                          : snapshot.data!.docs[index]
                                              ['participants'][0],
                                    ),
                                    builder: (context, snp) {
                                      if (snp.connectionState ==
                                          ConnectionState.waiting) {
                                        return const SizedBox();
                                      }
                                      // String name = snp.data!.get('name');
                                      // String profile = snp.data!
                                      //     .get('profile_image')
                                      //     .toString();
                                      UserModel model = UserModel.fromMap(
                                        snp.data!.data()
                                            as Map<String, dynamic>,
                                      );
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(
                                                () => ChatScreenNew(
                                                  model: model,
                                                  receiversId: snapshot.data!
                                                                      .docs[index]
                                                                  ['participants']
                                                              [0] ==
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid
                                                      ? snapshot
                                                              .data!.docs[index]
                                                          ['participants'][1]
                                                      : snapshot
                                                              .data!.docs[index]
                                                          ['participants'][0],
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 20.h,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 25.r,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      model.profileImage,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        model.name == ""
                                                            ? model.email
                                                            : model.name,
                                                        style: AppFonts
                                                            .poppinsFont
                                                            .copyWith(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: .7.sw,
                                                        child: Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ['lastMessage'],
                                                          style: AppFonts
                                                              .poppinsFont
                                                              .copyWith(
                                                            color:
                                                                AppColors.black,
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 1.sw,
                                            height: 1.h,
                                            color: AppColors.grey,
                                          )
                                        ],
                                      );
                                    });
                              },
                            );
                          }
                        } else {
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
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
