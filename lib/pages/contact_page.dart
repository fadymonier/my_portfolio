import 'dart:ui';

import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/my_data.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _openUrl(String url) async {
    final u = Uri.parse(url);
    if (await canLaunchUrl(u)) {
      await launchUrl(u, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _email() async {
    final uri = Uri(
      scheme: 'mailto',
      path: ProfileData.email,
      query: 'subject=Contact from portfolio',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _phone() async {
    final uri = Uri(scheme: 'tel', path: ProfileData.phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _glassContainer({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
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
        constraints: const BoxConstraints(maxWidth: 700),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _glassContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImages.contactMe,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                // const SizedBox(height: 16),
                // Text(
                //   'Get in Touch',
                //   style: AppFontStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w600,
                //     color: AppColors.textPrimary,
                //   ),
                // ),
                // const SizedBox(height: 12),
                // const Text(
                //   '${ProfileData.location} • ${ProfileData.phone} • ${ProfileData.email}',
                //   textAlign: TextAlign.center,
                //   style: AppFontStyle(color: AppColors.textSecondary),
                // ),
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
                      onPressed: _email,
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
                      onPressed: _phone,
                      icon: Image.asset(AppImages.call, width: 22, height: 22),
                      label: Text('Call', style: AppFontStyle(fontSize: 14)),
                    ),
                    ...ProfileData.socials.map(
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
                        onPressed: () => _openUrl(s['url']!),
                        icon: Image.asset(s['icon']!, width: 22, height: 22),
                        label: Text(
                          s['label']!,
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
