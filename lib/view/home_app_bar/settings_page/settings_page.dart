import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/form_keys.dart';
import 'package:moe_wifi/view/core/responsive_container.dart';
import 'package:moe_wifi/view/home_app_bar/settings_page/settings_form.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = FormKeys.settingsKeyOf(context);
    final routeCtrl = TextEditingController();
    final timeoutCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: screenWidthOf(context) >= bigScreenWidth,
        actions: [
          IconButton(
            onPressed: () {
              // save config
              if (formKey.currentState?.validate() == true) {
                final config = ConfigStorage.of(context);
                config.route = routeCtrl.text;
                config.timeoutInMillis = int.tryParse(timeoutCtrl.text) ?? 5000;
              }
              Navigator.pop(context);
            },
            icon: Icon(Symbols.check, color: Colors.green),
          ),
        ],
      ),
      body: ResponsiveContainer(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SettingsForm(routeCtrl: routeCtrl, timeoutCtrl: timeoutCtrl),
        ),
      ),
    );
  }
}
