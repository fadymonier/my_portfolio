import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/data/repositories/profile_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileRepositoryImpl.profileRepository.getProfile();
    final skills = profile.skills;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tech Stack',
                style: AppFontStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (var i = 0; i < skills.length; i++)
                    _TechChip(label: skills[i]).animate().fadeIn(
                          duration: 350.ms,
                          delay: (50 * i).ms,
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechChip extends StatefulWidget {
  const _TechChip({required this.label});
  final String label;

  @override
  State<_TechChip> createState() => _TechChipState();
}

class _TechChipState extends State<_TechChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: 180.ms,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: _hovered
              ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                )
              : null,
          color: _hovered
              ? null
              : AppColors.background.withOpacity(0.7),
          border: Border.all(
            color: _hovered
                ? Colors.transparent
                : AppColors.primary.withOpacity(0.4),
            width: 1.2,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.5),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.label,
          style: AppFontStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _hovered ? Colors.black : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

