import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette - Modern, Professional with Cybersecurity vibes
  static const Color primaryBlue = Color(0xFF00D4FF);
  static const Color primaryPurple = Color(0xFF6C63FF);
  static const Color accentCyan = Color(0xFF00FFF0);
  static const Color accentPink = Color(0xFFFF006E);
  
  // Dark Theme Colors
  static const Color darkBg = Color(0xFF0A0E27);
  static const Color darkCard = Color(0xFF1A1F3A);
  static const Color darkCardHover = Color(0xFF252B4A);
  
  // Light Theme Colors
  static const Color lightBg = Color(0xFFF8F9FA);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardHover = Color(0xFFF0F2F5);
  
  // Text Colors
  static const Color darkText = Color(0xFFE8E8E8);
  static const Color lightText = Color(0xFF2D3748);
  static const Color mutedText = Color(0xFF94A3B8);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentCyan, primaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0A0E27), Color(0xFF1A1F3A), Color(0xFF2A2F4A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBg,
    primaryColor: primaryBlue,
    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      secondary: primaryPurple,
      surface: lightCard,
      background: lightBg,
    ),
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: lightText,
      displayColor: lightText,
    ),
    cardTheme: CardThemeData(
      color: lightCard,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,
    primaryColor: primaryBlue,
    colorScheme: const ColorScheme.dark(
      primary: primaryBlue,
      secondary: primaryPurple,
      surface: darkCard,
      background: darkBg,
    ),
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: darkText,
      displayColor: darkText,
    ),
    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 4,
      shadowColor: primaryBlue.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    ),
  );

  // Text Styles
  static TextStyle heading1(BuildContext context) {
    return GoogleFonts.outfit(
      fontSize: 64,
      fontWeight: FontWeight.bold,
      height: 1.2,
      color: Theme.of(context).brightness == Brightness.dark ? darkText : lightText,
    );
  }

  static TextStyle heading2(BuildContext context) {
    return GoogleFonts.outfit(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      height: 1.2,
      color: Theme.of(context).brightness == Brightness.dark ? darkText : lightText,
    );
  }

  static TextStyle heading3(BuildContext context) {
    return GoogleFonts.outfit(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: Theme.of(context).brightness == Brightness.dark ? darkText : lightText,
    );
  }

  static TextStyle heading4(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.4,
      color: Theme.of(context).brightness == Brightness.dark ? darkText : lightText,
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      height: 1.6,
      color: Theme.of(context).brightness == Brightness.dark ? darkText : lightText,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 1.6,
      color: Theme.of(context).brightness == Brightness.dark ? darkText : lightText,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: mutedText,
    );
  }

  static TextStyle caption(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      height: 1.4,
      color: mutedText,
    );
  }
}
