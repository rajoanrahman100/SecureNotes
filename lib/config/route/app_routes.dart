import 'package:get/get.dart';
import 'package:securenotes/config/route/app_pages.dart';
import 'package:securenotes/feature/create_note/screen/home_screen.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.homePage, page: () => const HomeScreen()),
  ];
}
