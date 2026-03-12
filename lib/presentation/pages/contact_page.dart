import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/utils/app_images.dart';
import 'package:fady_portfolio/core/utils/url_launcher_helper.dart';
import 'package:fady_portfolio/core/widgets/glass_container.dart';
import 'package:fady_portfolio/data/repositories/profile_repository_impl.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileRepositoryImpl.profileRepository.getProfile();
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: GlassContainer(
            padding: const EdgeInsets.all(24),
            borderRadius: 20,
            blurSigma: 15,
            margin: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImages.contactMe,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 22),
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
                      icon: Image.asset(
                        AppImages.email,
                        width: 22,
                        height: 22,
                      ),
                      label: Text(
                        'Email',
                        style: AppFontStyle(fontSize: 14),
                      ),
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
                      icon: Image.asset(
                        AppImages.call,
                        width: 22,
                        height: 22,
                      ),
                      label: Text(
                        'Call',
                        style: AppFontStyle(fontSize: 14),
                      ),
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
          ),
        ),
      ),
    );
  }
}
