import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mate/Controller/logged_in_user_controller/logged_in_user_controller.dart';
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Model/wallet_model/transactions_model/transactions_model.dart';
import 'package:event_mate/Model/wallet_model/wallet_model.dart';
import 'package:event_mate/Screens/widgets/native_loader/native_loader.dart';
import 'package:event_mate/backend/custom_snack_bar/custom_snack_bar.dart';
import 'package:event_mate/backend/firebase_functions/firestore_functions.dart';
import 'package:event_mate/backend/purchase_api/payment_controller/payment_controller.dart';
import 'package:event_mate/backend/purchase_api/purchase_api.dart';
import 'package:event_mate/backend/purchase_api/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:uuid/uuid.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: .15.sh,
            width: 1.sw,
            color: AppColors.appTheme,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: 10.w,
                  left: 10.w,
                  top: 60.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
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
                    FittedBox(
                      child: Text(
                        "My Wallet",
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
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 10.w,
                  left: 10.w,
                  top: 30.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("wallet")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          WalletModel model = WalletModel.fromJson(
                            snapshot.data!.data() as Map<String, dynamic>,
                          );
                          loggedInUserController.walletModel = model;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 1.sw,
                                height: .28.sh,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 15.w,
                                        right: 15.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Total Balance",
                                                style: AppFonts.poppinsFont
                                                    .copyWith(
                                                  color: AppColors.white,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(
                                                width: .4.sw,
                                                child: FittedBox(
                                                  child: Text(
                                                    "${AppVariables.userCurrency.value} ${double.parse(
                                                          model.earnedAmount,
                                                        ) + double.parse(
                                                          model.depositAmount,
                                                        )}",
                                                    style: AppFonts.poppinsFont
                                                        .copyWith(
                                                      color: AppColors.white,
                                                      fontSize: 30.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // bottom sheet with 50, 100, 500, 1000 options
                                              Get.bottomSheet(
                                                bottomSheet(),
                                              );
                                            },
                                            child: Container(
                                              width: .4.sw,
                                              height: 60.h,
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 15.w,
                                                  right: 15.w,
                                                ),
                                                child: FittedBox(
                                                  child: Text(
                                                    "Deposit Now",
                                                    style: AppFonts.poppinsFont
                                                        .copyWith(
                                                      color: AppColors.black,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        widgetWallet(
                                          "Earned",
                                          model.earnedAmount,
                                          isEarn: true,
                                          fun: () async {
                                            try {
                                              NativeLoader.showLoader(
                                                message:
                                                    "Withdrawal in Process!",
                                              );
                                              String withdrawingAmount =
                                                  loggedInUserController
                                                      .walletModel.earnedAmount;
                                              double notWithDrawableAmount =
                                                  0.0;
                                              for (int i = 0;
                                                  i <
                                                      loggedInUserController
                                                          .walletModel
                                                          .transactions
                                                          .length;
                                                  i++) {
                                                if (loggedInUserController
                                                        .walletModel
                                                        .transactions[i]
                                                        .status !=
                                                    TransactionStatus
                                                        .success.name) {
                                                  notWithDrawableAmount +=
                                                      double.parse(
                                                    loggedInUserController
                                                        .walletModel
                                                        .transactions[i]
                                                        .amount,
                                                  );
                                                }
                                              }

                                              if ((double.parse(
                                                            loggedInUserController
                                                                .walletModel
                                                                .earnedAmount,
                                                          ) -
                                                          notWithDrawableAmount >
                                                      0) ||

                                                  /// TODO: REMOVE THIS TRUE
                                                  true) {
                                                loggedInUserController
                                                    .walletModel
                                                    .withdrawnAmount = (double
                                                            .parse(
                                                          loggedInUserController
                                                              .walletModel
                                                              .withdrawnAmount,
                                                        ) +
                                                        (double.parse(
                                                          loggedInUserController
                                                              .walletModel
                                                              .earnedAmount,
                                                        )

                                                        /// TODO: UNCOMMENT
                                                        // - notWithDrawableAmount
                                                        ))
                                                    .toStringAsFixed(2)
                                                    .toString();
                                                loggedInUserController
                                                    .walletModel
                                                    .earnedAmount = "0.0";

                                                /// TODO: UNCOMMENT
                                                // notWithDrawableAmount
                                                //     .toString();
                                                loggedInUserController
                                                    .walletModel.transactions
                                                    .add(
                                                  TransactionModel(
                                                    amount: withdrawingAmount,
                                                    date: DateTime.now()
                                                        .toIso8601String(),
                                                    status: TransactionStatus
                                                        .inProcess.name,
                                                    type: TransactionType
                                                        .withdraw.name,
                                                    description: "Withdraw",
                                                    id: const Uuid().v4(),
                                                  ),
                                                );
                                                await FirestoreFunctions
                                                    .updateUserWallet(
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  loggedInUserController
                                                      .walletModel,
                                                );
                                                Get.back();
                                                CustomSnackBar.show(
                                                  message:
                                                      "Request Generated. Your Withdrawal is in Process!",
                                                );
                                              }

                                              /// TODO: UNCOMMENT
                                              // else {
                                              //   Get.back();
                                              //   CustomSnackBar.show(
                                              //     message:
                                              //         "You don't have enough balance to withdraw! Maybe you've some in progress payments.",
                                              //   );
                                              // }
                                            } catch (error) {
                                              Get.back();
                                              CustomSnackBar.show(
                                                message: error.toString(),
                                              );
                                            }
                                          },
                                        ),
                                        Container(
                                          width: 1.w,
                                          height: .07.sh,
                                          color: AppColors.white,
                                        ),
                                        widgetWallet(
                                          "Withdrawn",
                                          model.withdrawnAmount,
                                        ),
                                        Container(
                                          width: 1.w,
                                          height: .07.sh,
                                          color: AppColors.white,
                                        ),
                                        widgetWallet(
                                          "Deposit",
                                          model.depositAmount,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Transactions",
                                style: AppFonts.poppinsFont.copyWith(
                                  color: AppColors.appTheme,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              model.transactions.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No Transactions",
                                        style: AppFonts.poppinsFont.copyWith(
                                          color: AppColors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: .44.sh,
                                      width: 1.sw,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: model.transactions.length,
                                        itemBuilder: (context, index) {
                                          TransactionModel transactionModel =
                                              model.transactions[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 15.h,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                CustomSnackBar.show(
                                                  message:
                                                      "Transaction Id: ${transactionModel.id}",
                                                );
                                              },
                                              child: Container(
                                                width: 1.sw,
                                                height: 80.h,
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 15.w,
                                                    right: 15.w,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            transactionModel
                                                                        .type ==
                                                                    TransactionType
                                                                        .deposit
                                                                        .name
                                                                ? "Deposit"
                                                                : transactionModel
                                                                            .type ==
                                                                        TransactionType
                                                                            .earned
                                                                            .name
                                                                    ? "Earned"
                                                                    : "Withdrawn",
                                                            style: AppFonts
                                                                .poppinsFont
                                                                .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          FittedBox(
                                                            child: Text(
                                                              "${AppVariables.userCurrency.value} ${transactionModel.amount}",
                                                              style: AppFonts
                                                                  .poppinsFont
                                                                  .copyWith(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize: 20.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            transactionModel
                                                                        .status ==
                                                                    TransactionStatus
                                                                        .success
                                                                        .name
                                                                ? "Success"
                                                                : transactionModel
                                                                            .status ==
                                                                        TransactionStatus
                                                                            .failed
                                                                            .name
                                                                    ? "Failed"
                                                                    : "In Process",
                                                            style: AppFonts
                                                                .poppinsFont
                                                                .copyWith(
                                                              color: transactionModel
                                                                          .status ==
                                                                      TransactionStatus
                                                                          .success
                                                                          .name
                                                                  ? Colors.green
                                                                  : transactionModel
                                                                              .status ==
                                                                          TransactionStatus
                                                                              .failed
                                                                              .name
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .orange,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          Text(
                                                            transactionModel
                                                                .date
                                                                .split(".")[0],
                                                            style: AppFonts
                                                                .poppinsFont
                                                                .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          );
                        } else {
                          return Obx(
                            () => Text(
                              "${AppVariables.userCurrency.value} 0",
                              style: AppFonts.poppinsFont.copyWith(
                                color: AppColors.white,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  widgetWallet(
    String title,
    String amount, {
    bool isEarn = false,
    VoidCallback? fun,
  }) =>
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppFonts.poppinsFont.copyWith(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
              child: Obx(
                () => FittedBox(
                  child: Text(
                    "${AppVariables.userCurrency.value} $amount",
                    style: AppFonts.poppinsFont.copyWith(
                      color: AppColors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            // small withdraw button
            isEarn && amount != "0.0"
                ? InkWell(
                    onTap: fun,
                    child: Container(
                      width: .2.sw,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          "Withdraw",
                          style: AppFonts.poppinsFont.copyWith(
                            color: AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      );

  bottomSheet() => Container(
        width: 1.sw,
        height: .3.sh,
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
            top: 20.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Amount",
                style: AppFonts.poppinsFont.copyWith(
                  color: AppColors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  eachAmountWidget("5"),
                  eachAmountWidget("50"),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  eachAmountWidget("100"),
                  eachAmountWidget("200"),
                ],
              ),
            ],
          ),
        ),
      );

  eachAmountWidget(String amount) => InkWell(
        onTap: () async {
          Get.back();
          NativeLoader.showLoader(
            message: "Payment in Process!",
          );
          Package? package = paymentController.allPackages.firstWhereOrNull(
            (element) => element.identifier == "event$amount",
          );
          if (package == null) {
            Utils.toastMessage(msg: "Package not found!");
            return;
          }

          bool purchased = await PurchaseApi.purchaseInAppProductsPackage(
            package,
          );

          if (!purchased) {
            Get.back();
            return;
          }

          loggedInUserController.walletModel.depositAmount = (double.parse(
                    loggedInUserController.walletModel.depositAmount,
                  ) +
                  double.parse(amount))
              .toStringAsFixed(2)
              .toString();
          loggedInUserController.walletModel.transactions.add(
            TransactionModel(
              amount: amount,
              date: DateTime.now().toIso8601String(),
              status: TransactionStatus.success.name,
              type: TransactionType.deposit.name,
              description: "Deposit",
              id: const Uuid().v4(),
            ),
          );
          FirestoreFunctions.updateUserWallet(
            FirebaseAuth.instance.currentUser!.uid,
            loggedInUserController.walletModel,
          );
          Get.back();
        },
        child: Container(
          width: .4.sw,
          height: 60.h,
          decoration: BoxDecoration(
            color: AppColors.appTheme,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
            ),
            child: FittedBox(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "${kDebugMode ? AppVariables.userCurrency.value : ""} $amount",
                      style: AppFonts.poppinsFont.copyWith(
                        color: AppColors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: " + Tax",
                      style: AppFonts.poppinsFont.copyWith(
                        color: AppColors.white,
                        fontSize: 5.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
