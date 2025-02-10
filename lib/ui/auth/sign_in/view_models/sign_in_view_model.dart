import 'package:cat_ai_gen/data/repositories/auth/auth_repository.dart';
import 'package:cat_ai_gen/utils/utils.dart';

class SignInViewModel {
  SignInViewModel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    signIn = CommandWithArg<String, (String email, String password)>(_signIn);
  }

  final AuthRepository _authRepository;
  late CommandWithArg signIn;

  Future<Result<String>> _signIn((String, String) credentials) async {
    final (email, password) = credentials;
    final result = await _authRepository.signIn(
      email: email,
      password: password,
    );
    return result;
  }
}
