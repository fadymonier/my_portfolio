import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/widgets/glass_container.dart';
import 'package:fady_portfolio/data/repositories/profile_repository_impl.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileRepositoryImpl.profileRepository.getProfile();
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Me',
                style: AppFontStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                profile.summary,
                style: AppFontStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 28),
              Text(
                'Experience',
                style: AppFontStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ...profile.experience.map(
                (e) => GlassContainer(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: const Icon(
                      Icons.work_outline,
                      color: AppColors.accent,
                    ),
                    title: Text(
                      '${e.role} • ${e.company}',
                      style: AppFontStyle(color: AppColors.textPrimary),
                    ),
                    subtitle: Text(
                      '${e.type}${e.place.isEmpty ? '' : ' • ${e.place}'}\n${e.period}\n• ${e.bullets.join('\n• ')}',
                      style: AppFontStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Education',
                style: AppFontStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ...profile.education.map(
                (e) => GlassContainer(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: const Icon(
                      Icons.school_outlined,
                      color: AppColors.secondary,
                    ),
                    title: Text(
                      e.title,
                      style: AppFontStyle(color: AppColors.textPrimary),
                    ),
                    subtitle: Text(
                      '${e.org}\n${e.period}',
                      style: AppFontStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
