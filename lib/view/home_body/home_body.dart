import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/view/core/responsive_container.dart';
import 'package:moe_wifi/view/home_body/default_user.dart';
import 'package:moe_wifi/view/home_body/users_list.dart';
import 'package:moe_wifi/view/home_body/login_button.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool collapsed = true;

  @override
  Widget build(BuildContext context) {
    final arrowIcon = Icon(
      collapsed ? Symbols.arrow_drop_down : Symbols.arrow_drop_up,
    );

    return ResponsiveContainer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() => collapsed = !collapsed);
                          },
                          icon: arrowIcon,
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      height: collapsed ? listTileHeight : 3 * listTileHeight,
                      child:
                          collapsed
                              ? SizedBox(
                                height: listTileHeight,
                                child: DefaultUser(),
                              )
                              : SizedBox(
                                height: 3 * listTileHeight,
                                child: UsersList(),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Center(child: LoginButton())),
        ],
      ),
    );
  }
}
