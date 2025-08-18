import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

typedef ConfigInfoType = Map<String, dynamic>;

class ConfigStorage extends ChangeNotifier {
  ConfigStorage(this.appdir);

  final String appdir;

  String get _datadir => path.join(appdir, 'data');
  String get _configfile => path.join(_datadir, 'config.json');

  Iterable<String> get configs {
    try {
      final f = File(_configfile);
      if (!f.existsSync()) f.createSync(recursive: true);
      final Map data = json.decode(f.readAsStringSync());
      final ConfigInfoType info = Map.castFrom(data);
      return info.keys;
    } catch (e) {
      return Iterable.empty();
    }
  }

  int get length => configs.length;

  T? _getConfig<T>(String name) {
    try {
      final f = File(_configfile);
      if (!f.existsSync()) f.createSync(recursive: true);
      final Map data = json.decode(f.readAsStringSync());
      final ConfigInfoType info = Map.castFrom(data);
      return info[name] == null ? null : info[name] as T;
    } catch (e) {
      // save current file as backup
      final existing = File(_configfile);
      if (existing.existsSync()) {
        final backupFilename =
            'config_backup_${DateTime.now().millisecondsSinceEpoch}.json';
        existing.renameSync(path.join(_datadir, backupFilename));
      }
      // no config file now
      return null;
    }
  }

  void _putConfig<T>(String name, T value) {
    try {
      final f = File(_configfile);
      if (!f.existsSync()) f.createSync(recursive: true);
      final Map data = json.decode(f.readAsStringSync());
      final ConfigInfoType info = Map.castFrom(data);
      info[name] = value;
      f.writeAsStringSync(json.encode(info), flush: true);
    } catch (e) {
      // save current file as backup
      final existing = File(_configfile);
      if (existing.existsSync()) {
        final backupFilename =
            'config_backup_${DateTime.now().millisecondsSinceEpoch}.json';
        existing.renameSync(path.join(_datadir, backupFilename));
      }
      // create a new empty file
      final f = File(_configfile);
      f.createSync(recursive: true);
      f.writeAsStringSync(json.encode({name: value}), flush: true);
    }
  }

  /* default user */

  String get defaultUser {
    final value = _getConfig<String>('defaultUser');
    return value ?? '';
  }

  set defaultUser(String phone) {
    _putConfig<String>('defaultUser', phone);
    notifyListeners();
  }

  /* route */

  String get route {
    final value = _getConfig<String>('route');
    return value ?? 'http://1.254.254.254';
  }

  set route(String value) {
    _putConfig<String>('route', value);
    notifyListeners();
  }

  /* cookie */

  String get cookie {
    final value = _getConfig<String>('cookie');
    return value ?? '';
  }

  set cookie(String value) {
    _putConfig<String>('cookie', value);
    notifyListeners();
  }

  /* timeout */

  int get defaultTimeout => 5000;

  int get timeoutInMillis {
    final value = _getConfig<int>('timeoutInMillis');
    return value ?? defaultTimeout;
  }

  set timeoutInMillis(int value) {
    _putConfig<int>('timeoutInMillis', value);
    notifyListeners();
  }

  /* auth url */

  String get authUrl {
    final value = _getConfig<String>('authUrl');
    return value ?? '';
  }

  set authUrl(String value) {
    _putConfig<String>('authUrl', value);
    notifyListeners();
  }

  /* static mode */

  bool get staticMode {
    final value = _getConfig<bool>('staticMode');
    return value ?? false;
  }

  set staticMode(bool value) {
    _putConfig<bool>('staticMode', value);
    notifyListeners();
  }

  /* static mode */

  String get wifiDevice {
    final value = _getConfig<String>('wifiDevice');
    return value ?? '';
  }

  set wifiDevice(String value) {
    _putConfig<String>('wifiDevice', value);
    notifyListeners();
  }

  @override
  String toString() {
    return '$length configs.';
  }

  static ConfigStorage of(BuildContext context, [bool listen = false]) {
    return Provider.of<ConfigStorage>(context, listen: listen);
  }
}
