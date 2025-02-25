import 'package:cat_ai_gen/data/services/services.dart';
import 'package:cat_ai_gen/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;
  static late AuthStatus _status;

  Future<Result<AuthStatus>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return switch (_status) {
      AuthStatus.unknown => Result.ok(_status),
      AuthStatus.successful => Result.ok(_status),
      _ => Result.error(_status),
    };
  }

  Future<Result<AuthStatus>> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Create a new provider
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

        // Once signed in, return the UserCredential
        await auth.signInWithPopup(googleProvider);
        _status = AuthStatus.successful;
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
      await auth.signInWithCredential(credential);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return switch (_status) {
      AuthStatus.successful => Result.ok(_status),
      _ => Result.error(_status),
    };
  }

  Future<Result<AuthStatus>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential newUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      auth.currentUser!.updateDisplayName(name);

      newUser.user!.sendEmailVerification();

      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return switch (_status) {
      AuthStatus.successful => Result.ok(_status),
      _ => Result.error(_status),
    };
  }

  Future<Result<AuthStatus>> forgotPassword({required String email}) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));

    return switch (_status) {
      AuthStatus.successful => Result.ok(_status),
      _ => Result.error(_status),
    };
  }

  Future<Result<void>> signOut() async {
    await auth.signOut();
    return Result.ok(null);
  }
}
