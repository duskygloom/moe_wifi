import 'package:flutter/material.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/form_keys.dart';
import 'package:moe_wifi/view/core/text_input.dart';
import 'package:moe_wifi/view/core/validators.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({
    super.key,
    required this.routeCtrl,
    required this.timeoutCtrl,
  });

  final TextEditingController routeCtrl;
  final TextEditingController timeoutCtrl;

  @override
  Widget build(BuildContext context) {
    final config = ConfigStorage.of(context, true);
    final formKey = FormKeys.settingsKeyOf(context);
    final queries = Uri.parse(config.authUrl).queryParameters;

    final fieldData = [
      _FieldData(
        label: 'Route',
        value: config.route,
        controller: routeCtrl,
        validator: emptyValidator,
      ),
      _FieldData(
        label: 'Timeout (ms)',
        value: config.timeoutInMillis.toString(),
        controller: timeoutCtrl,
        validator: (text) => numberValidator(text, false),
      ),
      _FieldData(label: 'IP', value: queries['ip'], enabled: false),
      _FieldData(label: 'MAC', value: queries['mac'], enabled: false),
      _FieldData(label: 'Code', value: queries['sc'], enabled: false),
      _FieldData(label: 'Cookie', value: config.cookie, enabled: false),
    ];

    return Form(
      key: formKey,
      child: ListView.separated(
        itemCount: fieldData.length,
        itemBuilder: (context, index) => fieldData[index].getTextInput(),
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),
    );
  }
}

class _FieldData {
  const _FieldData({
    required this.label,
    this.value,
    this.enabled = true,
    this.controller,
    this.validator,
  });

  final String label;
  final String? value;
  final bool enabled;
  final TextEditingController? controller;
  final ValidatorType? validator;

  TextInput getTextInput() => TextInput(
    labelText: label,
    initialValue: controller == null ? value : null,
    enabled: enabled,
    controller: controller == null ? null : (controller!..text = value ?? ''),
    validator: validator,
  );
}
