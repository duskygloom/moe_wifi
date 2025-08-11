import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/user_storage.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    final store = UserStorage.of(context, true);
    final config = ConfigStorage.of(context, true);

    return store.length == 0
        ? Center(child: Text('No saved accounts.'))
        : ListView.builder(
          itemCount: store.length,
          itemBuilder: (context, index) {
            final element = store.users.elementAt(index);
            final password = store.getPassword(element);
            return ListTile(
              title: Text(element),
              subtitle: Text(password == null ? '?' : '*' * password.length),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      UserStorage.of(context).removeUser(element);
                      if (config.defaultUser == element) {
                        config.defaultUser = '';
                      }
                    },
                    icon: Icon(Symbols.delete),
                    tooltip: 'Delete',
                  ),
                  IconButton(
                    onPressed: () {
                      config.defaultUser = element;
                    },
                    icon: Icon(
                      Symbols.check,
                      color:
                          config.defaultUser == element ? Colors.green : null,
                    ),
                    tooltip: 'Set default',
                  ),
                ],
              ),
            );
          },
        );
  }
}
