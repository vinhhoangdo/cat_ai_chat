import 'package:cat_ai_gen/data/data.dart';
import 'package:cat_ai_gen/utils/utils.dart';

typedef SignInArg = (String email, String password);
typedef SignUpArg = (String email, String password, String name);

class AuthViewModel {
  AuthViewModel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    signIn = CommandWithArg(_signIn);
    signInWithGoogle = CommandNoneArg(_signInWithGoogle);
    forgotPassword = CommandWithArg(_forgotPassword);
    signOut = CommandNoneArg(_signOut);
    signUp = CommandWithArg(_signUp);
  }

  late CommandWithArg<AuthStatus, SignUpArg> signUp;

  final AuthRepository _authRepository;
  late CommandWithArg<AuthStatus, SignInArg> signIn;
  late CommandNoneArg signOut;
  late CommandNoneArg signInWithGoogle;

  late CommandWithArg<AuthStatus, String> forgotPassword;

  Future<Result<AuthStatus>> _signIn(SignInArg credentials) async {
    final (email, password) = credentials;
    final result = await _authRepository.signIn(
      email: email,
      password: password,
    );
    return result;
  }

  Future<Result<AuthStatus>> _signInWithGoogle() async {
    return await _authRepository.signInWithGoogle();
  }

  Future<Result<AuthStatus>> _forgotPassword(String email) async {
    final result = await _authRepository.forgotPassword(email: email);
    return result;
  }

  Future<Result<AuthStatus>> _signUp(SignUpArg credentials) async {
    final (email, password, name) = credentials;
    return await _authRepository.signUp(
      email: email,
      password: password,
      name: name,
    );
  }

  Future<Result<void>> _signOut() async {
    await _authRepository.signOut();
    return Result.ok(null);
  }
}
