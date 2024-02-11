import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:securenotes/feature/google_signin/controller/base_firestore_auth_service.dart';

class FirebaseAuthClass extends BaseFirebaseAuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> authenticateWithGoogle() async {
    // TODO: implement authenticateWithGoogle
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  bool isLoggedIn() {
    // TODO: implement isLoggedIn
    if (firebaseAuth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void signOutUser()async {
    await firebaseAuth.signOut();
  }
}
