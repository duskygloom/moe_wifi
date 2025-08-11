import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appdir {
  final String path;

  const Appdir(this.path);

  static String pathOf(BuildContext context, [bool listen = false]) {
    return Provider.of(context, listen: listen).path;
  }
}
