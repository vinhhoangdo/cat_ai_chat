import 'package:cat_ai_gen/routing/routes.dart';
import 'package:cat_ai_gen/ui/ui.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.viewModel});

  final SignInViewModel viewModel;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
              child: const Text('Close'),
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
      body: Column(
        spacing: 12.0,
        children: [
          TextField(
            controller: _email,
          ),
          TextField(
            controller: _password,
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              widget.viewModel.signIn.execute(
                (_email.value.text, _password.value.text),
              );
            },
            child: ListenableBuilder(
                listenable: widget.viewModel.signIn,
                builder: (context, child) {
                  if (widget.viewModel.signIn.running) {
                    return CircularProgressIndicator();
                  }
                  return Text("Sign In");
                }),
          ),
        ],
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
            label: "Try again",
            onPressed: () => widget.viewModel.signIn.execute(
              (_email.value.text, _password.value.text),
            ),
          ),
        ),
      );
      widget.viewModel.signIn.clearResult();
    }
  }
}
