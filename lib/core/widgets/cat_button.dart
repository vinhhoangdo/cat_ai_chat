import 'package:flutter/material.dart';

enum ButtonType { icon, outlined, text, elevated }

class CatButton extends StatelessWidget {
  const CatButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.type,
    this.buttonStyle,
  });

  final Widget child;
  final Function() onPressed;
  final ButtonStyle? buttonStyle;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    return catButtonByType;
  }

  Widget get catButtonByType {
    return switch (type) {
      ButtonType.icon => ElevatedButton.icon(
          onPressed: onPressed,
          style: buttonStyle,
          label: child,
        ),
      ButtonType.outlined => OutlinedButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: child,
        ),
      ButtonType.text => TextButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: child,
        ),
      _ => ElevatedButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: child,
        ),
    };
  }
}
