import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SaveDialog extends StatelessWidget {
  const SaveDialog({super.key, this.onSave, required this.child});

  final void Function()? onSave;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  onPressed: onSave,
                  icon: Icon(Symbols.check, color: Colors.green),
                ),
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }
}
