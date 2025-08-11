import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef FormKeyType = GlobalKey<FormState>;

class FormKeys {
  final newUserKey = FormKeyType();
  final settingsKey = FormKeyType();

  static FormKeyType newUserKeyOf(BuildContext context) {
    return context.read<FormKeys>().newUserKey;
  }

  static FormKeyType settingsKeyOf(BuildContext context) {
    return context.read<FormKeys>().settingsKey;
  }
}
