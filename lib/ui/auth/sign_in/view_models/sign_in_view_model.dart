import 'package:cat_ai_gen/data/repositories/auth/auth_repository.dart';
import 'package:cat_ai_gen/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInViewModel {
  SignInViewModel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    signIn = CommandWithArg<String, (String email, String password)>(_signIn);
    signInWithGoogle = CommandNoneArg(_signInWithGoogle);
  }

  final AuthRepository _authRepository;
  late CommandWithArg signIn;
  late CommandNoneArg signInWithGoogle;

  Future<Result<String>> _signIn((String, String) credentials) async {
    final (email, password) = credentials;
    final result = await _authRepository.signIn(
      email: email,
      password: password,
    );
    return result;
  }

  Future<Result<UserCredential?>> _signInWithGoogle() async {
    return await _authRepository.signInWithGoogle();
  }
}
