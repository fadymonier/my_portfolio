import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/utils/url_launcher_helper.dart';
import 'package:fady_portfolio/core/widgets/glass_container.dart';
import 'package:fady_portfolio/data/repositories/profile_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  String _getButtonLabel(String url) {
    if (url.contains('play.google.com')) return 'Play Store';
    if (url.contains('github.com')) return 'GitHub';
    return 'View';
  }

  @override
  Widget build(BuildContext context) {
    final profile = ProfileRepositoryImpl.profileRepository.getProfile();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Featured Projects',
                style: AppFontStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cols = constraints.maxWidth >= 1200
                      ? 3
                      : constraints.maxWidth >= 800
                      ? 2
                      : 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 440,
                    ),
                    itemCount: profile.projects.length,
                    itemBuilder: (context, index) {
                      final p = profile.projects[index];
                      return _ProjectCard(
                        title: p.title,
                        subtitle: p.subtitle,
                        image: p.image,
                        link: p.link,
                        buttonLabel: _getButtonLabel(p.link),
                        index: index,
                      );
                    },
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

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.link,
    required this.buttonLabel,
    required this.index,
  });

  final String title;
  final String subtitle;
  final String image;
  final String link;
  final String buttonLabel;
  final int index;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final card = MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchExternalUrl(widget.link),
        child: AnimatedScale(
          duration: 180.ms,
          scale: _hovered ? 1.03 : 1.0,
          curve: Curves.easeOutCubic,
          child: GlassContainer(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 260,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: const EdgeInsets.all(24),
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                InteractiveViewer(
                                  maxScale: 5.0,
                                  child: Image.asset(
                                    widget.image,
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                                Positioned(
                                  top: -16,
                                  right: -16,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            widget.image,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                          ),
                          AnimatedOpacity(
                            duration: 180.ms,
                            opacity: _hovered ? 0.3 : 0.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [AppColors.primary, AppColors.accent],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        widget.title,
                        style: AppFontStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.accent,
                          ),
                          onPressed: () => launchExternalUrl(widget.link),
                          icon: const Icon(Icons.link),
                          label: Text(
                            widget.buttonLabel,
                            style: AppFontStyle(color: AppColors.accent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return card
        .animate()
        .fadeIn(duration: 450.ms, delay: (80 * widget.index).ms)
        .moveY(begin: 20, end: 0, curve: Curves.easeOutCubic);
  }
}
