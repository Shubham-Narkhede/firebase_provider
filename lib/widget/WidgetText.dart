import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget widgetText(final String text,
    {final TextAlign? textAlign,
    final bool isCentered = false,
    final int maxLine = 1,
    final double latterSpacing = 0.5,
    final bool textAllCaps = false,
    final isLongText = false,
    final TextStyle? textStyle}) {
  return Text(textAllCaps ? text.toUpperCase() : text,
      textAlign: textAlign != null
          ? textAlign
          : isCentered
              ? TextAlign.center
              : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      overflow: TextOverflow.ellipsis,
      style: textStyle);
}

TextStyle textStyle(
    {double? fontSize,
    Color? textColor,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? textDecoration}) {
  return GoogleFonts.poppins(
      decoration: textDecoration,
      fontSize: fontSize,
      color: textColor,
      fontWeight: fontWeight,
      fontStyle: fontStyle);
}
