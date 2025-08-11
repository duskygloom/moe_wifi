import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef RefreshKeyType = GlobalKey<RefreshIndicatorState>;

class RefreshKeys {
  final sessionKey = RefreshKeyType();

  static RefreshKeyType sessionKeyOf(BuildContext context) {
    return context.read<RefreshKeys>().sessionKey;
  }
}
