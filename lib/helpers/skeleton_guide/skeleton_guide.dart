import 'package:flutter/material.dart';
import 'package:linkedin/helpers/colors/color_guide.dart';
import 'package:linkedin/helpers/responsive_design/responsive_design.dart';

class SkeletonGuide extends StatelessWidget {
  final double size;
  final double height;
  final Color color;

  const SkeletonGuide({
    Key key,
    this.size = 10,
    this.color = ColorsGuide.BG_DARK_GRAY,
    this.height = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    ResponsiveDesign responsive = ResponsiveDesign(context);
    return FittedBox(
      child: SizedBox(
        height: responsive.widthMultiplier(height),
        width: size,
        child: CustomPaint(
          painter: Line(responsive.widthMultiplier(height),
              _isDarkTheme ? ColorsGuide.BG_DARK_GRAY : color),
          size: Size(size, 0),
        ),
      ),
    );
  }
}

/// Clase para pintar la linea con los parametos largo y color indicados
///   * [strokeWidth], Tamaño del ancho de la linea.
///   * [color], Color de la linea.
class Line extends CustomPainter {
  final double strokeWidth;
  final Color color;

  Line(this.strokeWidth, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(strokeWidth / 2, strokeWidth / 2),
        Offset(size.width - strokeWidth / 2, strokeWidth / 2), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
