import 'package:flutter/material.dart';

class StrikeThroughDecoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return new _StrikeThroughPainter();
  }
}

class _StrikeThroughPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = new Paint()
      ..strokeWidth = 1.0
      ..color = Colors.grey[600]
      ..style = PaintingStyle.fill;

    final rect = offset & configuration.size;
    canvas.drawLine(
      new Offset(
        rect.center.dx + 20.0,
        rect.top + rect.height / 2
      ), 
      new Offset(
        rect.center.dx - 20.0,
        rect.top + rect.height / 2
      ), paint);

    canvas.drawLine(
      new Offset(
        rect.left + rect.width / 2,
        rect.center.dy + 20.0
      ),
      new Offset(
        rect.left + rect.width / 2,
        rect.center.dy - 20.0
      ), paint);

    canvas.restore();
  }
}