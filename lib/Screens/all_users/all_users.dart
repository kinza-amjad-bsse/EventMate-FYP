// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:event_mate/Exporter/exporter.dart';
// import '../chat_screen/chat_screen.dart';
//
// class AllUsersScreen extends StatelessWidget {
//   final String currentUserId; // Pass the current user's ID to this screen
//
//   AllUsersScreen({required this.currentUserId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'All Users',
//           style: AppFonts.poppinsFont.copyWith(
//             color: Colors.black,
//             fontSize: 13.sp,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('users').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           if (!snapshot.hasData) {
//             return Center(
//               child: Text(
//                 "No Users Found",
//                 style: AppFonts.poppinsFont.copyWith(
//                   color: Colors.black,
//                   fontSize: 13.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             );
//           }
//
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var userDocument = snapshot.data!.docs[index];
//               // Exclude the current user from the list
//               if (userDocument.id == currentUserId) {
//                 return Container();
//               }
//               return ListTile(
//                 leading: const Icon(Icons.person),
//                 title: Text(
//                   userDocument['name'] ?? 'No Username',
//                   style: AppFonts.poppinsFont.copyWith(
//                     color: Colors.black,
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 subtitle: Text(
//                   userDocument['email'] ?? 'No Email',
//                   style: AppFonts.poppinsFont.copyWith(
//                     color: Colors.black,
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 onTap: () {
//                   String selectedUserId = userDocument.id;
//                   // Navigate to the chat screen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ChatScreen(
//                         currentUserId: currentUserId,
//                         otherUserId: selectedUserId,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
