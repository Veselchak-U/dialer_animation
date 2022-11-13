import 'dart:math';

import 'package:dialer_animation/dialer_button.dart';
import 'package:flutter/material.dart';

class DialerWidget extends StatefulWidget {
  final double size;

  const DialerWidget(this.size, {Key? key}) : super(key: key);

  @override
  State<DialerWidget> createState() => _DialerWidgetState();
}

class _DialerWidgetState extends State<DialerWidget> {
  static const buttonSize = 64.0;

  static const List<Widget> buttonWidgets = [
    DialerButton(1, buttonSize),
    DialerButton(2, buttonSize),
    DialerButton(3, buttonSize),
    DialerButton(4, buttonSize),
    DialerButton(5, buttonSize),
    DialerButton(6, buttonSize),
    DialerButton(7, buttonSize),
    DialerButton(8, buttonSize),
    DialerButton(9, buttonSize),
    DialerButton(0, buttonSize),
  ];

  final List<Alignment> circleAlignment = [];

  @override
  void initState() {
    super.initState();
    _fillCircleAlignments(1);
  }

  @override
  Widget build(BuildContext context) {
    final buttons = List.generate(
      buttonWidgets.length,
      (index) {
        return Align(
          alignment: circleAlignment[index],
          child: buttonWidgets[index],
        );
      },
    );

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          // Container(
          //   color: Colors.green,
          // ),
          Container(
            width: widget.size,
            height: widget.size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
          ...buttons,
        ],
      ),
    );
  }

  void _fillCircleAlignments(double radius) {
    const double step = pi / 7;
    const double start = (pi / 2) - step;
    double angle = start;
    for (var i = 0; i < buttonWidgets.length; i++) {
      final x = radius * cos(angle);
      final y = radius * sin(angle);
      circleAlignment.add(Alignment(x, y * -1));
      angle += step;
    }
  }
}
