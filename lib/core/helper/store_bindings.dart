import 'package:get/get.dart';
import 'package:securenotes/feature/create_note/controller/note_controller.dart';
import 'package:securenotes/feature/google_signin/controller/google_sign_in_controller.dart';

class StoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoteController());
    Get.lazyPut(() => GoogleSignInController());
  }
}
