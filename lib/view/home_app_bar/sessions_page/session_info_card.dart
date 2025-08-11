import 'package:flutter/material.dart';
import 'package:moe_wifi/model/session.dart';
import 'package:moe_wifi/view/home_app_bar/sessions_page/session_info_body.dart';
import 'package:moe_wifi/view/home_app_bar/sessions_page/session_info_header.dart';

class SessionInfoCard extends StatelessWidget {
  const SessionInfoCard({super.key, required this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10).copyWith(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SessionInfoHeader(session: session),
              SessionInfoBody(session: session),
            ],
          ),
        ),
      ),
    );
  }
}
