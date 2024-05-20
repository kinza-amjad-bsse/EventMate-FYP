import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Model/user_model/user_model.dart';
import 'package:event_mate/Model/wallet_model/wallet_model.dart';

class LoggedInUserController extends GetxController {
  UserModel userModel = defaultUser;
  WalletModel walletModel = defaultWallet;

  RxBool isLoggedIn = false.obs;

  assignUserModel({required UserModel userModel}) {
    this.userModel = userModel;
  }

  set role(String role) {
    userModel.role = role;
    update();
  }
}

UserModel defaultUser = UserModel(
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

WalletModel defaultWallet = WalletModel(
  depositAmount: "0.0",
  earnedAmount: "0.0",
  withdrawnAmount: "0.0",
  transactions: [],
);

LoggedInUserController loggedInUserController = Get.put(
  LoggedInUserController(),
  permanent: true,
);
