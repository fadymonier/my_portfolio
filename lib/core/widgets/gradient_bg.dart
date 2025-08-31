import 'dart:ui';

import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Stack(
        children: [
          // البقعة التركواز مع بلور
          Positioned(
            left: -250,
            top: -200,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 180, sigmaY: 180),
              child: Container(
                width: 600,
                height: 600,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [AppColors.primary, Colors.transparent],
                    stops: [0.0, 1.0],
                    radius: 0.8,
                  ),
                ),
              ),
            ),
          ),

          // البقعة البنفسجي مع بلور
          Positioned(
            right: -250,
            bottom: -200,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 180, sigmaY: 180),
              child: Container(
                width: 600,
                height: 600,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [AppColors.secondary, Colors.transparent],
                    stops: [0.0, 1.0],
                    radius: 0.8,
                  ),
                ),
              ),
            ),
          ),

          // المحتوى
          child,
        ],
      ),
    );
  }
}
