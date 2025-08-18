import 'package:flutter/material.dart';
import 'package:moe_wifi/model/form_keys.dart';
import 'package:moe_wifi/view/core/validators.dart';
import 'package:moe_wifi/view/core/text_input.dart';

class NewUserForm extends StatelessWidget {
  const NewUserForm({
    super.key,
    required this.phoneCtrl,
    required this.passwordCtrl,
    this.onDone,
  });

  final TextEditingController phoneCtrl;
  final TextEditingController passwordCtrl;
  final void Function()? onDone;

  @override
  Widget build(BuildContext context) {
    final formKey = FormKeys.newUserKeyOf(context);

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          TextInput(
            labelText: 'Phone',
            validator: emptyValidator,
            keyboardType: TextInputType.number,
            controller: phoneCtrl,
            autofocus: true,
            textInputAction: TextInputAction.next,
          ),
          TextInput(
            labelText: 'Password',
            obscureText: true,
            validator: emptyValidator,
            controller: passwordCtrl,
            textInputAction: TextInputAction.go,
            onEditingComplete: onDone,
          ),
        ],
      ),
    );
  }
}
