import 'package:flutter/material.dart';
import 'package:moe_wifi/core/errors.dart';
import 'package:moe_wifi/model/api.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/refresh_keys.dart';
import 'package:moe_wifi/model/session.dart';
import 'package:moe_wifi/model/user_storage.dart';
import 'package:moe_wifi/view/core/responsive_container.dart';
import 'package:moe_wifi/view/home_app_bar/scroll_area.dart';
import 'package:moe_wifi/view/home_app_bar/sessions_page/session_info_card.dart';

class SessionsBody extends StatefulWidget {
  const SessionsBody({super.key});

  @override
  State<SessionsBody> createState() => _SessionsBodyState();
}

class _SessionsBodyState extends State<SessionsBody> {
  final sessions = <Session>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // refresh after widget is built
      final key = RefreshKeys.sessionKeyOf(context);
      key.currentState?.show().then((_) {});
    });
  }

  Future<List<Session>> getSessionsFunction(
    Api api,
    String route,
    String phone,
    String password,
  ) async {
    await api.refreshCookie(route);
    return await api.getSessions(phone, password);
  }

  Future<void> _refreshFunc() async {
    final api = Api.of(context);
    final store = UserStorage.of(context);
    final config = ConfigStorage.of(context);
    final user = config.defaultUser;

    if (user.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(noUserSelectedMessage)));
      return;
    }

    final password = store.getPassword(user) ?? '';

    final result = await getSessionsFunction(
          api,
          ConfigStorage.defaultRoute,
          user,
          password,
        )
        .timeout(
          Duration(milliseconds: config.timeoutInMillis),
          onTimeout: () {
            if (mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Timed out.')));
            }
            return [];
          },
        )
        .onError((error, trace) {
          final message =
              error is KnownException
                  ? error.toString()
                  : unhandledExceptionMessage;
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          }
          return [];
        });

    if (mounted) {
      setState(() {
        sessions.clear();
        sessions.addAll(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollArea(
      child: RefreshIndicator(
        key: RefreshKeys.sessionKeyOf(context),
        onRefresh: _refreshFunc,
        child: ResponsiveContainer(
          child: ListView.separated(
            itemCount: sessions.length,
            itemBuilder:
                (context, index) => SessionInfoCard(session: sessions[index]),
            separatorBuilder: (context, index) => SizedBox(height: 10),
          ),
        ),
      ),
    );
  }
}
