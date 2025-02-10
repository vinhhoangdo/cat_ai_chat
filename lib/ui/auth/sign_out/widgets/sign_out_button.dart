import 'package:cat_ai_gen/ui/ui.dart';
import 'package:flutter/material.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({super.key, required this.viewModel});

  final SignOutViewModel viewModel;

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.signOut.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant SignOutButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.signOut.removeListener(_onResult);
    widget.viewModel.signOut.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.signOut.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.viewModel.signOut.execute();
      },
      icon: Icon(Icons.logout),
    );
  }

  void _onResult() {
    // We do not need to navigate to `/login` on logout,
    // it is done automatically by GoRouter.

    if (widget.viewModel.signOut.error) {
      widget.viewModel.signOut.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Fail to Sign out"),
          action: SnackBarAction(
            label: "Try Again",
            onPressed: widget.viewModel.signOut.execute,
          ),
        ),
      );
    }
  }
}
