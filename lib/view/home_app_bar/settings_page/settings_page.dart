import 'package:flutter/material.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/view/core/responsive_container.dart';
import 'package:moe_wifi/view/home_app_bar/settings_page/settings_form.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: screenWidthOf(context) >= bigScreenWidth,
      ),
      body: ResponsiveContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SettingsForm(),
        ),
      ),
    );
  }
}
