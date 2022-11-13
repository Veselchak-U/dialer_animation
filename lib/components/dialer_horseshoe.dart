import 'package:flutter/material.dart';

class DialerHorseshoe extends StatelessWidget {
  final double outerSize;
  final double innerSize;

  const DialerHorseshoe({
    Key? key,
    required this.outerSize,
    required this.innerSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(outerSize, outerSize),
      painter: _DialerHorseshoePainter(innerSize),
    );
  }
}

class _DialerHorseshoePainter extends CustomPainter {
  final double innerSize;

  _DialerHorseshoePainter(this.innerSize);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, innerSize / 3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
