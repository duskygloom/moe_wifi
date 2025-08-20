import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/network_api.dart';

class StaticIpSwitch extends StatelessWidget {
  const StaticIpSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final config = ConfigStorage.of(context, true);

    return Switch(
      value: config.staticMode,
      onChanged: (value) async {
        final api = NetworkApi.of(context);
        if (Platform.isLinux) {
          if (value) {
            // manual mode
            await api.setManual();
          } else {
            // auto mode
            await api.setAuto();
          }
          config.staticMode = value;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Operating system is not supported.')),
          );
          config.staticMode = false;
        }
      },
    );
  }
}
