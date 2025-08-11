import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

typedef UserInfoType = Map<String, String>;

class UserStorage extends ChangeNotifier {
  UserStorage(this.appdir);

  final String appdir;

  String get _datadir => path.join(appdir, 'data');
  String get _usersfile => path.join(_datadir, 'users.json');

  Iterable<String> get users {
    try {
      final f = File(_usersfile);
      if (!f.existsSync()) f.createSync(recursive: true);
      final Map data = json.decode(f.readAsStringSync());
      final UserInfoType info = Map.castFrom(data);
      return info.keys;
    } catch (e) {
      return Iterable.empty();
    }
  }

  int get length => users.length;

  void addUser(String phone, String password) {
    try {
      final f = File(_usersfile);
      if (!f.existsSync()) f.createSync(recursive: true);
      final Map data = json.decode(f.readAsStringSync());
      final UserInfoType info = Map.castFrom(data);
      info[phone] = password;
      f.writeAsStringSync(json.encode(info), flush: true);
    } catch (e) {
      // save current file as backup
      final existing = File(_usersfile);
      if (existing.existsSync()) {
        final backupFilename =
            'users_backup_${DateTime.now().millisecondsSinceEpoch}.json';
        existing.renameSync(path.join(_datadir, backupFilename));
      }
      // create a new empty file
      final f = File(_usersfile);
      f.createSync(recursive: true);
      f.writeAsStringSync(json.encode({phone: password}), flush: true);
    }

    notifyListeners();
  }

  /// @note
  /// Remember to update default user after this!
  void removeUser(String phone) {
    try {
      final f = File(_usersfile);
      if (!f.existsSync()) f.createSync(recursive: true);
      final Map data = json.decode(f.readAsStringSync());
      final UserInfoType info = Map.castFrom(data);
      info.remove(phone);
      f.writeAsStringSync(json.encode(info), flush: true);
    } catch (e) {
      // save current file as backup
      final existing = File(_usersfile);
      if (existing.existsSync()) {
        final backupFilename =
            'users_backup_${DateTime.now().millisecondsSinceEpoch}.json';
        existing.renameSync(path.join(_datadir, backupFilename));
      }
      // no user file exists now
    }

    notifyListeners();
  }

  String? getPassword(String phone) {
    try {
      final f = File(_usersfile);
      if (!f.existsSync()) f.createSync(recursive: true);
      final Map data = json.decode(f.readAsStringSync());
      final UserInfoType info = Map.castFrom(data);
      return info[phone];
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    return '$length users: ${users.join(', ')}';
  }

  static UserStorage of(BuildContext context, [bool listen = false]) {
    return Provider.of<UserStorage>(context, listen: listen);
  }
}
