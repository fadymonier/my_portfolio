import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/utils/app_images.dart';
import 'package:fady_portfolio/core/utils/url_launcher_helper.dart';
import 'package:fady_portfolio/core/widgets/glass_container.dart';
import 'package:fady_portfolio/data/repositories/profile_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileRepositoryImpl.profileRepository.getProfile();

    final card = GlassContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: 20,
      blurSigma: 18,
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImages.contactMe,
            width: 180,
            height: 180,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 18),
          Text(
            'Let\'s work together',
            style: AppFontStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Open to freelance, full-time, and remote Flutter opportunities.',
            textAlign: TextAlign.center,
            style: AppFontStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  side: BorderSide(
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  foregroundColor: AppColors.textPrimary,
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
                onPressed: () => launchMailto(
                  profile.email,
                  subject: 'Contact from portfolio',
                ),
                icon: Image.asset(AppImages.email, width: 22, height: 22),
                label: Text('Email', style: AppFontStyle(fontSize: 14)),
              ),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  side: BorderSide(
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  foregroundColor: AppColors.textPrimary,
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
                onPressed: () => launchTel(profile.phone),
                icon: Image.asset(AppImages.call, width: 22, height: 22),
                label: Text('Call', style: AppFontStyle(fontSize: 14)),
              ),
              ...profile.socials.map(
                (s) => FilledButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppColors.textSecondary.withOpacity(0.5),
                    ),
                    foregroundColor: AppColors.textPrimary,
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () => launchExternalUrl(s.url),
                  icon: Image.asset(s.icon, width: 22, height: 22),
                  label: Text(
                    s.label,
                    style: AppFontStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .moveY(begin: 20, end: 0, curve: Curves.easeOutCubic);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: card,
        ),
      ),
    );
  }
}

