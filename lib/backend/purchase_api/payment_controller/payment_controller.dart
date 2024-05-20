import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../purchase_api.dart';

enum Entitlement { pro, free }

class PaymentController extends GetxController {
  CustomerInfo? _customerInfo;
  bool? _isSubscribed;
  List<Package> _userPackages = <Package>[];
  List<String> _activeSubsIdentifiers = [];
  Map<String, String?> _expirationDates = {};

  get customerInfo => _customerInfo;
  get isSubscribed => _isSubscribed;
  get userPackages => _userPackages;
  get expirationDates => _expirationDates;

  RxBool isProVersion = false.obs;
  List<Package> _allPackages = [];
  List<StoreProduct> _allStoreProducts = [];
  final List<String> _packageTypes = [
    'Monthly',
    'Yearly',
  ];
  PackageType _selectedPackageType = PackageType.monthly;

  //============GETTERS==============
  List<Package> get allPackages => _allPackages;
  List<String> get packageTypes => _packageTypes;
  PackageType get selectedPackageType => _selectedPackageType;

  /// Set Offerings.
  Future<void> setOfferings() async {
    final offerings = await PurchaseApi.fetchOffers();
    if (offerings.isNotEmpty) {
      /// ========SET ALL PACKAGES=============
      _allPackages = offerings
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();
      _allPackages.sort(
        (a, b) => a.storeProduct.price.compareTo(
          b.storeProduct.price,
        ),
      );
      debugPrint(
        "All Packages : $_allPackages",
      );
    }
  }

  /// fetchProducts.
  Future<void> fetchProducts() async {
    final offerings = await PurchaseApi.fetchProducts();
    if (offerings.isNotEmpty) {
      /// ========SET ALL PRODUCTS=============
      _allStoreProducts = offerings;
      debugPrint(
        "All Packages : $_allStoreProducts",
      );
    }
  }

  /// Set Package Type.
  void setPackageType(type) {
    _selectedPackageType = type;
  }

  /// Get Customer Info.
  Future getCustomerInfo() async {
    try {
      _customerInfo = await Purchases.getCustomerInfo();
      _isSubscribed =
          _customerInfo!.entitlements.all["full_access"]?.isActive ?? false;
      if (_isSubscribed ?? false) {
        paymentController.isProVersion.value = true;
        _activeSubsIdentifiers = _customerInfo!.activeSubscriptions;
        _expirationDates = _customerInfo!.allExpirationDates;
        setUserPackages();
      } else {
        paymentController.isProVersion.value = false;
      }

      log('Customer Info: ${_customerInfo.toString()}');
      log('Is subscribed: ${_isSubscribed.toString()}');
    } on PlatformException catch (e) {
      log(e.code);
    }
  }

  /// Set User Packages.
  setUserPackages() {
    _userPackages = allPackages
        .where((package) =>
            _activeSubsIdentifiers.contains(package.storeProduct.identifier))
        .toList();
    log('User Packages: ${_userPackages.toString()}');
  }

  /// Reset Values.
  resetValues() {
    _userPackages = [];
    _isSubscribed = false;
    _activeSubsIdentifiers = [];
    _expirationDates = {};
  }
}

PaymentController paymentController = Get.put(
  PaymentController(),
  permanent: true,
);
