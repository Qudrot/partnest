import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/core/theme/widgets/custom_button.dart';
import 'package:partnest/features/auth/presentation/pages/dashboard/analysis_state_page.dart';

class SuccessNextStepsPage extends StatefulWidget {
  const SuccessNextStepsPage({super.key});

  @override
  State<SuccessNextStepsPage> createState() => _SuccessNextStepsPageState();
}

class _SuccessNextStepsPageState extends State<SuccessNextStepsPage> {
  int _currentStep = 0; // 0 = validating, 1 = computing, 2 = ready

  @override
  void initState() {
    super.initState();
    _simulateAnalysis();
  }

  void _simulateAnalysis() async {
    // Step 1: Validation
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _currentStep = 1);

    // Step 2: AI Computing
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) setState(() => _currentStep = 2);
  }

  Widget _buildTimelineStep({
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required bool isLast,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.successGreen.withOpacity(0.1)
                    : (isActive
                          ? AppColors.trustBlue.withOpacity(0.1)
                          : AppColors.slate100),
                shape: BoxShape.circle,
              ),
              child: isActive && !isCompleted
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.trustBlue,
                      ),
                    )
                  : Icon(
                      isCompleted ? LucideIcons.checkCircle : icon,
                      size: 16,
                      color: isCompleted
                          ? AppColors.successGreen
                          : (isActive
                                ? AppColors.trustBlue
                                : AppColors.slate400),
                    ),
            ),
            if (!isLast)
              Container(
                height: 48,
                width: 2,
                color: isCompleted
                    ? AppColors.successGreen
                    : AppColors.slate200,
                margin: const EdgeInsets.symmetric(vertical: 4),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.textTheme.bodyLarge?.copyWith(
                  color: isActive || isCompleted
                      ? AppColors.slate900
                      : AppColors.slate400,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: isActive || isCompleted
                      ? AppColors.slate600
                      : AppColors.slate400,
                ),
              ),
              if (!isLast) const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              // Header: Logo
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LucideIcons.hexagon, color: AppColors.trustBlue, size: 32),
                    const SizedBox(width: 8),
                    Text(
                      'PARTNEX',
                      style: AppTypography.textTheme.displayMedium?.copyWith(
                        color: AppColors.trustBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              const Center(
                child: Icon(
                  LucideIcons.checkCircle,
                  color: AppColors.successGreen,
                  size: 80,
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Profile Created Successfully!',
                style: AppTypography.textTheme.displayMedium?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Your financial data has been securely received. We\'re now analyzing your credibility score.',
                style: AppTypography.textTheme.bodyLarge?.copyWith(
                  color: AppColors.slate600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Next Steps Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.neutralWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.slate200),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What Happens Next',
                      style: AppTypography.textTheme.headlineSmall?.copyWith(
                        color: AppColors.slate900,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTimelineStep(
                      title: 'Data Validation',
                      description: 'Your data is being validated',
                      icon: LucideIcons.fileCheck,
                      iconColor: AppColors.slate400,
                      isLast: false,
                      isActive: _currentStep == 0,
                      isCompleted: _currentStep > 0,
                    ),
                    _buildTimelineStep(
                      title: 'AI Analysis',
                      description: 'Our AI is computing your credibility score',
                      icon: LucideIcons.hourglass,
                      iconColor: AppColors.slate400,
                      isLast: false,
                      isActive: _currentStep == 1,
                      isCompleted: _currentStep > 1,
                    ),
                    _buildTimelineStep(
                      title: 'Score Ready',
                      description:
                          'Your score and detailed breakdown will be displayed',
                      icon: LucideIcons.star,
                      iconColor: AppColors.slate400,
                      isLast: true,
                      isActive: _currentStep == 2,
                      isCompleted: _currentStep >= 2,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Bottom Action
              CustomButton(
                text: 'View Your Score',
                variant: ButtonVariant.primary,
                isDisabled: _currentStep < 2,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const AnalysisStatePage()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: Handle Help
                    },
                    child: Text(
                      'Need help?',
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: AppColors.trustBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    ' | ',
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: AppColors.slate400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Contact Support
                    },
                    child: Text(
                      'Contact support',
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: AppColors.trustBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
