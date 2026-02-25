import 'package:flutter/material.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/features/auth/presentation/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // 2s cycle
      vsync: this,
    )..repeat(reverse: true);

    // Pulse animation (2-3px scale change on a 64px logo means ~1.0 to 1.05 scale)
    _animation = Tween<double>(begin: 1.0, end: 1.04).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // 2-3 seconds before automatically transitioning to the login screen
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralWhite,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Tap anywhere to skip
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 200),
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'assets/images/favicon_1.png',
                  height: 64,
                  width: 64,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: AppColors.trustBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'P',
                          style: AppTypography.textTheme.displayMedium?.copyWith(
                            color: AppColors.neutralWhite,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Optional Tagline
              Text(
                'Unlock SME Credibility',
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: AppColors.slate600,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
