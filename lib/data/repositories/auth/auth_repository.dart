import 'package:cat_ai_gen/config/dependencies.dart';
import 'package:cat_ai_gen/data/services/services.dart';
import 'package:cat_ai_gen/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum AuthMethod { signIn, signUp, forgotPassword }

class AuthRepository extends ChangeNotifier {
  final _service = locator.get<AuthService>();

  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  bool get isAuthenticated {
    return FirebaseAuth.instance.currentUser != null;
  }

  AuthMethod _authMethod = AuthMethod.signIn;

  AuthMethod get authMethod => _authMethod;

  Future<Result<AuthStatus>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _service.signIn(email: email, password: password);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<AuthStatus>> signInWithGoogle() async {
    try {
      return await _service.signInWithGoogle();
    } finally {
      notifyListeners();
    }
  }

  Future<Result<AuthStatus>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      return await _service.signUp(
        email: email,
        password: password,
        name: name,
      );
    } finally {
      notifyListeners();
    }
  }

  Future<Result<AuthStatus>> forgotPassword({required String email}) async {
    try {
      return await _service.forgotPassword(email: email);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> signOut() async {
    try {
      return await _service.signOut();
    } finally {
      notifyListeners();
    }
  }

  void changeAuthMethod(AuthMethod method) {
    _authMethod = method;
    notifyListeners();
  }
}
