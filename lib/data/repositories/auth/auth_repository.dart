import 'package:cat_ai_gen/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
