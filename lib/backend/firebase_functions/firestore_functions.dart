import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Model/orders_model/orders_model.dart';
import 'package:event_mate/Model/wallet_model/wallet_model.dart';
import 'package:event_mate/Screens/widgets/native_loader/native_loader.dart';
import 'package:event_mate/backend/custom_snack_bar/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../../Controller/logged_in_user_controller/logged_in_user_controller.dart';
import '../../Model/user_model/user_model.dart';
import '../../Model/wallet_model/transactions_model/transactions_model.dart';
import '../../Utils/print_types.dart';
import 'firebase_authentication.dart';

class FirestoreFunctions {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Future<bool> updateUserWallet(String uid, WalletModel model) async =>
      await firebaseFirestore
          .collection("wallet")
          .doc(uid)
          .update(
            model.toJson(),
          )
          .then(
            (value) => true,
          )
          .catchError((e) {
        myPrint(
          message: "${e.message}",
          type: PrintTypes.error,
        );
        return false;
      });

  static Future<bool> addUserToFirestore({
    required UserModel userModel,
  }) async {
    try {
      await firebaseFirestore.collection("users").doc(userModel.uid).set(
            userModel.toJson(),
            SetOptions(
              merge: true,
            ),
          );

      return true;
    } on FirebaseException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      return false;
    }
  }

  static Future<WalletModel> getUserWallet(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firebaseFirestore.collection("wallet").doc(uid).get();

      if (!documentSnapshot.exists) {
        return WalletModel(
          depositAmount: "0.0",
          earnedAmount: "0.0",
          withdrawnAmount: "0.0",
          transactions: [],
        );
      }
      WalletModel myModel = WalletModel.fromJson(
        documentSnapshot.data() as Map<String, dynamic>,
      );
      return myModel;
    } on FirebaseException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      return WalletModel(
        depositAmount: "0.0",
        earnedAmount: "0.0",
        withdrawnAmount: "0.0",
        transactions: [],
      );
    }
  }

  static Future<UserModel> getUserData() async {
    try {
      DocumentSnapshot documentSnapshot = await firebaseFirestore
          .collection("users")
          .doc(FirebaseAuthentication.firebaseAuth.currentUser!.uid)
          .get();

      if (!documentSnapshot.exists) {
        return UserModel(
          email: "",
          uid: "",
          phoneNumber: "",
          role: "",
          profileImage: UserModel.defaultProfileImage,
          name: "",
          address: "",
          categories: [],
          countryCode: "",
          education: "",
          experience: "",
          featuredImages: [],
          idCardNo: "",
          skills: "",
          isComplete: false,
          about: "",
          featureImage: "",
        );
      }
      UserModel myModel = UserModel.fromMap(
        documentSnapshot.data() as Map<String, dynamic>,
      );
      loggedInUserController.userModel = myModel;
      loggedInUserController.update();
      AppVariables.selectedCountryCode.value =
          myModel.countryCode == "" ? "+92" : myModel.countryCode;
      return myModel;
    } on FirebaseException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      return UserModel(
        email: "",
        uid: "",
        phoneNumber: "",
        profileImage: UserModel.defaultProfileImage,
        role: "",
        name: "",
        address: "",
        categories: [],
        countryCode: "",
        featureImage: "",
        education: "",
        experience: "",
        featuredImages: [],
        idCardNo: "",
        skills: "",
        isComplete: false,
        about: "",
      );
    }
  }

  static Future<List<UserModel>> getEventUsers(String userType) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("users")
          .where("categories", arrayContains: userType)
          .where("is_complete", isEqualTo: true)
          .where("role", isEqualTo: "event_manager")
          .get();

      List<UserModel> list = querySnapshot.docs.map(
        (e) {
          return UserModel.fromMap(
            e.data() as Map<String, dynamic>,
          );
        },
      ).toList();

      return list;
    } on FirebaseException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      return [];
    }
  }

  static Future<bool> updateUser(UserModel model) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(
            model.uid,
          )
          .set(
            model.toJson(),
            SetOptions(merge: true),
          );

      getUserData();

      return true;
    } on FirebaseException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      getUserData();
      return false;
    }
  }

  static Future<void> hireUser({
    required UserModel model,
    required double amount,
    required DateTime deadline,
  }) async {
    try {
      NativeLoader.showLoader(message: "Placing your order!");
      var transactionId = const Uuid().v4();

      loggedInUserController.walletModel.transactions.add(
        TransactionModel(
          id: transactionId,
          amount: amount.toString(),
          date: DateTime.now().toString(),
          description: "Hired ${model.name}",
          status: TransactionStatus.success.name,
          type: TransactionType.withdraw.name,
        ),
      );

      var userWallet = await getUserWallet(model.uid);

      userWallet.earnedAmount =
          (double.parse(userWallet.earnedAmount) + amount).toString();

      userWallet.transactions.add(
        TransactionModel(
          id: transactionId,
          amount: amount.toString(),
          date: DateTime.now().toString(),
          description: "Hired by ${loggedInUserController.userModel.name}",
          status: TransactionStatus.inProcess.name,
          type: TransactionType.earned.name,
        ),
      );

      OrdersModel ordersModel = OrdersModel(
        amount: amount.toString(),
        date: DateTime.now().toString(),
        deadline: deadline.toString(),
        id: transactionId,
        image: model.profileImage,
        title: "Hired by ${loggedInUserController.userModel.name}",
        placedBy: loggedInUserController.userModel.uid,
        placedTo: model.uid,
        status: OrderStatus.processing.name,
      );

      loggedInUserController.walletModel.withdrawnAmount =
          (double.parse(loggedInUserController.walletModel.withdrawnAmount) +
                  amount)
              .toString();

      loggedInUserController.walletModel.depositAmount =
          (double.parse(loggedInUserController.walletModel.depositAmount) -
                  amount)
              .toString();

      bool orderAdded = await addOrder(ordersModel);

      if (!orderAdded) {
        Get.back();
        CustomSnackBar.show(message: "Something went wrong!");

        return;
      }

      await updateUserWallet(
        model.uid,
        userWallet,
      );
      await updateUserWallet(
        FirebaseAuth.instance.currentUser!.uid,
        loggedInUserController.walletModel,
      );

      loggedInUserController.walletModel = await getUserWallet(
        FirebaseAuth.instance.currentUser!.uid,
      );
      Get.back();
      CustomSnackBar.show(message: "Order placed successfully!");
    } on FirebaseException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      Get.back();
    }
  }

  static Future<bool> addOrder(OrdersModel model) async {
    try {
      await firebaseFirestore.collection("orders").doc(model.id).set(
            model.toJson(),
            SetOptions(merge: true),
          );
      return true;
    } on FirebaseException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      return false;
    }
  }
}
