import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart' hide scaffoldLightColor;

import 'colors.dart';

class AppTheme {
  /// 🌞 Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily,

      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldLightColor,
      dividerColor: const Color(0xFFE2E8F0),
      cardColor: Colors.white,

      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentGreenColor,
        surface: scaffoldLightColor,
        onPrimary: Colors.white,
        onSecondary: navyDarkColor,
        onSurface: navyDarkColor,
        error: Color(0xFFDC2626),
        onError: Colors.white,
        errorContainer: Color(0xFFFEF2F2),
        onErrorContainer: Color(0xFFDC2626),
      ),

      /// AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: appTextFiledFilledColor,
        foregroundColor: navyDarkColor,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: navyDarkColor),
      ),

      textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: navyDarkColor, displayColor: navyDarkColor),

      /// Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: radius(80)),
      ),

      /// Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: appTextFiledFilledColor,
        hintStyle: secondaryTextStyle(size: 12),
        errorStyle: secondaryTextStyle(size: 12, color: Colors.red),
        isDense: true,
        border: _inputBorder(),
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(color: primaryColor),
        errorBorder: _inputBorder(color: Colors.red),
        focusedErrorBorder: _inputBorder(color: Colors.red),
      ),

      /// Dropdown
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: appTextFiledFilledColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          border: _inputBorder(),
          enabledBorder: _inputBorder(),
          focusedBorder: _inputBorder(color: primaryColor),
        ),
      ),

      /// Bottom Navigation
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: primaryColor.withOpacity(0.03),
        indicatorColor: accentGreenColor,
        labelTextStyle: WidgetStateProperty.all(secondaryTextStyle(size: 10, color: primaryColor)),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),

      /// Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: true,
        dragHandleColor: primaryDarkColor,
        shape: RoundedRectangleBorder(borderRadius: radius()),
      ),

      /// Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  /// 🌙 Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      fontFamily: GoogleFonts.quicksand().fontFamily,

      scaffoldBackgroundColor: navyDarkColor,
      primaryColor: primaryColor,

      colorScheme: const ColorScheme.dark(primary: primaryColor, secondary: accentGreenColor, surface: Color(0xFF24304D), background: navyDarkColor, error: Color(0xFFF87171)),

      /// AppBar
      appBarTheme: const AppBarTheme(backgroundColor: navyDarkColor, foregroundColor: Colors.white, elevation: 0),

      /// TextFields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF24304D),
        border: _inputBorder(color: Color(0xFF3A4A6A)),
        enabledBorder: _inputBorder(color: Color(0xFF3A4A6A)),
        focusedBorder: _inputBorder(color: accentGreenColor),
      ),

      /// Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: accentGreenColor, foregroundColor: navyDarkColor),

      /// Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentGreenColor,
          foregroundColor: navyDarkColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),

      textTheme: GoogleFonts.quicksandTextTheme().apply(bodyColor: Colors.white, displayColor: Colors.white),
    );
  }
}

OutlineInputBorder _inputBorder({Color color = const Color(0xFFE2E8F0)}) {
  return OutlineInputBorder(
    borderRadius: radius(),
    borderSide: BorderSide(color: color, width: 1),
  );
}
