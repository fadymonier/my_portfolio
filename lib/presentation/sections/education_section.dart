import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/widgets/glass_container.dart';
import 'package:fady_portfolio/data/repositories/profile_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileRepositoryImpl.profileRepository.getProfile();
    final educationList = profile.education;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Education',
                style: AppFontStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 900;
                  return Column(
                    children: [
                      for (var i = 0; i < educationList.length; i++)
                        _TimelineItem(
                          education: educationList[i],
                          index: i,
                          isWide: isWide,
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

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.education,
    required this.index,
    required this.isWide,
  });

  final dynamic education;
  final int index;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final isLeft = isWide && index.isEven;

    final card = GlassContainer(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            education.title,
            style: AppFontStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            education.org,
            style: AppFontStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            education.period,
            style: AppFontStyle(
              fontSize: 12,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 450.ms, delay: (100 * index).ms)
        .moveX(
          begin: isWide ? (isLeft ? -24 : 24) : 0,
          end: 0,
          curve: Curves.easeOutCubic,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            if (isWide) Expanded(flex: 5, child: isLeft ? card : const SizedBox()),
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  Container(
                    width: 2,
                    height: 16,
                    color: AppColors.textSecondary.withOpacity(0.4),
                  ),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accent,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.6),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppColors.textSecondary.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
            if (isWide)
              Expanded(flex: 5, child: isLeft ? const SizedBox() : card)
            else
              Expanded(flex: 5, child: card),
          ],
        ),
      ),
    );
  }
}
