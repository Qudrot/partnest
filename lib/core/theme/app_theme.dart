import 'package:flutter/material.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/core/constants/app_spacing.dart';

/// Partnex Design System - Theme Configuration
/// 
/// This file provides the complete Material 3 theme configuration for the
/// Partnex application, integrating colors, typography, and spacing.
class AppTheme {
  // ═══════════════════════════════════════════════════════════════════════════
  // LIGHT THEME
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Light theme data for Material 3
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // ─────────────────────────────────────────────────────────────────────
      // COLOR SCHEME
      // ─────────────────────────────────────────────────────────────────────
      colorScheme: ColorScheme.light(
        primary: AppColors.brand,
        onPrimary: AppColors.ink000,
        primaryContainer: AppColors.brandLt,
        onPrimaryContainer: AppColors.brand,
        secondary: AppColors.ink700,
        onSecondary: AppColors.ink000,
        secondaryContainer: AppColors.ink100,
        onSecondaryContainer: AppColors.ink700,
        tertiary: AppColors.positive,
        onTertiary: AppColors.ink000,
        tertiaryContainer: AppColors.positiveLt,
        onTertiaryContainer: AppColors.positive,
        error: AppColors.critical,
        onError: AppColors.ink000,
        errorContainer: AppColors.criticalLt,
        onErrorContainer: AppColors.critical,
        surface: AppColors.ink000,
        onSurface: AppColors.ink900,
        surfaceContainerHighest: AppColors.ink100,
        onSurfaceVariant: AppColors.ink600,
        outline: AppColors.ink200,
        outlineVariant: AppColors.ink150,
        shadow: Color(0x00000000),
        scrim: Color(0x80000000),
      ),
      
      // ─────────────────────────────────────────────────────────────────────
      // TYPOGRAPHY
      // ─────────────────────────────────────────────────────────────────────
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.heading1,
        headlineMedium: AppTypography.heading2,
        headlineSmall: AppTypography.heading3,
        titleLarge: AppTypography.heading4,
        titleMedium: AppTypography.bodyMediumBold,
        titleSmall: AppTypography.labelMedium,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
      ),
      
      // ─────────────────────────────────────────────────────────────────────
      // COMPONENT THEMES
      // ─────────────────────────────────────────────────────────────────────
      
      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brand,
          foregroundColor: AppColors.ink000,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: AppTypography.bodyMediumBold,
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink700,
          side: BorderSide(color: AppColors.ink200, width: 1.5),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: AppTypography.bodyMediumBold,
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.brand,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          textStyle: AppTypography.bodyMediumBold,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.ink000,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
          side: BorderSide(color: AppColors.ink200, width: 1.5),
        ),
        margin: EdgeInsets.zero,
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.ink100,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: AppColors.ink200, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: AppColors.ink200, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: AppColors.brand, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: AppColors.critical, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: AppColors.critical, width: 2),
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(color: AppColors.ink600),
        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.ink400),
        errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.critical),
        helperStyle: AppTypography.bodySmall.copyWith(color: AppColors.ink400),
      ),
      
      // App Bar Theme
      appBarTheme: AppBarThemeData(
        backgroundColor: AppColors.ink000,
        foregroundColor: AppColors.ink900,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.heading3,
        toolbarHeight: 56,
        surfaceTintColor: Colors.transparent,
      ),
      
      // Divider Theme
      dividerTheme: DividerThemeData(
        color: AppColors.ink200,
        thickness: AppSpacing.dividerHeight,
        space: AppSpacing.lg,
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.ink100,
        disabledColor: AppColors.ink150,
        selectedColor: AppColors.brandLt,
        secondarySelectedColor: AppColors.brandLt,
        labelStyle: AppTypography.labelMedium,
        secondaryLabelStyle: AppTypography.labelMedium,
        brightness: Brightness.light,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        side: BorderSide(color: AppColors.ink200),
      ),
      
      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.ink000,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        titleTextStyle: AppTypography.heading2,
        contentTextStyle: AppTypography.bodyMedium,
      ),
      
      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.ink000,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSpacing.radiusLg),
            topRight: Radius.circular(AppSpacing.radiusLg),
          ),
        ),
      ),
      
      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.ink900,
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.ink000,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),
      
      // ─────────────────────────────────────────────────────────────────────
      // GENERAL SETTINGS
      // ─────────────────────────────────────────────────────────────────────
      scaffoldBackgroundColor: AppColors.ink100,
      canvasColor: AppColors.ink100,
      disabledColor: AppColors.ink300,
      focusColor: AppColors.brand,
      hoverColor: AppColors.brandDim,
      highlightColor: AppColors.brandDim,
      splashColor: AppColors.brandDim,
      splashFactory: InkRipple.splashFactory,
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // DARK THEME (Optional - can be implemented later)
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Dark theme data for Material 3
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.brand,
        onPrimary: AppColors.ink900,
        primaryContainer: AppColors.ink800,
        onPrimaryContainer: AppColors.brandLt,
        secondary: AppColors.ink300,
        onSecondary: AppColors.ink900,
        secondaryContainer: AppColors.ink700,
        onSecondaryContainer: AppColors.ink300,
        tertiary: AppColors.positive,
        onTertiary: AppColors.ink900,
        tertiaryContainer: AppColors.ink800,
        onTertiaryContainer: AppColors.positiveLt,
        error: AppColors.critical,
        onError: AppColors.ink900,
        errorContainer: AppColors.ink800,
        onErrorContainer: AppColors.criticalLt,
        surface: AppColors.ink800,
        onSurface: AppColors.ink000,
        surfaceContainerHighest: AppColors.ink700,
        onSurfaceVariant: AppColors.ink300,
        outline: AppColors.ink600,
        outlineVariant: AppColors.ink700,
        shadow: Color(0x00000000),
        scrim: Color(0x80000000),
      ),
      scaffoldBackgroundColor: AppColors.ink900,
      canvasColor: AppColors.ink800,
    );
  }
}
