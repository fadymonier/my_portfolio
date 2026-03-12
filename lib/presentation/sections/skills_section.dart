import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/widgets/glass_container.dart';
import 'package:fady_portfolio/data/repositories/profile_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileRepositoryImpl.profileRepository.getProfile();

    // Pick a few highlighted skills for indicators without changing data.
    final highlighted = profile.skills.take(6).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Skills',
                style: AppFontStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 900;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: isWide ? 5 : 10,
                        child: GlassContainer(
                          padding: const EdgeInsets.all(16),
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: profile.skills
                                .map(
                                  (s) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.background
                                          .withOpacity(0.7),
                                      border: Border.all(
                                        color: AppColors.primary
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                    child: Text(
                                      s,
                                      style: AppFontStyle(
                                        fontSize: 11,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      if (isWide) const SizedBox(width: 24),
                      if (isWide)
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              for (var i = 0; i < highlighted.length; i++)
                                _SkillMeter(
                                  label: highlighted[i],
                                  // Static percentages purely for UI feel.
                                  value: 0.75 + (0.04 * (i % 3)),
                                  index: i,
                                ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillMeter extends StatelessWidget {
  const _SkillMeter({
    required this.label,
    required this.value,
    required this.index,
  });

  final String label;
  final double value;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: value),
        duration: 600.ms,
        curve: Curves.easeOutCubic,
        builder: (context, animated, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: AppFontStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${(animated * 100).round()}%',
                    style: AppFontStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: animated,
                  minHeight: 6,
                  backgroundColor:
                      AppColors.textSecondary.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.accent,
                  ),
                ),
              ),
            ],
          );
        },
      ).animate().fadeIn(delay: (80 * index).ms),
    );
  }
}

