import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/core/theme/widgets/custom_button.dart';
import 'package:partnest/core/theme/widgets/custom_currency_field.dart';
import 'package:partnest/core/theme/widgets/custom_dropdown_field.dart';
import 'package:partnest/core/theme/widgets/custom_input_field.dart';
import 'package:partnest/core/theme/widgets/custom_progress_indicator.dart';
import 'package:partnest/core/theme/widgets/custom_yes_no_field.dart';
import 'package:partnest/features/auth/presentation/pages/onboarding/review_confirm_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partnest/features/auth/presentation/blocs/sme_profile_cubit/sme_profile_cubit.dart';

class LiabilitiesHistoryPage extends StatefulWidget {
  const LiabilitiesHistoryPage({super.key});

  @override
  State<LiabilitiesHistoryPage> createState() => _LiabilitiesHistoryPageState();
}

class _LiabilitiesHistoryPageState extends State<LiabilitiesHistoryPage> {
  final _formKey = GlobalKey<FormState>();

  final _liabilitiesController = TextEditingController();
  String? _liabilityType;

  bool? _hasPriorFunding;
  final _fundingAmountController = TextEditingController();
  String? _fundingSource;
  final _fundingYearController = TextEditingController();

  bool? _hasDefaulted;
  final _defaultDetailsController = TextEditingController();
  String? _paymentTimeliness;

  final List<String> _liabilityTypes = [
    'Bank Loans',
    'Supplier Credit',
    'Lease Obligations',
    'Personal Loans',
    'Other',
  ];

  final List<String> _fundingSources = [
    'Angel Investors',
    'Venture Capital',
    'Bank Loan',
    'Government Grant',
    'Family/Friends',
    'Other',
  ];

  final List<String> _paymentTimelinessOptions = [
    'Always on time',
    'Mostly on time (1-2 late payments/year)',
    'Occasionally late (3-5 late payments/year)',
    'Frequently late (6+ late payments/year)',
  ];

  bool get _validateLiabilities {
    final l = double.tryParse(_liabilitiesController.text.replaceAll(',', ''));
    if (l == null) return false;
    if (l > 0 && _liabilityType == null) return false;
    return true;
  }

  bool get _validateFunding {
    if (_hasPriorFunding == null) return false;
    if (_hasPriorFunding == true) {
      if (_fundingAmountController.text.isEmpty) return false;
      if (_fundingSource == null) return false;
      if (_fundingYearController.text.isEmpty) return false;
    }
    return true;
  }

  bool get _validateHistory {
    if (_hasDefaulted == null) return false;
    if (_hasDefaulted == true && _defaultDetailsController.text.length < 10)
      return false;
    if (_paymentTimeliness == null) return false;
    return true;
  }

  bool get _isFormValid {
    return _validateLiabilities && _validateFunding && _validateHistory;
  }

  void _onFieldChanged(String value) {
    setState(() {});
  }

  @override
  void dispose() {
    _liabilitiesController.dispose();
    _fundingAmountController.dispose();
    _fundingYearController.dispose();
    _defaultDetailsController.dispose();
    super.dispose();
  }

  Widget _buildConditionalField(Widget child, bool isVisible) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: isVisible
          ? Container(
              margin: const EdgeInsets.only(top: 20, left: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.slate50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.slate200),
              ),
              child: child,
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final liabilitiesVal = double.tryParse(_liabilitiesController.text.replaceAll(',', '')) ?? 0;
    final showLiabilityType = liabilitiesVal > 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: AppColors.slate900),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Liabilities & History',
          style: AppTypography.textTheme.headlineMedium,
        ),
        centerTitle: true,
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
                  ProgressIndicatorWidget(progress: 0.60),
                  const SizedBox(height: 8),
                  Text(
                    'Step 3 of 5',
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
                        'Existing Liabilities',
                        style: AppTypography.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Include all outstanding debts (loans, credit lines, lease obligations).',
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      CustomCurrencyField(
                        label: 'Total Existing Liabilities',
                        placeholder: 'e.g., 200,000',
                        controller: _liabilitiesController,
                        onChanged: _onFieldChanged,
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Required';
                          final num = double.tryParse(val.replaceAll(',', ''));
                          if (num == null || num < 0)
                            return 'Must be a positive number';
                          if (num > 1000000000) return 'Max 1 billion';
                          return null;
                        },
                      ),

                      _buildConditionalField(
                        CustomDropdownField(
                          label: 'Liability Type',
                          placeholder: 'Select type...',
                          value: _liabilityType,
                          items: _liabilityTypes,
                          onChanged: (val) {
                            setState(() => _liabilityType = val);
                          },
                          errorText:
                              (showLiabilityType &&
                                  _liabilityType == null &&
                                  _liabilitiesController.text.isNotEmpty)
                              ? 'Required'
                              : null,
                        ),
                        showLiabilityType,
                      ),
                      const SizedBox(height: 32),

                      // Section B
                      Text(
                        'Prior Funding History',
                        style: AppTypography.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Prior funding demonstrates investment confidence and capital access.',
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      CustomYesNoField(
                        label: 'Has Received Prior Funding?',
                        value: _hasPriorFunding,
                        onChanged: (val) {
                          setState(() => _hasPriorFunding = val);
                        },
                      ),

                      _buildConditionalField(
                        Column(
                          children: [
                            CustomCurrencyField(
                              label: 'Prior Funding Amount',
                              placeholder: 'e.g., 100,000',
                              controller: _fundingAmountController,
                              onChanged: _onFieldChanged,
                              validator: (val) {
                                if (_hasPriorFunding == true) {
                                  if (val == null || val.isEmpty)
                                    return 'Required';
                                  final num = double.tryParse(val.replaceAll(',', ''));
                                  if (num == null || num <= 0)
                                    return 'Must be a positive number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomDropdownField(
                              label: 'Prior Funding Source',
                              placeholder: 'Select source...',
                              value: _fundingSource,
                              items: _fundingSources,
                              onChanged: (val) =>
                                  setState(() => _fundingSource = val),
                              errorText:
                                  (_hasPriorFunding == true &&
                                      _fundingSource == null)
                                  ? 'Required'
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            CustomInputField(
                              label: 'Funding Year',
                              placeholder: 'e.g., 2022',
                              controller: _fundingYearController,
                              onChanged: _onFieldChanged,
                              validator: (val) {
                                if (_hasPriorFunding == true) {
                                  if (val == null || val.isEmpty)
                                    return 'Required';
                                  final num = int.tryParse(val);
                                  if (num == null || num < 2000 || num > 2026)
                                    return 'Must be between 2000 and 2026';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        _hasPriorFunding == true,
                      ),
                      const SizedBox(height: 32),

                      // Section C
                      Text(
                        'Repayment Behavior',
                        style: AppTypography.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This helps us assess your reliability in meeting financial obligations.',
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      CustomYesNoField(
                        label: 'Have You Defaulted on Any Obligations?',
                        value: _hasDefaulted,
                        onChanged: (val) {
                          setState(() => _hasDefaulted = val);
                        },
                      ),

                      _buildConditionalField(
                        CustomInputField(
                          label: 'Default Details',
                          placeholder: 'Briefly describe (min 10 chars)...',
                          controller: _defaultDetailsController,
                          onChanged: _onFieldChanged,
                          maxLines: 4,
                          validator: (val) {
                            if (_hasDefaulted == true) {
                              if (val == null || val.length < 10)
                                return 'Please provide more details (min 10 chars)';
                              if (val.length > 500) return 'Max 500 chars';
                            }
                            return null;
                          },
                        ),
                        _hasDefaulted == true,
                      ),
                      const SizedBox(height: 20),

                      CustomDropdownField(
                        label: 'Payment Timeliness',
                        placeholder: 'Select...',
                        value: _paymentTimeliness,
                        items: _paymentTimelinessOptions,
                        onChanged: (val) =>
                            setState(() => _paymentTimeliness = val),
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
                          context.read<SmeProfileCubit>().updateLiabilitiesHistory(
                            existingLiabilities: double.parse(_liabilitiesController.text.replaceAll(',', '')),
                            liabilityType: _liabilityType,
                            hasPriorFunding: _hasPriorFunding,
                            priorFundingAmount: _fundingAmountController.text.isEmpty ? null : double.parse(_fundingAmountController.text.replaceAll(',', '')),
                            priorFundingSource: _fundingSource,
                            fundingYear: _fundingYearController.text.isEmpty ? null : int.parse(_fundingYearController.text),
                            hasDefaulted: _hasDefaulted,
                            defaultDetails: _defaultDetailsController.text.isEmpty ? null : _defaultDetailsController.text,
                            paymentTimeliness: _paymentTimeliness,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ReviewConfirmPage(),
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
