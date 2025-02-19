import 'package:cat_ai_gen/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository extends ChangeNotifier {
  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  bool get isAuthenticated {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<Result<String>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      logging.i("Welcome ${user!.email} back!");
      return Result.ok("Welcome back!");
    } on FirebaseAuthException catch (e) {
      logging.e("Error: $e");
      return Result.error("${e.message} Please try again!");
    } finally {
      notifyListeners();
    }
  }

  Future<Result<UserCredential?>> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Create a new provider
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

        // Once signed in, return the UserCredential
        return Result.ok(
          await FirebaseAuth.instance.signInWithPopup(googleProvider),
        );
      }
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return Result.ok(
        await FirebaseAuth.instance.signInWithCredential(credential),
      );
    } catch (e) {
      logging.e(e.toString());
      return Result.error(null);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<bool>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      logging.i("See you soon!");
      return Result.ok(true);
    } catch (e) {
      logging.e("Oops! $e");
      return Result.error(false);
    } finally {
      notifyListeners();
    }
  }
}
