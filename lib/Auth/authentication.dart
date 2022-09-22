import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth;

  AuthServices(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> emailSignIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> emailSignUp({required String email, required password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Welcome to the app";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> googleSignIn() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final creadential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      _firebaseAuth.signInWithCredential(creadential);
      //TODO: Setup User Data using Firestore
      //if (x.additionalUserInfo!.isNewUser) {

      //}
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> resetPass({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return "Email triggered";
  }

  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return "Signed Out";
  }
}
