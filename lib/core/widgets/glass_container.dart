import 'dart:ui';

import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 16,
    this.blurSigma = 12,
    this.borderColor,
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blurSigma;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          margin: margin ?? EdgeInsets.zero,
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.6),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: (borderColor ?? AppColors.primary).withOpacity(0.3),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
