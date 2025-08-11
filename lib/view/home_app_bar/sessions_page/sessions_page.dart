import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/model/refresh_keys.dart';
import 'package:moe_wifi/view/home_app_bar/sessions_page/sessions_body.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sessions'),
        centerTitle: screenWidthOf(context) >= bigScreenWidth,
        forceMaterialTransparency: true,
      ),
      body: SessionsBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final refreshKey = RefreshKeys.sessionKeyOf(context);
          await refreshKey.currentState?.show();
        },
        child: Icon(Symbols.refresh),
      ),
    );
  }
}
