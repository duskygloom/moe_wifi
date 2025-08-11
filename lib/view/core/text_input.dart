import 'package:flutter/material.dart';
import 'package:moe_wifi/view/core/validators.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    this.labelText,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.controller,
    this.autofocus = false,
    this.onEditingComplete,
    this.initialValue,
    this.enabled = true,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final String? labelText;
  final bool obscureText;
  final ValidatorType? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool autofocus;
  final void Function()? onEditingComplete;
  final String? initialValue;
  final bool enabled;
  final TextInputAction? textInputAction;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      autofocus: autofocus,
      onEditingComplete: onEditingComplete,
      initialValue: controller == null ? initialValue : null,
      enabled: enabled,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
