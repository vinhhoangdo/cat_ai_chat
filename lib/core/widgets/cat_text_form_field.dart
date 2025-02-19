import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CatTextFormField extends StatelessWidget {
  const CatTextFormField({
    super.key,
    required this.controller,
    this.label,
    this.hintText,
    this.hintTextStyle,
    this.counterText,
    this.validator,
    this.onChanged,
    this.onTapOutside,
    this.onTap,
    this.keyboardType,
    this.enabled,
    this.inputFormatters,
    this.textStyle,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.borderRadius = 20.0,
    this.contentPadding = 12.0,
    this.alignLabelWithHint = true,
    this.filled = true,
  });

  final TextEditingController controller;

  final String? label;

  final String? hintText;

  final TextStyle? hintTextStyle;

  final String? counterText;

  final String? Function(String? value)? validator;

  final Function(String)? onChanged;

  /// Default is `Unfocused`, i.e., hide keyboard.
  final Function(PointerDownEvent)? onTapOutside;

  final VoidCallback? onTap;

  final TextInputType? keyboardType;

  final bool? enabled;

  /// Default is `false`
  final bool obscureText;

  /// Default is `false`
  final bool readOnly;

  /// Default is null.
  final int? maxLength;

  /// Default is `1`
  final int minLines;

  /// Default is `1`
  final int maxLines;

  /// Default is `20.0`
  final double borderRadius;

  /// Default is `12.0`
  final double contentPadding;

  /// Default is `true`
  ///
  /// If `false` && TextFormField contains a multiline [TextField] ([TextField.maxLines] is null or > 1)
  /// to override the default behavior of aligning the label with the center of the [TextField].
  final bool alignLabelWithHint;

  final TextStyle? textStyle;

  final bool filled;

  /// e.g.
  ///
  /// ```dart
  /// inputFormatters: <TextInputFormatter>[
  /// FilteringTextInputFormatter.digitsOnly, // Allow only digits
  /// FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')), // Allow digits and at most 2 decimal places
  /// FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), // Allow alphabets only
  /// FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9!@#$%^&*()_+,\-=\[\]{};':"\\|<>\?]+')), // Allow alphanumeric and special characters
  /// ...
  /// ...
  /// ],
  /// ```
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside ?? (event) => FocusScope.of(context).unfocus(),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      style: textStyle,
      decoration: InputDecoration(
        alignLabelWithHint: alignLabelWithHint,
        labelText: label,
        hintText: hintText,
        hintStyle: hintTextStyle,
        filled: filled,
        counterText: counterText,
        contentPadding: EdgeInsets.all(contentPadding),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
