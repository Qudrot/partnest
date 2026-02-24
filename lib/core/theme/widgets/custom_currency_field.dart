import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';

class CustomCurrencyField extends StatelessWidget {
  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final String? errorText;
  final String? warningText;
  final String prefixText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomCurrencyField({
    super.key,
    required this.label,
    this.placeholder,
    this.controller,
    this.errorText,
    this.warningText,
    this.prefixText = '₦',
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.textTheme.labelLarge),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          onChanged: onChanged,
          validator: validator,
          textAlign: TextAlign.right,
          style: AppTypography.textTheme.bodyLarge?.copyWith(
            color: AppColors.slate900,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: AppTypography.textTheme.bodyLarge?.copyWith(
              color: AppColors.slate400,
            ),
            prefixText: prefixText,
            prefixStyle: AppTypography.textTheme.bodyLarge?.copyWith(
              color: AppColors.slate600,
            ),
            errorText: errorText,
            errorStyle: AppTypography.textTheme.bodySmall?.copyWith(
              color: AppColors.dangerRed,
            ),
            filled: true,
            fillColor: AppColors.slate100,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.slate200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.slate200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: AppColors.trustBlue,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: AppColors.dangerRed,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: AppColors.dangerRed,
                width: 2,
              ),
            ),
          ),
        ),
        if (warningText != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.error_outline,
                color: AppColors.warningAmber,
                size: 16,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  warningText!,
                  style: AppTypography.textTheme.bodySmall?.copyWith(
                    color: AppColors.warningAmber,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
