import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTheme {
  static const accentColor = Colors.purple;

  static final lightColors = ColorScheme.fromSeed(seedColor: accentColor);
  static final darkColors = ColorScheme.fromSeed(
    seedColor: accentColor,
    brightness: Brightness.dark,
  );

  static ThemeData _theme(ColorScheme colors) {
    final typo = Typography.material2021(colorScheme: colors);
    final TextTheme mainTextTheme;
    if (colors.brightness == Brightness.dark) {
      // dark theme specific values
      mainTextTheme = GoogleFonts.senTextTheme(typo.white);
    } else {
      // light theme specific values
      mainTextTheme = GoogleFonts.senTextTheme(typo.black);
    }

    final basicBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: colors.outlineVariant),
      borderRadius: BorderRadius.circular(5),
    );

    return ThemeData.from(colorScheme: colors, useMaterial3: true).copyWith(
      textTheme: mainTextTheme,
      appBarTheme: AppBarTheme(actionsPadding: EdgeInsets.all(8)),
      inputDecorationTheme: InputDecorationTheme(
        border: basicBorder,
        enabledBorder: basicBorder,
        fillColor: colors.surfaceContainerHigh,
        filled: true,
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: colors.surfaceContainer,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  static ThemeData get lightTheme => _theme(lightColors);
  static ThemeData get darkTheme => _theme(darkColors);
}

ColorScheme colorSchemeOf(BuildContext context) =>
    Theme.of(context).colorScheme;

double scaledSizeOf(BuildContext context, double size) =>
    MediaQuery.textScalerOf(context).scale(size);

double screenWidthOf(BuildContext context) => MediaQuery.sizeOf(context).width;

double get defaultIconSize => 24;

double get listTileHeight => 64;

double get bigScreenWidth => 800;
