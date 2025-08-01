import 'package:flutter/material.dart';

class ImageGenerator {
  static Widget generateParkImage(String parkName, String parkType) {
    final colors = _getColorsForType(parkType);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Stack(
        children: [
          // Padrão de fundo
          Positioned.fill(
            child: CustomPaint(
              painter: _ParkPatternPainter(parkType),
            ),
          ),
          // Ícone e texto
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getIconForType(parkType),
                  size: 60,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    parkName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static List<Color> _getColorsForType(String type) {
    switch (type.toLowerCase()) {
      case 'street':
        return [Colors.grey.shade800, Colors.grey.shade600];
      case 'bowl':
        return [Colors.blue.shade800, Colors.blue.shade600];
      case 'vert':
        return [Colors.green.shade800, Colors.green.shade600];
      case 'plaza':
        return [Colors.orange.shade800, Colors.orange.shade600];
      default:
        return [Colors.black, Colors.grey.shade700];
    }
  }

  static IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'street':
        return Icons.stairs;
      case 'bowl':
        return Icons.sports_baseball;
      case 'vert':
        return Icons.trending_up;
      case 'plaza':
        return Icons.location_city;
      default:
        return Icons.skateboarding;
    }
  }
}

class _ParkPatternPainter extends CustomPainter {
  final String parkType;

  _ParkPatternPainter(this.parkType);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    switch (parkType.toLowerCase()) {
      case 'street':
        _drawStreetPattern(canvas, size, paint);
        break;
      case 'bowl':
        _drawBowlPattern(canvas, size, paint);
        break;
      case 'vert':
        _drawVertPattern(canvas, size, paint);
        break;
      case 'plaza':
        _drawPlazaPattern(canvas, size, paint);
        break;
    }
  }

  void _drawStreetPattern(Canvas canvas, Size size, Paint paint) {
    for (int i = 0; i < 10; i++) {
      final y = (size.height / 10) * i;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y + 20),
        paint,
      );
    }
  }

  void _drawBowlPattern(Canvas canvas, Size size, Paint paint) {
    final center = Offset(size.width / 2, size.height / 2);
    for (int i = 1; i <= 3; i++) {
      canvas.drawCircle(center, (size.width / 6) * i, paint);
    }
  }

  void _drawVertPattern(Canvas canvas, Size size, Paint paint) {
    for (int i = 0; i < 8; i++) {
      final x = (size.width / 8) * i;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + 20, size.height),
        paint,
      );
    }
  }

  void _drawPlazaPattern(Canvas canvas, Size size, Paint paint) {
    for (int i = 0; i < 6; i++) {
      final x = (size.width / 6) * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (int i = 0; i < 4; i++) {
      final y = (size.height / 4) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}