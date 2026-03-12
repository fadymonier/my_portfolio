import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/utils/url_launcher_helper.dart';
import 'package:fady_portfolio/core/widgets/glass_container.dart';
import 'package:fady_portfolio/data/repositories/profile_repository_impl.dart';
import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  String _getButtonLabel(String url) {
    if (url.contains('play.google.com')) return 'Play Store';
    if (url.contains('github.com')) return 'GitHub';
    return 'View';
  }

  @override
  Widget build(BuildContext context) {
    final profile = ProfileRepositoryImpl.profileRepository.getProfile();
    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth >= 1200 ? 3 : c.maxWidth >= 800 ? 2 : 1;

        return GridView.builder(
          padding: const EdgeInsets.all(24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 2.1,
          ),
          itemCount: profile.projects.length,
          itemBuilder: (context, i) {
            final p = profile.projects[i];
            return TweenAnimationBuilder(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              tween: Tween<double>(begin: 0.8, end: 1),
              builder: (context, scale, child) {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => launchExternalUrl(p.link),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: scale,
                      child: GlassContainer(
                        margin: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.title,
                                      style: AppFontStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      p.subtitle,
                                      style: AppFontStyle(
                                        color: AppColors.textSecondary,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: TextButton.icon(
                                        style: TextButton.styleFrom(
                                          foregroundColor: AppColors.accent,
                                        ),
                                        onPressed: () =>
                                            launchExternalUrl(p.link),
                                        icon: const Icon(Icons.link),
                                        label: Text(
                                          _getButtonLabel(p.link),
                                          style: AppFontStyle(
                                            color: AppColors.accent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                                child: SizedBox.expand(
                                  child: Image.asset(
                                    p.image,
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
