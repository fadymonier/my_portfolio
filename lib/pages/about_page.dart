import 'dart:ui';

import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../data/my_data.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Widget _glassContainer({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
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
                ProfileData.summary,
                style: AppFontStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 28),

              // Experience
              Text(
                'Experience',
                style: AppFontStyle(
                  fontSize: 20,

                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ...ProfileData.experience.map(
                (e) => _glassContainer(
                  child: ListTile(
                    leading: const Icon(
                      Icons.work_outline,
                      color: AppColors.accent,
                    ),
                    title: Text(
                      '${e['role']} • ${e['company']}',
                      style: AppFontStyle(color: AppColors.textPrimary),
                    ),
                    subtitle: Text(
                      '${e['type']}${e['place'].toString().isEmpty ? '' : ' • ${e['place']}'}\n${e['period']}\n• ${(e['bullets'] as List).join('\n• ')}',
                      style: AppFontStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Education
              Text(
                'Education',
                style: AppFontStyle(
                  fontSize: 20,

                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ...ProfileData.education.map(
                (e) => _glassContainer(
                  child: ListTile(
                    leading: const Icon(
                      Icons.school_outlined,
                      color: AppColors.secondary,
                    ),
                    title: Text(
                      e['title']!,
                      style: AppFontStyle(color: AppColors.textPrimary),
                    ),
                    subtitle: Text(
                      '${e['org']}\n${e['period']}',
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
