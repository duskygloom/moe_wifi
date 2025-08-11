import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/model/session.dart';

class SessionInfoBody extends StatelessWidget {
  const SessionInfoBody({super.key, required this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    final iconSize = scaledSizeOf(context, defaultIconSize);

    return Row(
      children: [
        ExpandedCentered(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              Text(
                session.startDateString,
                style: TextTheme.of(context).titleMedium,
              ),
              Text(
                session.startTimeString,
                style: TextTheme.of(context).titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(
          height: scaledSizeOf(context, 20),
          child: VerticalDivider(
            width: 2,
            thickness: 2,
            color: colorSchemeOf(context).onSurfaceVariant,
          ),
        ),
        ExpandedCentered(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  Icon(Symbols.arrow_upward_alt, size: iconSize),
                  Text(
                    session.upload,
                    style: TextTheme.of(context).titleMedium,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  Icon(Symbols.arrow_downward_alt, size: iconSize),
                  Text(
                    session.download,
                    style: TextTheme.of(context).titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExpandedCentered extends StatelessWidget {
  const ExpandedCentered({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Align(alignment: Alignment.topCenter, child: child));
  }
}
