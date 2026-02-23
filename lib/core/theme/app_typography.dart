import 'package:flutter/material.dart';
import 'package:partnest/core/theme/app_colors.dart';

/// Partnex Design System - Typography
/// 
/// This file defines all text styles used throughout the Partnex application.
/// Typography is organized by hierarchy: Display, Heading, Body, Label, and Mono.
/// 
/// Font Families:
/// - DM Sans: Primary UI font (weights: 400, 500, 600, 700)
/// - JetBrains Mono: Data and metrics display (weights: 400, 600, 700)
/// 
/// Design Philosophy:
/// - Clear hierarchy with distinct size and weight combinations
/// - Consistent letter spacing for improved readability
/// - Optimal line heights for different content types
class AppTypography {
  // ═══════════════════════════════════════════════════════════════════════════
  // DISPLAY STYLES - Large, prominent text for hero sections
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Display Large - 48px, Bold, Letter spacing: -0.04em
  /// Usage: Main score displays, hero titles
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 48,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.04,
    height: 1.0,
    color: AppColors.ink900,
  );
  
  /// Display Medium - 40px, Bold, Letter spacing: -0.035em
  /// Usage: Large section titles, score headers
  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 40,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.035,
    height: 1.1,
    color: AppColors.ink900,
  );
  
  /// Display Small - 32px, Bold, Letter spacing: -0.025em
  /// Usage: Card titles, metric displays
  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.025,
    height: 1.2,
    color: AppColors.ink900,
  );
  
  // ═══════════════════════════════════════════════════════════════════════════
  // HEADING STYLES - Section and subsection titles
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Heading 1 - 28px, Bold, Letter spacing: -0.02em
  /// Usage: Page titles, main section headers
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.02,
    height: 1.3,
    color: AppColors.ink900,
  );
  
  /// Heading 2 - 24px, Bold, Letter spacing: -0.015em
  /// Usage: Subsection titles, card headers
  static const TextStyle heading2 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.015,
    height: 1.3,
    color: AppColors.ink900,
  );
  
  /// Heading 3 - 20px, SemiBold, Letter spacing: -0.01em
  /// Usage: Component titles, list headers
  static const TextStyle heading3 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.01,
    height: 1.4,
    color: AppColors.ink900,
  );
  
  /// Heading 4 - 18px, SemiBold, Letter spacing: -0.005em
  /// Usage: Small section headers
  static const TextStyle heading4 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.005,
    height: 1.4,
    color: AppColors.ink900,
  );
  
  // ═══════════════════════════════════════════════════════════════════════════
  // BODY STYLES - Main content text
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Body Large - 16px, Regular, Letter spacing: -0.01em
  /// Usage: Main body text, descriptions
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
    height: 1.5,
    color: AppColors.ink900,
  );
  
  /// Body Large Bold - 16px, SemiBold, Letter spacing: -0.01em
  /// Usage: Emphasized body text
  static const TextStyle bodyLargeBold = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.01,
    height: 1.5,
    color: AppColors.ink900,
  );
  
  /// Body Medium - 15px, Regular, Letter spacing: 0em
  /// Usage: Standard UI text, form labels
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.5,
    color: AppColors.ink900,
  );
  
  /// Body Medium Bold - 15px, SemiBold, Letter spacing: 0em
  /// Usage: Emphasized UI text, button labels
  static const TextStyle bodyMediumBold = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.5,
    color: AppColors.ink900,
  );
  
  /// Body Small - 14px, Regular, Letter spacing: 0.01em
  /// Usage: Secondary text, helper text
  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.01,
    height: 1.5,
    color: AppColors.ink600,
  );
  
  /// Body Small Bold - 14px, SemiBold, Letter spacing: 0.01em
  /// Usage: Emphasized secondary text
  static const TextStyle bodySmallBold = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.01,
    height: 1.5,
    color: AppColors.ink900,
  );
  
  // ═══════════════════════════════════════════════════════════════════════════
  // LABEL STYLES - Captions, badges, and small text
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Label Large - 13px, SemiBold, Letter spacing: 0em
  /// Usage: Card labels, badge text
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.ink900,
  );
  
  /// Label Medium - 12px, SemiBold, Letter spacing: 0.01em
  /// Usage: Tab labels, small badges
  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.01,
    height: 1.4,
    color: AppColors.ink900,
  );
  
  /// Label Small - 11px, SemiBold, Letter spacing: 0.07em
  /// Usage: Uppercase labels, field hints
  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.07,
    height: 1.3,
    color: AppColors.ink400,
  );
  
  /// Label Tiny - 10px, SemiBold, Letter spacing: 0.05em
  /// Usage: Very small labels, step indicators
  static const TextStyle labelTiny = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.05,
    height: 1.2,
    color: AppColors.ink400,
  );
  
  // ═══════════════════════════════════════════════════════════════════════════
  // MONOSPACE STYLES - Data and metrics display
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Mono Large - 13px, SemiBold, Letter spacing: 0em
  /// Usage: Large metric displays, financial data
  static const TextStyle monoLarge = TextStyle(
    fontFamily: 'JetBrains Mono',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.ink900,
  );
  
  /// Mono Medium - 12px, SemiBold, Letter spacing: 0em
  /// Usage: Standard metric displays
  static const TextStyle monoMedium = TextStyle(
    fontFamily: 'JetBrains Mono',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.ink900,
  );
  
  /// Mono Small - 11px, Regular, Letter spacing: 0em
  /// Usage: Small metric values, code snippets
  static const TextStyle monoSmall = TextStyle(
    fontFamily: 'JetBrains Mono',
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.ink600,
  );
  
  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Create a text style with custom color
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
  
  /// Create a text style with custom weight
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
  
  /// Create a text style with custom size
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }
  
  /// Create a text style with custom height
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }
}
