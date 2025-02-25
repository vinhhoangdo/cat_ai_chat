import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'CatieTalk';

  @override
  String get signIn => 'Sign In';

  @override
  String get signInWithGoogle => 'Sign In With Google';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signOut => 'Sign Out';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get close => 'Close';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get tryAgain => 'Try again';

  @override
  String get failToSignOut => 'Fail to Sign out';

  @override
  String get termAndPrivacy => 'Terms of use. Privacy policy';
}
