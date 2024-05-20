import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'backend/purchase_api/purchase_api.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    PurchaseApi.init();
  } catch (e) {
    debugPrint("Error in Purchase API: $e");
  }
  runApp(
    const MyApp(),
  );
}
