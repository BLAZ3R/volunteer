// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class MainTheme {
  static MainTheme of(BuildContext context) => LightModeTheme();

  late Color primaryColor;
  late Color secondaryColor;
  late Color tertiaryColor;
  late Color alternate;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color primaryText;
  late Color secondaryText;

  TextStyle get title1 => GoogleFonts.getFont(
        'Open Sans',
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      );
  TextStyle get title2 => GoogleFonts.getFont(
        'Open Sans',
        color: secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
  TextStyle get title3 => GoogleFonts.getFont(
        'Open Sans',
        color: primaryText,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      );
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Open Sans',
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Open Sans',
        color: secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Open Sans',
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Open Sans',
        color: secondaryText,
        fontWeight: FontWeight.w400,
        fontSize: 13,
      );
}

class LightModeTheme extends MainTheme {
  Color primaryColor = Color.fromARGB(255, 4, 202, 50);
  Color secondaryColor = const Color(0xFFA78B5A);
  Color tertiaryColor = const Color(0xFF5B5B5B);
  Color alternate = const Color(0xFFFF5963);
  Color primaryBackground = const Color(0xFFFFFFFF);
  Color secondaryBackground = const Color(0xFFFFFFFF);
  Color primaryText = Color.fromARGB(255, 0, 0, 0);
  Color secondaryText = const Color(0xFFFFFFFF);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
