import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/form_keys.dart';
import 'package:moe_wifi/model/user_storage.dart';
import 'package:moe_wifi/view/home_app_bar/new_user_dialog/new_user_form.dart';

class NewUserDialog extends StatelessWidget {
  const NewUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final formKey = FormKeys.newUserKeyOf(context);

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Spacer(),
                IconButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final store = UserStorage.of(context);
                      final config = ConfigStorage.of(context);
                      final phone = phoneCtrl.text;
                      final password = passwordCtrl.text;
                      store.addUser(phone, password);
                      config.defaultUser = phone;
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Symbols.check, color: Colors.green),
                ),
              ],
            ),
            NewUserForm(phoneCtrl: phoneCtrl, passwordCtrl: passwordCtrl),
          ],
        ),
      ),
    );
  }
}
