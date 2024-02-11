import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:securenotes/config/route/app_pages.dart';
import 'package:securenotes/config/route/app_routes.dart';
import 'package:securenotes/config/theme/app_theme.dart';
import 'package:securenotes/core/helper/store_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: StoreBinding(),
      theme: theme(),
      getPages: AppPages.pages,
      initialRoute: FirebaseAuth.instance.currentUser != null ? Routes.homePage : Routes.singIn,
    );
  }
}
