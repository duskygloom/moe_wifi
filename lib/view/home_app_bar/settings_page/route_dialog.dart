import 'package:flutter/material.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/model/api.dart';
import 'package:moe_wifi/model/config_storage.dart';

class RouteDialog extends StatelessWidget {
  const RouteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final config = ConfigStorage.of(context, true);

    return AlertDialog(
      title: Text('Routes'),
      content: SizedBox(
        height: scaledSizeOf(context, 200),
        width: scaledSizeOf(context, 400),
        child: ListView.builder(
          itemCount: Api.routes.length,
          itemBuilder:
              (context, index) => RadioListTile(
                value: Api.routes[index],
                title: Text(
                  Api.routes[index],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                groupValue: config.route,
                onChanged: (value) {
                  config.route = value ?? ConfigStorage.defaultRoute;
                },
              ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
