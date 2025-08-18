import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef FormKeyType = GlobalKey<FormState>;

class FormKeys {
  final newUserKey = FormKeyType();
  final adapterKey = FormKeyType();

  static FormKeyType newUserKeyOf(BuildContext context) {
    return context.read<FormKeys>().newUserKey;
  }

  static FormKeyType adapterKeyOf(BuildContext context) {
    return context.read<FormKeys>().adapterKey;
  }
}
