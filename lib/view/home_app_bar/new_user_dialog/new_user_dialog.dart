import 'package:flutter/material.dart';
import 'package:moe_wifi/core/main_theme.dart';
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

    void onSave() {
      if (formKey.currentState!.validate()) {
        final store = UserStorage.of(context);
        final config = ConfigStorage.of(context);
        final phone = phoneCtrl.text;
        final password = passwordCtrl.text;
        store.addUser(phone, password);
        config.defaultUser = phone;
        Navigator.pop(context);
      }
    }

    return AlertDialog(
      title: Text('New user'),
      content: SizedBox(
        width: scaledSizeOf(context, 400),
        child: NewUserForm(
          phoneCtrl: phoneCtrl,
          passwordCtrl: passwordCtrl,
          onDone: onSave,
        ),
      ),
      actions: [TextButton(onPressed: onSave, child: Text('Save'))],
    );
  }
}
