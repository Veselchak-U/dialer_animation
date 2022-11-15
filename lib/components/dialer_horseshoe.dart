import 'dart:math';

import 'package:flutter/material.dart';

class DialerHorseshoe extends StatelessWidget {
  final double outerRadius;
  final double innerRadius;
  final double holeRadius;
  final double startAngle;
  final double stepAngle;
  final double endAngle;

  const DialerHorseshoe({
    Key? key,
    required this.outerRadius,
    required this.innerRadius,
    required this.holeRadius,
    required this.startAngle,
    required this.stepAngle,
    required this.endAngle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(outerRadius * 2),
      painter: _DialerHorseshoePainter(
        outerRadius: outerRadius,
        innerRadius: innerRadius,
        holeRadius: holeRadius,
        startAngle: startAngle,
        stepAngle: stepAngle,
        endAngle: endAngle,
      ),
    );
  }
}

class _DialerHorseshoePainter extends CustomPainter {
  final double outerRadius;
  final double innerRadius;
  final double holeRadius;
  final double startAngle;
  final double stepAngle;
  final double endAngle;

  _DialerHorseshoePainter({
    required this.outerRadius,
    required this.innerRadius,
    required this.holeRadius,
    required this.startAngle,
    required this.stepAngle,
    required this.endAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final canvasCenter = Offset(size.width / 2, size.height / 2);
    final middleRadius = (outerRadius + innerRadius) / 2;
    final roundingRadius = (outerRadius - innerRadius) / 2;

    final path1 = Path();
    //anchor points
    final startOuterArc = _getArcPoint(canvasCenter, outerRadius, startAngle);
    final endOuterArc = _getArcPoint(canvasCenter, outerRadius, endAngle);
    final startInnerArc = _getArcPoint(canvasCenter, innerRadius, startAngle);
    final endInnerArc = _getArcPoint(canvasCenter, innerRadius, endAngle);
    //outer arc
    path1.moveTo(startOuterArc.dx, startOuterArc.dy);
    path1.arcToPoint(endOuterArc,
        radius: Radius.circular(outerRadius), largeArc: true);
    //first rounding
    path1.arcToPoint(endInnerArc, radius: Radius.circular(roundingRadius));
    //inner arc
    path1.arcToPoint(startInnerArc,
        radius: Radius.circular(innerRadius), largeArc: true, clockwise: false);
    //second rounding
    path1.arcToPoint(startOuterArc, radius: Radius.circular(roundingRadius));

    //buttons holes
    final path2 = Path();
    var angle = startAngle;
    for (var i = 0; i < 10; i++) {
      final holeCenter = _getArcPoint(canvasCenter, middleRadius, angle);
      final rect = Rect.fromCircle(center: holeCenter, radius: holeRadius);
      path2.addOval(rect);
      angle += stepAngle;
    }

    final combinePath = Path.combine(PathOperation.difference, path1, path2);
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.fill;
    canvas.drawPath(combinePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  Offset _getArcPoint(Offset center, double radius, double angle) {
    return Offset(
      center.dx + radius * cos(angle),
      center.dy + radius * sin(angle),
    );
  }
}
