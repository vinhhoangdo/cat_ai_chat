import 'package:cat_ai_gen/core/core.dart';
import 'package:cat_ai_gen/routing/routes.dart';
import 'package:cat_ai_gen/ui/auth/sign_in/helper/sign_in_validator.dart';
import 'package:cat_ai_gen/ui/ui.dart';
import 'package:cat_ai_gen/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.viewModel});

  final SignInViewModel viewModel;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SignInValidator {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _dialogBuilder({
    required String title,
    required String body,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(context.locale.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    widget.viewModel.signIn.addListener(_onResult);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //TODO (vince): Remove it later!
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        if (mounted) {
          _dialogBuilder(
            title: message.notification!.title ?? "",
            body: message.notification!.body ?? "",
          );
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant SignInScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.signIn.removeListener(_onResult);
    widget.viewModel.signIn.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.signIn.removeListener(_onResult);
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 12.0,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.locale.appName,
                  style: GoogleFonts.darumadropOne(
                      textStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 45,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  )),
                ),
                CatTextFormField(
                  controller: _email,
                  hintText: context.locale.email,
                  validator: emailValidate,
                ),
                CatTextFormField(
                  controller: _password,
                  hintText: context.locale.password,
                  obscureText: true,
                  validator: passwordValidate,
                ),
                CatButton(
                  type: ButtonType.outlined,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.viewModel.signIn.execute(
                        (_email.value.text, _password.value.text),
                      );
                    }
                  },
                  child: ListenableBuilder(
                    listenable: widget.viewModel.signIn,
                    builder: (context, child) {
                      if (widget.viewModel.signIn.running) {
                        return CircularProgressIndicator();
                      }
                      return Text(
                        context.locale.signIn.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      );
                    },
                  ),
                ),
                CatButton(
                  onPressed: () {
                    widget.viewModel.signInWithGoogle.execute();
                  },
                  type: ButtonType.elevated,
                  child: Text(
                    context.locale.signInWithGoogle,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Text(context.locale.termAndPrivacy),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onResult() {
    if (widget.viewModel.signIn.completed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.viewModel.signIn.result.toString()),
        ),
      );
      widget.viewModel.signIn.clearResult();
      context.go(Routes.home);
    }

    if (widget.viewModel.signIn.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.viewModel.signIn.result.toString()),
          action: SnackBarAction(
            label: context.locale.tryAgain,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.viewModel.signIn.execute(
                  (_email.value.text, _password.value.text),
                );
              }
            },
          ),
        ),
      );
      widget.viewModel.signIn.clearResult();
    }
  }
}
