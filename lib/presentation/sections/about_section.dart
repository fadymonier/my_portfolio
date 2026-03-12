import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/widgets/glass_container.dart';
import 'package:fady_portfolio/data/repositories/profile_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileRepositoryImpl.profileRepository.getProfile();

    final content =
        Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Me',
                  style: AppFontStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.summary,
                        style: AppFontStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            _infoChip(
                              Icons.location_on_outlined,
                              profile.location,
                            ),
                            _infoChip(Icons.mail_outline, profile.email),
                            _infoChip(Icons.phone_outlined, profile.phone),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
            .animate()
            .fadeIn(duration: 500.ms)
            .moveY(begin: 18, end: 0, curve: Curves.easeOutCubic);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: content,
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.accent),
        const SizedBox(width: 6),
        Text(
          text,
          style: AppFontStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
