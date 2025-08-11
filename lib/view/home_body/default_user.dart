import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/user_storage.dart';

class DefaultUser extends StatelessWidget {
  const DefaultUser({super.key});

  @override
  Widget build(BuildContext context) {
    final store = UserStorage.of(context, true);
    final config = ConfigStorage.of(context, true);
    final defaultUser = config.defaultUser;

    final noDefaultTile = ListTile(
      title: Text('No default user.'),
      trailing: IconButton(onPressed: null, icon: Icon(Symbols.check)),
    );

    if (defaultUser == '') return noDefaultTile;

    final password = store.getPassword(defaultUser);
    if (password == null) return noDefaultTile;

    final hiddenPassword = '*' * password.length;

    return ListTile(
      title: Text(defaultUser),
      trailing: IconButton(
        onPressed: null,
        icon: Icon(Symbols.check, color: Colors.green),
      ),
      subtitle: Text(hiddenPassword),
    );
  }
}
