import 'package:fady_portfolio/core/extensions/extensions.dart';
import 'package:fady_portfolio/core/widgets/gradient_bg.dart';
import 'package:fady_portfolio/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/utils/app_colors.dart';
import 'pages/about_page.dart';
import 'pages/contact_page.dart';
import 'pages/home_page.dart';
import 'pages/projects_page.dart';

void main() => runApp(const RootApp());

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: const ColorScheme.dark(
        background: AppColors.background,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'Fady Monier Portfolio',
      theme: base,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class MyPortfolioApp extends StatefulWidget {
  const MyPortfolioApp({super.key});
  @override
  State<MyPortfolioApp> createState() => _MyPortfolioAppState();
}

class _MyPortfolioAppState extends State<MyPortfolioApp> {
  int _index = 0;
  final _pages = const [HomePage(), AboutPage(), ProjectsPage(), ContactPage()];

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              color: Colors.black.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _navItem('Home', 0),
                  const SizedBox(width: 20),
                  _navItem('About', 1),
                  const SizedBox(width: 20),
                  _navItem('Projects', 2),
                  const SizedBox(width: 20),
                  _navItem('Contact', 3),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  final offsetAnimation =
                      Tween<Offset>(
                        begin: const Offset(0.1, 0), // slide من اليمين
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      );

                  final fadeAnimation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  );

                  return SlideTransition(
                    position: offsetAnimation,
                    child: FadeTransition(opacity: fadeAnimation, child: child),
                  );
                },
                child: _pages[_index],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String label, int i) {
    final selected = _index == i;
    return InkWell(
      onTap: () => setState(() => _index = i),
      child: Text(
        label,
        style: AppFontStyle(
          fontSize: 18,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? AppColors.accent : AppColors.textSecondary,
        ),
      ),
    );
  }
}
