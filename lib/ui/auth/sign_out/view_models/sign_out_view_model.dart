import 'package:cat_ai_gen/data/data.dart';
import 'package:cat_ai_gen/utils/utils.dart';

class SignOutViewModel {
  SignOutViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    signOut = CommandNoneArg(_signOut);
  }

  final AuthRepository _authRepository;
  late CommandNoneArg signOut;

  Future<Result> _signOut() async {
    try {
      return Result.ok(await _authRepository.signOut());
    } catch (_) {
      return Result.error(false);
    }
  }
}
