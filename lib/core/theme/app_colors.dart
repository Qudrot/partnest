import 'package:flutter/material.dart';

/// Partnex Design System - Color Palette
/// 
/// This file defines all colors used throughout the Partnex application.
/// Colors are organized by category: Brand, Ink Scale, Status, and Semantic.
/// 
/// Design Philosophy:
/// - Primary brand color: #1B4FFF (Partnex Blue)
/// - Neutral scale: Ink 900-000 for typography and backgrounds
/// - Status colors: Always paired with icons for accessibility
/// - Semantic colors: Contextual meaning for actions and states
class AppColors {
  // ═══════════════════════════════════════════════════════════════════════════
  // BRAND COLORS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Primary brand color - Partnex Blue
  static const Color brand = Color(0xFF1B4FFF);
  
  /// Mid-tone brand color for hover/active states
  static const Color brandMid = Color(0xFF2B5BFF);
  
  /// Light brand color for backgrounds and containers
  static const Color brandLt = Color(0xFFEEF2FF);
  
  /// Dimmed brand color with transparency for subtle overlays
  static const Color brandDim = Color(0x1F1B4FFF); // rgba(27,79,255,0.12)
  
  // ═══════════════════════════════════════════════════════════════════════════
  // INK SCALE - Neutral Colors for Typography & Backgrounds
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Darkest ink - Primary text on light backgrounds
  static const Color ink900 = Color(0xFF0D0F14);
  
  /// Dark ink - Secondary text and dark backgrounds
  static const Color ink800 = Color(0xFF1A1D26);
  
  /// Medium-dark ink - Tertiary text
  static const Color ink700 = Color(0xFF2A2D38);
  
  /// Medium ink - Disabled text and subtle elements
  static const Color ink600 = Color(0xFF4A5060);
  
  /// Light-medium ink - Placeholder text
  static const Color ink400 = Color(0xFF8A8FA0);
  
  /// Light ink - Secondary labels and borders
  static const Color ink300 = Color(0xFFC2C7D4);
  
  /// Very light ink - Subtle borders
  static const Color ink200 = Color(0xFFE2E5EE);
  
  /// Extra light ink - Dividers and light backgrounds
  static const Color ink150 = Color(0xFFECEEF4);
  
  /// Almost white - Light backgrounds
  static const Color ink100 = Color(0xFFF0F1F5);
  
  /// Pure white - Primary background
  static const Color ink000 = Color(0xFFFFFFFF);
  
  // ═══════════════════════════════════════════════════════════════════════════
  // STATUS COLORS - Semantic Meaning with Icon Pairing
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Success/Positive status - Green
  /// Paired with: ✓ check icon
  static const Color positive = Color(0xFF0A8A55);
  
  /// Light positive background
  static const Color positiveLt = Color(0xFFE8F6EF);
  
  /// Warning/Caution status - Orange
  /// Paired with: ⚠ triangle icon
  static const Color caution = Color(0xFFB85C00);
  
  /// Light caution background
  static const Color cautionLt = Color(0xFFFFF3E6);
  
  /// Error/Critical status - Red
  /// Paired with: ✕ xmark icon
  static const Color critical = Color(0xFFC42B2B);
  
  /// Light critical background
  static const Color criticalLt = Color(0xFFFDEAEA);
  
  /// Information status - Cyan
  /// Paired with: ℹ info icon
  static const Color info = Color(0xFF0369A1);
  
  /// Light info background
  static const Color infoLt = Color(0xFFE0F2FE);
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SEMANTIC COLORS - Context-Based Usage
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Background color for primary surfaces
  static const Color background = ink000;
  
  /// Text color for primary content
  static const Color foreground = ink900;
  
  /// Background for cards and elevated surfaces
  static const Color surface = ink000;
  
  /// Text color for secondary content
  static const Color surfaceForeground = ink700;
  
  /// Border color for default state
  static const Color border = ink200;
  
  /// Disabled state color
  static const Color disabled = ink300;
  
  /// Focus ring color for accessibility
  static const Color focus = brand;
  
  /// Overlay color for modals and dialogs
  static const Color overlay = Color(0x80000000); // 50% black
  
  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Get score tier color based on score value
  /// 
  /// Score ranges:
  /// - 75+: Strong (Green)
  /// - 60-74: Good (Blue)
  /// - 40-59: Moderate (Orange)
  /// - <40: Weak (Red)
  static Color getScoreTierColor(int score) {
    if (score >= 75) return positive;
    if (score >= 60) return brand;
    if (score >= 40) return caution;
    return critical;
  }
  
  /// Get risk tier color based on risk level
  static Color getRiskTierColor(String level) {
    switch (level.toLowerCase()) {
      case 'positive':
      case 'low':
        return positive;
      case 'caution':
      case 'moderate':
        return caution;
      case 'critical':
      case 'high':
        return critical;
      default:
        return ink400;
    }
  }
  
  /// Get text color for contrast on background
  static Color getContrastText(Color backgroundColor) {
    // Calculate luminance
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? ink900 : ink000;
  }
}
