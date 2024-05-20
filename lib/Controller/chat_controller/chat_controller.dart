import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Model/chat_model/chat_model.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final RxList<ChatModel> messages = <ChatModel>[].obs;
  RxString receiverId = "".obs;

  @override
  void onReady() {
    super.onReady();
    checkExistElseCreateChatRoom();
  }

  void sendMessage(String receiverID) {
    if (messageController.text.trim().isEmpty) {
      return;
    }
    ChatModel chatModel = ChatModel(
      message: messageController.text.trim(),
      receiverId: receiverID,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      type: MessageType.text,
      unread: true,
    );

    try {
      FirebaseFirestore.instance
          .collection('messages')
          .doc(
            getChatRoomId(
              FirebaseAuth.instance.currentUser!.uid,
              receiverID,
            ),
          )
          .update({
        "lastMessage": messageController.text.trim(),
        "lastMessageTime": DateTime.now().millisecondsSinceEpoch.toString(),
        "lastMessageSender": FirebaseAuth.instance.currentUser!.uid,
      });
    } catch (e) {
      FirebaseFirestore.instance
          .collection('messages')
          .doc(
            getChatRoomId(
              FirebaseAuth.instance.currentUser!.uid,
              receiverID,
            ),
          )
          .set({
        "lastMessage": messageController.text.trim(),
        "lastMessageTime": DateTime.now().millisecondsSinceEpoch.toString(),
        "lastMessageSender": FirebaseAuth.instance.currentUser!.uid,
      }, SetOptions(merge: true));
    }

    FirebaseFirestore.instance
        .collection('messages')
        .doc(
          getChatRoomId(
            FirebaseAuth.instance.currentUser!.uid,
            receiverID,
          ),
        )
        .collection('messages')
        .add(
          chatModel.toJson(),
        );
    messageController.clear();
  }

  String getChatRoomId(String uid, String receiversId) {
    if (uid.compareTo(receiversId) > 0) {
      return "$uid-$receiversId";
    } else {
      return "$receiversId-$uid";
    }
  }

  void checkExistElseCreateChatRoom() async {
    // try {
    //   FirebaseFirestore.instance
    //       .collection('messages')
    //       .doc(
    //         getChatRoomId(
    //           FirebaseAuth.instance.currentUser!.uid,
    //           receiverId.value,
    //         ),
    //       )
    //       .update({
    //     "participants": [
    //       FirebaseAuth.instance.currentUser!.uid,
    //       receiverId.value,
    //     ],
    //   });
    // } on FirebaseException catch (e) {
    //   debugPrint(e.message);
    FirebaseFirestore.instance
        .collection('messages')
        .doc(
          getChatRoomId(
            FirebaseAuth.instance.currentUser!.uid,
            receiverId.value,
          ),
        )
        .set(
      {
        "participants": [
          FirebaseAuth.instance.currentUser!.uid,
          receiverId.value,
        ],
      },
      SetOptions(merge: true),
    );
    // }
  }

  void updateMessage(ChatModel message) {
    FirebaseFirestore.instance
        .collection('messages')
        .doc(
          getChatRoomId(
            FirebaseAuth.instance.currentUser!.uid,
            message.senderId,
          ),
        )
        .collection('messages')
        .doc(message.timestamp)
        .update({
      "unread": false,
    });
  }
}
