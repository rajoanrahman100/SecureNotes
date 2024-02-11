import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:securenotes/feature/google_signin/controller/firebase_auth.dart';

class GoogleSignInController extends GetxController {
  FirebaseAuthClass authClass = FirebaseAuthClass();
  Rx<UserCredential?> googleUserCredential = Rx<UserCredential?>(null);
  RxBool isLoading = false.obs;
  RxBool showDialog = true.obs;

  Future<UserCredential?> googleAuthentication() async {
    isLoading(true);
    try {
      UserCredential userCredential = await authClass.authenticateWithGoogle();
      isLoading(false);
      return userCredential;
    } catch (e) {
      isLoading(false);
      return Future.error(e);
    }
  }

  Future signOut() async {
    authClass.signOutUser();
  }
}
