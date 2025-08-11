import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/view/core/responsive_container.dart';
import 'package:moe_wifi/view/home_app_bar/new_user_dialog/new_user_dialog.dart';
import 'package:moe_wifi/view/home_app_bar/sessions_page/sessions_page.dart';
import 'package:moe_wifi/view/home_app_bar/settings_page/settings_page.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('MoE Wi-Fi'),
      centerTitle: screenWidthOf(context) >= bigScreenWidth,
      forceMaterialTransparency: true,
      leading: IconButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        },
        icon: Icon(Symbols.menu),
        tooltip: 'Settings',
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await Navigator.push(
              context,
              DialogRoute(
                context: context,
                builder:
                    (context) => ResponsiveContainer(child: NewUserDialog()),
              ),
            );
          },
          icon: Icon(Symbols.add),
          tooltip: 'New user',
        ),
        IconButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SessionsPage()),
            );
          },
          icon: Icon(Symbols.list),
          tooltip: 'Sessions',
        ),
      ],
    );
  }
}
