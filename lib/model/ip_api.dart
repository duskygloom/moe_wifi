import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moe_wifi/model/config_storage.dart';

typedef InfoType = Map<String, dynamic>;

class IpApi {
  IpApi(this.config);

  final ConfigStorage config;

  static IpApi of(BuildContext context, [bool listen = false]) {
    return IpApi(ConfigStorage.of(context, listen));
  }

  Future<List<InfoType>> _getAddrInfo() async {
    final result = await Process.run('ip', ['-json', '-brief', 'addr']);
    final data = json.decode(result.stdout) as List;
    return List.generate(data.length, (index) => data[index] as InfoType);
  }

  Future<List<String>> fetchWifiDevices() async {
    if (Platform.isLinux) {
      final addr = await _getAddrInfo();
      final devicesList = List.generate(
        addr.length,
        (index) => (addr[index]['ifname'] ?? '') as String,
      );
      return devicesList;
    } else {
      return [];
    }
  }
}
