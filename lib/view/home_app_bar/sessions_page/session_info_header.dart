import 'package:flutter/material.dart';
import 'package:moe_wifi/model/session.dart';
import 'package:moe_wifi/view/home_app_bar/sessions_page/close_session_button.dart';

class SessionInfoHeader extends StatelessWidget {
  const SessionInfoHeader({super.key, required this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Row(children: [Spacer(), CloseSessionButton(session: session)]);
  }
}
