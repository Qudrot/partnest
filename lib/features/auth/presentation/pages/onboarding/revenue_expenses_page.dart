import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/core/theme/widgets/custom_button.dart';
import 'package:partnest/core/theme/widgets/custom_currency_field.dart';
import 'package:partnest/core/theme/widgets/custom_progress_indicator.dart';
import 'package:partnest/features/auth/presentation/pages/onboarding/liabilities_history_page.dart';

class RevenueExpensesPage extends StatefulWidget {
  const RevenueExpensesPage({super.key});

  @override
  State<RevenueExpensesPage> createState() => _RevenueExpensesPageState();
}

class _RevenueExpensesPageState extends State<RevenueExpensesPage> {
  final _formKey = GlobalKey<FormState>();

  final _year1Controller = TextEditingController();
  final _year2Controller = TextEditingController();
  final _year3Controller = TextEditingController();

  final _monthlyRevController = TextEditingController();
  final _monthlyExpController = TextEditingController();

  bool get _isFormValid {
    return _year1Controller.text.isNotEmpty &&
        _year2Controller.text.isNotEmpty &&
        _monthlyRevController.text.isNotEmpty &&
        _monthlyExpController.text.isNotEmpty;
  }

  String? _expenseWarning;

  void _onFieldChanged(String value) {
    if (_monthlyRevController.text.isNotEmpty &&
        _monthlyExpController.text.isNotEmpty) {
      final rev = double.tryParse(_monthlyRevController.text);
      final exp = double.tryParse(_monthlyExpController.text);
      if (rev != null && exp != null && exp > rev) {
        _expenseWarning =
            'Your expenses exceed revenue. Please review your figures.';
      } else {
        _expenseWarning = null;
      }
    } else {
      _expenseWarning = null;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _year1Controller.dispose();
    _year2Controller.dispose();
    _year3Controller.dispose();
    _monthlyRevController.dispose();
    _monthlyExpController.dispose();
    super.dispose();
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
        title: Text(
          'Revenue & Expenses',
          style: AppTypography.textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              child: Column(
                children: [
                  ProgressIndicatorWidget(progress: 0.40),
                  const SizedBox(height: 8),
                  Text(
                    'Step 2 of 5',
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section A
                      Text(
                        'Annual Revenue (Past 2-3 Years)',
                        style: AppTypography.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter revenue for the past 2-3 years. This helps us assess growth trends.',
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      CustomCurrencyField(
                        label: 'Year 1 Annual Revenue',
                        placeholder: 'e.g., 500,000',
                        controller: _year1Controller,
                        onChanged: _onFieldChanged,
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Required';
                          final num = double.tryParse(val);
                          if (num == null || num < 0)
                            return 'Must be a positive number';
                          if (num > 1000000000) return 'Max 1 billion';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomCurrencyField(
                        label: 'Year 2 Annual Revenue',
                        placeholder: 'e.g., 600,000',
                        controller: _year2Controller,
                        onChanged: _onFieldChanged,
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Required';
                          final num = double.tryParse(val);
                          if (num == null || num < 0)
                            return 'Must be a positive number';
                          if (num > 1000000000) return 'Max 1 billion';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomCurrencyField(
                        label: 'Year 3 Annual Revenue (Optional)',
                        placeholder: 'e.g., 750,000',
                        controller: _year3Controller,
                        onChanged: _onFieldChanged,
                        validator: (val) {
                          if (val != null && val.isNotEmpty) {
                            final num = double.tryParse(val);
                            if (num == null || num < 0)
                              return 'Must be a positive number';
                            if (num > 1000000000) return 'Max 1 billion';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // Section B
                      Text(
                        'Monthly Financials (Current Year)',
                        style: AppTypography.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter average monthly figures for the current year.',
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      CustomCurrencyField(
                        label: 'Monthly Revenue (Average)',
                        placeholder: 'e.g., 50,000',
                        controller: _monthlyRevController,
                        onChanged: _onFieldChanged,
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Required';
                          final num = double.tryParse(val);
                          if (num == null || num < 0)
                            return 'Must be a positive number';
                          if (num > 100000000) return 'Max 100 million';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomCurrencyField(
                        label: 'Monthly Expenses (Average)',
                        placeholder: 'e.g., 30,000',
                        controller: _monthlyExpController,
                        onChanged: _onFieldChanged,
                        warningText: _expenseWarning,
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Required';
                          final num = double.tryParse(val);
                          if (num == null || num < 0)
                            return 'Must be a positive number';
                          if (num > 100000000) return 'Max 100 million';
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
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
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Next',
                      variant: ButtonVariant.primary,
                      isDisabled: !_isFormValid,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LiabilitiesHistoryPage(),
                            ),
                          );
                        }
                      },
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
