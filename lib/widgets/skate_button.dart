import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SkateButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isOutlined;
  final bool isLarge;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;

  const SkateButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isPrimary = true,
    this.isOutlined = false,
    this.isLarge = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = isLarge ? 56 : 48;
    final double fontSize = isLarge ? 18 : 16;
    final EdgeInsets padding = isLarge 
        ? const EdgeInsets.symmetric(horizontal: 48, vertical: 14)
        : const EdgeInsets.symmetric(horizontal: 30, vertical: 12);

    if (isOutlined) {
      return SizedBox(
        width: width,
        height: buttonHeight,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon != null ? Icon(icon, size: 20) : const SizedBox.shrink(),
          label: Text(text),
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? AppTheme.primaryBlue,
            side: BorderSide(
              color: backgroundColor ?? AppTheme.primaryBlue,
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: padding,
            textStyle: GoogleFonts.lexend(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: buttonHeight,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: 20) : const SizedBox.shrink(),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? (isPrimary ? AppTheme.primaryBlue : AppTheme.darkBlue),
          foregroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: padding,
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.2),
          textStyle: GoogleFonts.lexend(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return Colors.white.withOpacity(0.1);
              }
              if (states.contains(WidgetState.pressed)) {
                return Colors.white.withOpacity(0.2);
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}

// Botão com gradiente (como no design web)
class SkateGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLarge;
  final IconData? icon;
  final Gradient? gradient;
  final double? width;

  const SkateGradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLarge = false,
    this.icon,
    this.gradient,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = isLarge ? 56 : 48;
    final double fontSize = isLarge ? 18 : 16;
    final EdgeInsets padding = isLarge 
        ? const EdgeInsets.symmetric(horizontal: 48, vertical: 14)
        : const EdgeInsets.symmetric(horizontal: 30, vertical: 12);

    return SizedBox(
      width: width,
      height: buttonHeight,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient ?? AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: GoogleFonts.lexend(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}