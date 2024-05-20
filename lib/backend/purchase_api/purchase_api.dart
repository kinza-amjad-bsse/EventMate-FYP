import 'dart:developer';

import 'package:event_mate/backend/purchase_api/utils/utils.dart';
import 'package:event_mate/backend/shared_pref_keys/shared_pref_keys.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'payment_controller/payment_controller.dart';

class PurchaseApi {
  static const String _apiKey = "goog_ZyFTMZlNqiKWmXIespjzykWCMyL";

  static Future<String> getUserId(String? appUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appUserId ??= prefs.getString(SharedPrefKeys.userId) ??
        const Uuid().v4().replaceAll("-", "");
    prefs.setString(SharedPrefKeys.userId, appUserId);
    return appUserId;
  }

  static Future init() async {
    await Purchases.setLogLevel(LogLevel.info);
    PurchasesConfiguration configuration = PurchasesConfiguration(_apiKey);
    String userId = await getUserId(configuration.appUserID);

    /// Configure sdk using configure
    await Purchases.configure(
      // configuration,
      configuration..appUserID = userId,
    );

    /// TODO: Now set offerings
    await paymentController.setOfferings();

    // await paymentController.fetchProducts();

    /// TODO: Restore purchases
    await restorePurchases();

    /// TODO:  Get customer info
    await paymentController.getCustomerInfo();
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.all.values.toList();
      return current;
    } on PlatformException catch (e) {
      log("Error Offerings: ${e.message}");
      return [];
    }
  }

  static const List<String> productsIdentifiers = [
    'event5',
    'event50',
    'event100',
    'event200',
  ];

  static Future<List<StoreProduct>> fetchProducts() async {
    try {
      final products = await Purchases.getProducts(
        productsIdentifiers,
        productCategory: ProductCategory.nonSubscription,
      );
      return products;
    } on PlatformException catch (e) {
      log("Error Offerings: ${e.message}");
      return [];
    }
  }

  static Future purchaseSubscriptionPackage(Package package) async {
    try {
      CustomerInfo purchaserInfo = await Purchases.purchasePackage(package);
      Utils.toastMessage(msg: 'Paid Successfully!');
      if (purchaserInfo.entitlements.all["wallet"]!.isActive) {
        Utils.toastMessage(
          msg: purchaserInfo
              .entitlements.all[package.identifier]!.latestPurchaseDate,
        );
        // paymentController.isProVersion.value = true;
        Get.back();
      }
    } catch (e) {
      Utils.toastMessage(msg: "Error in Purchase: $e");
    }
  }

  static Future<bool> purchaseInAppProductsPackage(Package package) async {
    try {
      DateTime transactionInitTime = DateTime.now();
      transactionInitTime =
          transactionInitTime.subtract(const Duration(seconds: 3));
      if (!transactionInitTime.isUtc) {
        transactionInitTime = transactionInitTime.toUtc();
      }

      CustomerInfo purchaserInfo = await Purchases.purchasePackage(package);
      var transaction =
          purchaserInfo.nonSubscriptionTransactions.firstWhereOrNull((element) {
        bool isSameProduct = element.productIdentifier == package.identifier;
        DateTime time = DateTime.parse(element.purchaseDate);
        bool timeCheck = time.isAfter(transactionInitTime);
        return isSameProduct && timeCheck;
      });
      if (transaction != null) {
        Utils.toastMessage(msg: "Paid Successfully!");
        return true;
      } else {
        Utils.toastMessage(msg: "Transaction Not Found!");
        return false;
      }
    } on PlatformException catch (e) {
      Utils.toastMessage(msg: "Error in Purchase: ${e.message}");
      return false;
    } catch (error) {
      Utils.toastMessage(msg: "Error in Purchase: $error");
      return false;
    }
  }

  static Future purchaseProduct(StoreProduct product) async {
    try {
      CustomerInfo customerInfo = await Purchases.purchaseStoreProduct(product);

      Utils.toastMessage(msg: 'Subscribed Successfully!');
      if (customerInfo.entitlements.all[product.identifier]!.isActive) {
        paymentController.isProVersion.value = true;
        Get.back();
      }
    } on PlatformException catch (e) {
      Utils.toastMessage(msg: "Error in Purchase: ${e.message}");
    }
  }

  static Future restorePurchases() async {
    try {
      await Purchases.restorePurchases();
      // await Provider.of<RevenuecatProvider>(Get.context!, listen: false)
      //     .getCustomerInfo();
      Utils.toastMessage(msg: 'Success');
    } on PlatformException catch (e) {
      Utils.toastMessage(msg: e.code);
    } catch (e) {
      Utils.toastMessage();
    }
  }
}
