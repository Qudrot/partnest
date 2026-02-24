import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/core/theme/widgets/custom_button.dart';
import 'package:partnest/core/theme/widgets/custom_progress_indicator.dart';
import 'package:partnest/features/auth/presentation/pages/onboarding/success_next_steps_page.dart';

class ReviewConfirmPage extends StatefulWidget {
  const ReviewConfirmPage({super.key});

  @override
  State<ReviewConfirmPage> createState() => _ReviewConfirmPageState();
}

class _ReviewConfirmPageState extends State<ReviewConfirmPage> {
  bool _isConfirmed = false;
  bool _isSubmitting = false;

  void _submitData() async {
    setState(() => _isSubmitting = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SuccessNextStepsPage()),
      );
    }
  }

  Widget _buildSummarySection({
    required String title,
    required Map<String, String> data,
    required VoidCallback onEdit,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.textTheme.headlineSmall?.copyWith(
                  fontSize: 16,
                  color: AppColors.slate900,
                ),
              ),
              InkWell(
                onTap: onEdit,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  child: Text(
                    'Edit',
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: AppColors.trustBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...data.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: AppTypography.textTheme.labelMedium?.copyWith(
                      color: AppColors.slate600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.value,
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: AppColors.slate900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: AppColors.slate900),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              child: Column(
                children: [
                  Text(
                    'Review Your Information',
                    style: AppTypography.textTheme.displayMedium?.copyWith(
                      fontSize: 24,
                      color: AppColors.slate900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProgressIndicatorWidget(progress: 0.80),
                  const SizedBox(height: 8),
                  Text(
                    'Step 4 of 5',
                    style: AppTypography.textTheme.bodySmall?.copyWith(
                      color: AppColors.slate600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildSummarySection(
                      title: 'Business Profile',
                      data: {
                        'Business Name': 'Acme Manufacturing',
                        'Industry': 'Manufacturing',
                        'Location': 'Lagos, Nigeria',
                        'Years of Operation': '5',
                        'Employees': '25',
                      },
                      onEdit: () {
                        // TODO: Navigate to Edit Business Profile
                        Navigator.popUntil(
                          context,
                          (route) =>
                              route.settings.name == '/business_profile' ||
                              route.isFirst,
                        );
                      },
                    ),

                    _buildSummarySection(
                      title: 'Revenue & Expenses',
                      data: {
                        'Annual Revenue (Year 1)': '₦500,000',
                        'Annual Revenue (Year 2)': '₦600,000',
                        'Annual Revenue (Year 3)': '₦750,000',
                        'Monthly Revenue': '₦50,000',
                        'Monthly Expenses': '₦30,000',
                      },
                      onEdit: () {
                        // TODO: Navigate to Edit Revenue
                      },
                    ),

                    _buildSummarySection(
                      title: 'Liabilities & History',
                      data: {
                        'Existing Liabilities': '₦200,000',
                        'Liability Type': 'Bank Loans',
                        'Prior Funding': 'Yes',
                        'Prior Funding Amount': '₦100,000',
                        'Funding Source': 'Venture Capital',
                        'Funding Year': '2022',
                        'Defaulted': 'No',
                        'Payment Timeliness': 'Always on time',
                      },
                      onEdit: () {
                        // TODO: Navigate to Edit Hub
                      },
                    ),

                    const SizedBox(height: 24),

                    // Confirmation Checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _isConfirmed,
                            onChanged: (val) {
                              setState(() => _isConfirmed = val ?? false);
                            },
                            activeColor: AppColors.trustBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: const BorderSide(color: AppColors.slate400),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _isConfirmed = !_isConfirmed),
                            child: Text(
                              'I confirm this information is accurate and complete',
                              style: AppTypography.textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.slate900),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Previous',
                      variant: ButtonVariant.secondary,
                      isDisabled: _isSubmitting,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Submit & Generate Score',
                      variant: ButtonVariant.primary,
                      isDisabled: !_isConfirmed || _isSubmitting,
                      isLoading: _isSubmitting,
                      onPressed: _submitData,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
