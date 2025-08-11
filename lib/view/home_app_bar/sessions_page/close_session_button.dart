import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/core/errors.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/model/api.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/refresh_keys.dart';
import 'package:moe_wifi/model/session.dart';

class CloseSessionButton extends StatefulWidget {
  const CloseSessionButton({super.key, required this.session});

  final Session session;

  @override
  State<CloseSessionButton> createState() => _CloseSessionButtonState();
}

class _CloseSessionButtonState extends State<CloseSessionButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final iconSize = scaledSizeOf(context, 20);

    Future<void> terminateFunction(Api api, int sessNumber) async {
      await api.terminateSession(sessNumber);
    }

    return IconButton(
      onPressed: () async {
        final api = Api.of(context);
        final config = ConfigStorage.of(context);
        final refreshKey = RefreshKeys.sessionKeyOf(context);
        setState(() => loading = true);
        await terminateFunction(api, widget.session.number)
            .timeout(
              Duration(milliseconds: config.timeoutInMillis),
              onTimeout: () {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Timed out.')));
                }
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
            });
        if (mounted) setState(() => loading = false);
        await refreshKey.currentState?.show();
      },
      icon:
          loading
              ? SizedBox(
                width: iconSize,
                height: iconSize,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
              : Icon(Symbols.close, size: iconSize),
    );
  }
}
