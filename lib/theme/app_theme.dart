import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores principais baseadas no skateflow-web
  static const Color primaryBlue = Color(0xFF3888D2);
  static const Color darkBlue = Color(0xFF043C70);
  static const Color navyBlue = Color(0xFF00294F);
  static const Color darkNavy = Color(0xFF001426);
  static const Color deepDark = Color(0xFF010A12);
  static const Color cardDark = Color(0xFF08243E);
  static const Color footerDark = Color(0xFF272727);
  static const Color hoverGreen = Color(0xFF01bf71);
  
  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, darkBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [navyBlue, darkNavy, deepDark, navyBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Tema claro
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.lexendTextTheme(),
    brightness: Brightness.light,
    
    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      secondary: darkBlue,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
    ),
    
    scaffoldBackgroundColor: Colors.white,
    
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: primaryBlue,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.lexend(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: primaryBlue,
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        textStyle: GoogleFonts.lexend(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryBlue,
        side: const BorderSide(color: primaryBlue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        textStyle: GoogleFonts.lexend(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryBlue,
        textStyle: GoogleFonts.lexend(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.withValues(alpha: 0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryBlue),
      ),
      labelStyle: GoogleFonts.lexend(
        color: Colors.grey,
      ),
      hintStyle: GoogleFonts.lexend(
        color: Colors.grey,
      ),
    ),
    
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      color: Colors.white,
    ),
    
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryBlue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );


}