import 'dart:ui';

import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/utils/app_images.dart';
import 'package:fady_portfolio/core/utils/url_launcher_helper.dart';
import 'package:fady_portfolio/data/repositories/profile_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  String _getSocialUrl(String label) {
    final profile = ProfileRepositoryImpl.profileRepository.getProfile();
    return profile.socials.firstWhere((s) => s.label == label).url;
  }

  @override
  Widget build(BuildContext context) {
    final profile = ProfileRepositoryImpl.profileRepository.getProfile();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;

        final avatarCard = ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.background.withOpacity(0.5),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.5),
                  width: 1.5,
                ),
                gradient: const LinearGradient(
                  colors: [
                    Color(0x331ABC9C),
                    Color(0x3300D4FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  AppImages.me,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .moveY(begin: 24, end: 0, curve: Curves.easeOutCubic);

        final headline = Column(
          crossAxisAlignment:
              isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Text(
              'Hello, I\'m',
              style: AppFontStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(rect);
              },
              child: Text(
                profile.name,
                style: AppFontStyle(
                  fontSize: isWide ? 40 : 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              profile.title,
              style: AppFontStyle(
                fontSize: isWide ? 20 : 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: isWide ? 520 : double.infinity,
              child: Text(
                profile.summary,
                style: AppFontStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 22),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () => launchExternalUrl(_getSocialUrl('LinkedIn')),
                  icon: Image.asset(AppImages.linkedin, width: 22),
                  label: Text(
                    'LinkedIn',
                    style: AppFontStyle(fontSize: 14),
                  ),
                ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColors.textPrimary,
                    side: BorderSide(
                      color: AppColors.textSecondary.withOpacity(0.6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () => launchExternalUrl(_getSocialUrl('GitHub')),
                  icon: Image.asset(AppImages.github, width: 22),
                  label: Text(
                    'GitHub',
                    style: AppFontStyle(fontSize: 14),
                  ),
                ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.secondary.withOpacity(0.9),
                    foregroundColor: AppColors.textPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () => launchExternalUrl(_getSocialUrl('CV')),
                  icon: Image.asset(AppImages.cv, width: 22),
                  label: Text(
                    'Download CV',
                    style: AppFontStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .moveY(begin: 24, end: 0, curve: Curves.easeOutCubic);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 6, child: headline),
                        const SizedBox(width: 32),
                        Expanded(flex: 5, child: avatarCard),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        avatarCard,
                        const SizedBox(height: 24),
                        headline,
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

