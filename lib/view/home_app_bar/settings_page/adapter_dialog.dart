import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/ip_api.dart';
import 'package:moe_wifi/view/core/save_dialog.dart';

class AdapterDialog extends StatelessWidget {
  const AdapterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final adaptersFuture = IpApi.of(context).fetchWifiDevices();

    return SaveDialog(
      onSave: () {
        Navigator.pop(context);
      },
      child: SizedBox(
        width: 500,
        height: 500,
        child: FutureBuilder(
          future: adaptersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return AdapterList(adapters: data);
            } else {
              return Center(
                child: Icon(Symbols.error, color: colorSchemeOf(context).error),
              );
            }
          },
        ),
      ),
    );
  }
}

class AdapterList extends StatelessWidget {
  const AdapterList({super.key, required this.adapters});

  final List<String> adapters;

  @override
  Widget build(BuildContext context) {
    final config = ConfigStorage.of(context, true);
    return ListView.builder(
      itemCount: adapters.length,
      itemBuilder:
          (context, index) => RadioListTile<String>(
            key: ValueKey(adapters[index]),
            value: adapters[index],
            groupValue: config.wifiDevice,
            title: Text(adapters[index]),
            onChanged: (value) async {
              if (value != null) {
                config.wifiDevice = value;
              }
            },
          ),
    );
  }
}
