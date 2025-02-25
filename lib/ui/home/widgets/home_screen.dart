import 'package:cat_ai_gen/ui/ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(text: "Welcome "),
                TextSpan(
                  text: FirebaseAuth.instance.currentUser!.email,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextSpan(text: " back!"),
              ],
            ),
          ),
          SignOutButton(
            viewModel: SignOutViewModel(
              authRepository: context.read(),
            ),
          ),
        ],
      ),
    );
  }
}
