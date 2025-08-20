import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:moe_wifi/core/errors.dart';
import 'package:moe_wifi/model/config_storage.dart';

class NetworkApi {
  const NetworkApi(this.config);

  final ConfigStorage config;

  static NetworkApi of(BuildContext context, [bool listen = false]) {
    return NetworkApi(ConfigStorage.of(context, listen));
  }

  Future<List<String>> fetchDevices() async {
    final output = await Process.run('nmcli', [
      // ...
      '-e', 'no',
      '-c', 'no',
      '-g', 'DEVICE',
      'd',
    ]);
    return output.stdout.toString().trim().split('\n');
  }

  Future<String> fetchIP() async {
    final output = await Process.run('nmcli', [
      // ...
      '-e', 'no',
      '-g', 'IP4.ADDRESS',
      'c', 'show', 'MoE Wi-Fi',
    ]);
    if (output.exitCode != 0) {
      print(output.stderr);
      throw KnownException('Non-zero exit code.');
    }
    return output.stdout.toString().trim();
  }

  Future<String> fetchMAC() async {
    final output = await Process.run('nmcli', [
      // ...
      '-e', 'no',
      '-g', 'GENERAL.HWADDR',
      'd', 'show', config.wifiDevice,
    ]);
    if (output.exitCode != 0) {
      print(output.stderr);
      throw KnownException('Non-zero exit code.');
    }
    return output.stdout.toString().trim();
  }

  Future<String> fetchGateway() async {
    final output = await Process.run('nmcli', [
      // ...
      '-e', 'no',
      '-g', 'IP4.GATEWAY',
      'c', 'show', 'MoE Wi-Fi',
    ]);
    if (output.exitCode != 0) {
      print(output.stderr);
      throw KnownException('Non-zero exit code.');
    }
    return output.stdout.toString().trim();
  }

  Future<ProcessResult> setAuto() async {
    return await Process.run('nmcli', [
      'connection', 'modify', 'MoE Wi-Fi',
      // mac
      '802-11-wireless.mac-address', '',
      '802-11-wireless.cloned-mac-address', 'random',
      // ipv4
      'ipv4.method', 'auto',
      'ipv6.method', 'ignore',
      'ipv4.address', '',
      'ipv4.gateway', '',
      'ipv4.ignore-auto-dns', 'yes',
      'ipv4.dns', '8.8.4.4,8.8.8.8',
    ]);
  }

  Future<ProcessResult> setManual() async {
    final ip = await fetchIP();
    final mac = await fetchMAC();
    final gateway = await fetchGateway();

    return await Process.run('nmcli', [
      'connection', 'modify', 'MoE Wi-Fi',
      // mac address
      '802-11-wireless.mac-address', '',
      '802-11-wireless.cloned-mac-address', mac,
      // ipv4
      'ipv4.method', 'manual',
      'ipv6.method', 'ignore',
      'ipv4.address', ip,
      'ipv4.gateway', gateway,
      'ipv4.ignore-auto-dns', 'yes',
      'ipv4.dns', '8.8.4.4,8.8.8.8',
      'ipv4.dhcp-timeout', '0',
    ]);
  }
}
