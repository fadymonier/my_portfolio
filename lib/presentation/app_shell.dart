import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/utils/app_colors.dart';
import 'package:fady_portfolio/core/widgets/gradient_bg.dart';
import 'package:fady_portfolio/presentation/sections/about_section.dart';
import 'package:fady_portfolio/presentation/sections/contact_section.dart';
import 'package:fady_portfolio/presentation/sections/education_section.dart';
import 'package:fady_portfolio/presentation/sections/experience_section.dart';
import 'package:fady_portfolio/presentation/sections/footer_section.dart';
import 'package:fady_portfolio/presentation/sections/hero_section.dart';
import 'package:fady_portfolio/presentation/sections/projects_section.dart';
import 'package:fady_portfolio/presentation/sections/skills_section.dart';
import 'package:fady_portfolio/presentation/sections/tech_stack_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _scrollController = ScrollController();

  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _techKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _contactKey = GlobalKey();

  int _activeIndex = 0;

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: 600.ms,
      curve: Curves.easeInOutCubic,
      alignment: 0.1,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    
    // If scrolled to the very bottom, activate the last section
    if (currentScroll >= maxScroll - 20) {
      if (_activeIndex != 7) {
        setState(() => _activeIndex = 7);
      }
      return;
    }

    final keys = [
      _heroKey,
      _aboutKey,
      _techKey,
      _projectsKey,
      _experienceKey,
      _educationKey,
      _skillsKey,
      _contactKey,
    ];

    for (int i = keys.length - 1; i >= 0; i--) {
      final ctx = keys[i].currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          final position = box.localToGlobal(Offset.zero).dy;
          // 120 offset to account for the sticky nav bar (74px) plus some threshold margin
          if (position <= 120) {
            if (_activeIndex != i) {
              setState(() => _activeIndex = i);
            }
            return;
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: 74,
              flexibleSpace: _TopNavBar(
                activeIndex: _activeIndex,
                onTapItem: (i) {
                  setState(() => _activeIndex = i);
                  switch (i) {
                    case 0:
                      _scrollTo(_heroKey);
                      break;
                    case 1:
                      _scrollTo(_aboutKey);
                      break;
                    case 2:
                      _scrollTo(_techKey);
                      break;
                    case 3:
                      _scrollTo(_projectsKey);
                      break;
                    case 4:
                      _scrollTo(_experienceKey);
                      break;
                    case 5:
                      _scrollTo(_educationKey);
                      break;
                    case 6:
                      _scrollTo(_skillsKey);
                      break;
                    case 7:
                      _scrollTo(_contactKey);
                      break;
                  }
                },
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                _SectionAnchor(key: _heroKey, child: const HeroSection()),
                _SectionAnchor(key: _aboutKey, child: const AboutSection()),
                _SectionAnchor(
                  key: _techKey,
                  child: const TechStackSection(),
                ),
                _SectionAnchor(
                  key: _projectsKey,
                  child: const ProjectsSection(),
                ),
                _SectionAnchor(
                  key: _experienceKey,
                  child: const ExperienceSection(),
                ),
                _SectionAnchor(
                  key: _educationKey,
                  child: const EducationSection(),
                ),
                _SectionAnchor(
                  key: _skillsKey,
                  child: const SkillsSection(),
                ),
                _SectionAnchor(
                  key: _contactKey,
                  child: const ContactSection(),
                ),
                const FooterSection(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopNavBar extends StatelessWidget {
  const _TopNavBar({required this.activeIndex, required this.onTapItem});

  final int activeIndex;
  final ValueChanged<int> onTapItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.15),
        border: Border(
          bottom: BorderSide(color: AppColors.textSecondary.withOpacity(0.2)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              Text(
                'Fady Monier Fouad',
                style: AppFontStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ).animate().fadeIn(duration: 400.ms),
              const Spacer(),
              Wrap(
                spacing: 18,
                children: [
                  _NavItem(
                    label: 'Home',
                    index: 0,
                    activeIndex: activeIndex,
                    onTap: onTapItem,
                  ),
                  _NavItem(
                    label: 'About',
                    index: 1,
                    activeIndex: activeIndex,
                    onTap: onTapItem,
                  ),
                  _NavItem(
                    label: 'Tech Stack',
                    index: 2,
                    activeIndex: activeIndex,
                    onTap: onTapItem,
                  ),
                  _NavItem(
                    label: 'Projects',
                    index: 3,
                    activeIndex: activeIndex,
                    onTap: onTapItem,
                  ),
                  _NavItem(
                    label: 'Experience',
                    index: 4,
                    activeIndex: activeIndex,
                    onTap: onTapItem,
                  ),
                  _NavItem(
                    label: 'Education',
                    index: 5,
                    activeIndex: activeIndex,
                    onTap: onTapItem,
                  ),
                  _NavItem(
                    label: 'Skills',
                    index: 6,
                    activeIndex: activeIndex,
                    onTap: onTapItem,
                  ),
                  _NavItem(
                    label: 'Contact',
                    index: 7,
                    activeIndex: activeIndex,
                    onTap: onTapItem,
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

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.label,
    required this.index,
    required this.activeIndex,
    required this.onTap,
  });

  final String label;
  final int index;
  final int activeIndex;
  final ValueChanged<int> onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.activeIndex == widget.index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onTap(widget.index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: AppFontStyle(
                fontSize: 14,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                color: selected || _hovered
                    ? AppColors.accent
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: 180.ms,
              curve: Curves.easeOutCubic,
              height: 2,
              width: selected || _hovered ? 22 : 0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionAnchor extends StatelessWidget {
  const _SectionAnchor({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
