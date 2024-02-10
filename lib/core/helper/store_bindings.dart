import 'package:get/get.dart';
import 'package:securenotes/feature/create_note/controller/note_controller.dart';

class StoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoteController());
  }
}
