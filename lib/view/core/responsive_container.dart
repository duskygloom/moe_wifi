import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moe_wifi/core/main_theme.dart';

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: min(screenWidthOf(context), bigScreenWidth),
        child: child,
      ),
    );
  }
}
