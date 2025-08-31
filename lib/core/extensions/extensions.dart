// ignore_for_file: non_constant_identifier_names

import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle AppFontStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  List<Shadow>? shadows,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize ?? 14,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color ?? AppColors.textPrimary,
    shadows: shadows ?? [],
  );
}
