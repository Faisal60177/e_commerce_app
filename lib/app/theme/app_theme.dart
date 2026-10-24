import 'package:e_commerce_app/app/theme/app_colors.dart';
import 'package:e_commerce_app/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);
  
  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(seedColor: AppColors.seed,
    brightness: brightness,
    );
    
    final base = ThemeData(useMaterial3: true, colorScheme: scheme);
    final radius = BorderRadius.circular(14);
    
    OutlineInputBorder border([Color? color, double width = 0]){
      return OutlineInputBorder(
        borderRadius: radius,
        borderSide: color == null
          ? BorderSide.none : BorderSide(color: color, width: width),
      );
    }
    
    return base.copyWith(
      textTheme: AppTextStyles.textTheme(base.textTheme),
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation:  0,
        scrolledUnderElevation: 0,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),


      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: border(),
        enabledBorder: border(),
        focusedBorder: border(scheme.primary, 1.5),
        errorBorder: border(scheme.error, 1),
        focusedErrorBorder: border(scheme.error, 1.5),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 52),
          shape: RoundedRectangleBorder(borderRadius: radius),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom (
          minimumSize: const Size(64, 52),
          shape: RoundedRectangleBorder(borderRadius: radius),
        ),
      ),
      chipTheme:  const ChipThemeData(
        shape: StadiumBorder(),
        side: BorderSide.none,
      ),

      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        labelTextStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      dividerTheme: DividerThemeData(
        space: 1,
        thickness: 1,
        color: scheme.outlineVariant.withValues(alpha: 0.5),
      ),
    );
  }
}