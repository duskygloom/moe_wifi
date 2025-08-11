import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/core/errors.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/model/api.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/user_storage.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final iconSize = scaledSizeOf(context, 20);
    final icon =
        loading
            ? SizedBox(
              height: iconSize,
              width: iconSize,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
            : Icon(Symbols.login, size: iconSize);

    Future<String> loginFunction(
      Api api,
      String route,
      String phone,
      String password,
    ) async {
      await api.refreshCookie(route);
      return await api.login(phone, password);
    }

    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          colorSchemeOf(context).primaryContainer,
        ),
        shadowColor: WidgetStatePropertyAll(colorSchemeOf(context).shadow),
        elevation: WidgetStatePropertyAll(4),
        fixedSize: WidgetStatePropertyAll(
          Size(scaledSizeOf(context, 140), scaledSizeOf(context, 50)),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () async {
        final api = Api.of(context);
        final store = UserStorage.of(context);
        final config = ConfigStorage.of(context);
        if (config.defaultUser.isEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(noUserSelectedMessage)));
        } else {
          final user = config.defaultUser;
          final password = store.getPassword(user);
          if (password == null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(noUserSelectedMessage)));
          } else {
            setState(() => loading = true);
            final result = await loginFunction(
                  api,
                  config.route,
                  user,
                  password,
                )
                .timeout(
                  Duration(milliseconds: config.timeoutInMillis),
                  onTimeout: () {
                    throw KnownException('Timed out.');
                  },
                )
                .onError((error, trace) {
                  final message =
                      error is KnownException
                          ? error.toString()
                          : unhandledExceptionMessage;
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                  }
                  return '';
                });
            if (result.isNotEmpty) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(result)));
              }
            }
            setState(() => loading = false);
          }
        }
      },
      label: Text('Login'),
      icon: icon,
      iconAlignment: IconAlignment.end,
    );
  }
}
