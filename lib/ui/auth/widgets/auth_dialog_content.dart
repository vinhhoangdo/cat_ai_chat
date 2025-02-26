import 'package:cat_ai_gen/core/core.dart';
import 'package:cat_ai_gen/routing/routes.dart';
import 'package:cat_ai_gen/ui/ui.dart';
import 'package:cat_ai_gen/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthDialogContent extends StatefulWidget {
  const AuthDialogContent({super.key, required this.viewModel});

  final AuthViewModel viewModel;

  @override
  State<AuthDialogContent> createState() => _AuthDialogContentState();
}

class _AuthDialogContentState extends State<AuthDialogContent>
    with AuthValidator {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AuthViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    viewModel.signIn.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant AuthDialogContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.signIn.removeListener(_onResult);
    viewModel.signIn.addListener(_onResult);
  }

  @override
  void dispose() {
    viewModel.signIn.removeListener(_onResult);
    _email.dispose();
    _password.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
          //TODO: Apply later
          //   CatTextFormField(
          //     controller: _name,
          //     hintText: context.locale.name,
          //   ),
          CatButton(
            type: ButtonType.outlined,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                viewModel.signIn.execute(
                  (_email.value.text, _password.value.text),
                );
              }
            },
            child: ListenableBuilder(
              listenable: viewModel.signIn,
              builder: (context, child) {
                if (viewModel.signIn.running) {
                  return SpinKitWave(
                    size: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.inversePrimary,
                        ),
                      );
                    },
                  );
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
              viewModel.signInWithGoogle.execute();
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
          Row(
            children: [
              Text(context.locale.doNotHaveAccount),
              CatButton(
                onPressed: () {
                  //TODO(vince): Apply the Sign Up
                },
                type: ButtonType.text,
                child: Text(
                  context.locale.signUp,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onResult() {
    if (viewModel.signIn.completed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.signIn.result.toString()),
        ),
      );
      viewModel.signIn.clearResult();
      context.go(Routes.home);
    }

    if (viewModel.signIn.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.signIn.result.toString()),
          action: SnackBarAction(
            label: context.locale.tryAgain,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                viewModel.signIn.execute(
                  (_email.value.text, _password.value.text),
                );
              }
            },
          ),
        ),
      );
      viewModel.signIn.clearResult();
    }
  }
}
