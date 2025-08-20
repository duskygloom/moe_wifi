import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/view/home_app_bar/settings_page/adapter_dialog.dart';
import 'package:moe_wifi/view/home_app_bar/settings_page/route_dialog.dart';
import 'package:moe_wifi/view/home_app_bar/settings_page/static_ip_switch.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final config = ConfigStorage.of(context, true);
    final queries = Uri.parse(config.authUrl).queryParameters;

    final advancedWidgets = <Widget>[
      ListTile(
        leading: Icon(Symbols.settings_input_antenna),
        title: Text('Adapter name'),
        subtitle: Text(config.wifiDevice),
        onTap: () {
          Navigator.push(
            context,
            DialogRoute(
              context: context,
              builder: (context) => AdapterDialog(),
            ),
          );
        },
      ),
      ListTile(
        leading: Icon(Symbols.dns),
        title: Text('Static IP'),
        trailing: StaticIpSwitch(),
      ),
    ];

    final infoWidgets = <Widget>[
      ListTile(
        leading: Icon(Symbols.wifi),
        title: Text('IP'),
        subtitle: Text(queries['ip'] ?? ''),
        enabled: false,
      ),
      ListTile(
        leading: Icon(Symbols.devices),
        title: Text('MAC'),
        subtitle: Text(queries['mac'] ?? ''),
        enabled: false,
      ),
      ListTile(
        leading: Icon(Symbols.qr_code),
        title: Text('Code'),
        subtitle: Text(queries['sc'] ?? ''),
        enabled: false,
      ),
      ListTile(
        leading: Icon(Symbols.cookie),
        title: Text('Cookie'),
        subtitle: Text(config.cookie),
        enabled: false,
      ),
    ];

    final baseWidgets = <Widget>[
      ListTile(
        leading: Icon(Symbols.alt_route),
        title: Text('Route'),
        subtitle: Text(config.route),
        onTap: () {
          Navigator.push(
            context,
            DialogRoute(context: context, builder: (context) => RouteDialog()),
          );
        },
      ),
      ListTile(
        leading: Icon(Symbols.timer),
        title: Text('Timeout'),
        subtitle: Text(config.timeoutString),
        onTap: () {
          Navigator.push(
            context,
            DialogRoute(
              context: context,
              builder: (context) => TimeoutDialog(),
            ),
          );
        },
      ),
    ];

    final fieldWidgets =
        baseWidgets + (Platform.isLinux ? advancedWidgets : []) + infoWidgets;

    return ListView.separated(
      itemCount: fieldWidgets.length,
      itemBuilder: (context, index) => fieldWidgets[index],
      separatorBuilder: (context, index) => SizedBox(height: 10),
    );
  }
}

class TimeoutDialog extends StatelessWidget {
  const TimeoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final config = ConfigStorage.of(context, true);
    return AlertDialog(
      title: Text('Timeout'),
      content: SizedBox(
        width: scaledSizeOf(context, 400),
        height: scaledSizeOf(context, 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              value: config.timeoutInMillis / 20000,
              divisions: 10,
              onChanged: (value) {
                config.timeoutInMillis = (value * 20000).toInt();
              },
            ),
            Text(config.timeoutString, style: TextTheme.of(context).titleLarge),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
