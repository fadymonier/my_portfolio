import 'dart:ui';

import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/my_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _open(String url) async {
    final u = Uri.parse(url);
    if (await canLaunchUrl(u)) {
      await launchUrl(u, mode: LaunchMode.externalApplication);
    }
  }

  String _getSocialUrl(String label) {
    return ProfileData.socials.firstWhere((s) => s['label'] == label)['url']!;
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return LayoutBuilder(
      builder: (context, c) {
        final wide = c.maxWidth >= 900;
        final avatar = ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.background.withOpacity(0.4),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  AppImages.me,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        );

        final left = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ProfileData.name,
              style: AppFontStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              ProfileData.title,
              style: AppFontStyle(color: AppColors.accent, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              ProfileData.summary,
              style: AppFontStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary.withOpacity(0.8),
                    foregroundColor: AppColors.textPrimary,
                  ),
                  onPressed: () => _open(_getSocialUrl('LinkedIn')),
                  icon: Image.asset(AppImages.linkedin, width: 25),
                  label: Text(
                    'LinkedIn',
                    style: AppFontStyle(color: AppColors.textPrimary),
                  ),
                ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.background.withOpacity(0.7),
                    foregroundColor: AppColors.textPrimary,
                  ),
                  onPressed: () => _open(_getSocialUrl('GitHub')),
                  icon: Image.asset(AppImages.github, width: 25),
                  label: Text(
                    'GitHub',
                    style: AppFontStyle(color: AppColors.textPrimary),
                  ),
                ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.secondary.withOpacity(0.8),
                    foregroundColor: AppColors.textPrimary,
                  ),
                  onPressed: () => _open(_getSocialUrl('CV')),
                  icon: Image.asset(AppImages.cv, width: 25),
                  label: Text(
                    'CV',
                    style: AppFontStyle(color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            Text(
              'Skills',
              style: AppFontStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ProfileData.skills
                  .map(
                    (s) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.3),
                              width: 1.2,
                            ),
                          ),
                          child: Text(
                            s,
                            style: AppFontStyle(
                              fontSize: 12,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );

        final right = AspectRatio(
          aspectRatio: wide ? 1 : 16 / 9,
          child: avatar,
        );

        final content = Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 6, child: left),
                        const SizedBox(width: 24),
                        Expanded(flex: 5, child: right),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [right, const SizedBox(height: 20), left],
                    ),
            ),
          ),
        );

        return SingleChildScrollView(child: content);
      },
    );
  }
}
