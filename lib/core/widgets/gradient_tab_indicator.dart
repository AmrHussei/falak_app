import 'package:flutter/material.dart';

class GradientUnderlineTabIndicator extends Decoration {
  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;
  final Gradient gradient;

  const GradientUnderlineTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
    required this.gradient,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GradientUnderlinePainter(this, onChanged);
  }
}

class _GradientUnderlinePainter extends BoxPainter {
  final GradientUnderlineTabIndicator decoration;

  _GradientUnderlinePainter(this.decoration, VoidCallback? onChanged)
    : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicatorRect = decoration.insets
        .resolve(textDirection)
        .deflateRect(rect);

    // Paint Gradient Background
    final Paint gradientPaint = Paint()
      ..shader = decoration.gradient.createShader(indicatorRect);
    canvas.drawRect(indicatorRect, gradientPaint);

    // Paint Underline
    final Paint borderPaint = decoration.borderSide.toPaint()
      ..strokeCap = StrokeCap.square; // Match standard underline look

    final double borderHeight = decoration.borderSide.width;
    // The underline is usually at the bottom of the indicatorRect
    final Offset p1 = Offset(
      indicatorRect.left,
      indicatorRect.bottom - borderHeight / 2.0,
    );
    final Offset p2 = Offset(
      indicatorRect.right,
      indicatorRect.bottom - borderHeight / 2.0,
    );

    canvas.drawLine(p1, p2, borderPaint);
  }
}
