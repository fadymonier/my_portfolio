// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_images.dart';
import 'package:fady_portfolio/core/widgets/gradient_bg.dart';
import 'package:fady_portfolio/main.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progress = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      setState(() {
        progress += 2;
        if (progress >= 100) {
          progress = 100;
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 400), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyPortfolioApp()),
            );
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(AppImages.splash, width: 100, height: 100),
                ),
              ),
              const SizedBox(height: 24),

              // progress bar
              Container(
                width: 160,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.textSecondary.withOpacity(0.15),
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 1.6 * progress,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "${progress.toInt()}%",
                style: AppFontStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    const Shadow(color: AppColors.secondary, blurRadius: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
