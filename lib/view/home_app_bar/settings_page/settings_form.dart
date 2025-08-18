import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/view/home_app_bar/settings_page/adapter_dialog.dart';
import 'package:moe_wifi/view/home_app_bar/settings_page/static_ip_switch.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final config = ConfigStorage.of(context, true);
    final queries = Uri.parse(config.authUrl).queryParameters;

    final fieldWidgets = <Widget>[
      ListTile(
        leading: Icon(Symbols.alt_route),
        title: Text('Route'),
        subtitle: Text(config.route),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Symbols.timer),
        title: Text('Timeout'),
        subtitle: Text(config.timeoutInMillis.toString()),
        onTap: () {},
      ),
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

    return ListView.separated(
      itemCount: fieldWidgets.length,
      itemBuilder: (context, index) => fieldWidgets[index],
      separatorBuilder: (context, index) => SizedBox(height: 10),
    );
  }
}
