import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseFirebaseAuthService {
  Future<UserCredential> authenticateWithGoogle();

  void signOutUser();

  bool isLoggedIn();
}
