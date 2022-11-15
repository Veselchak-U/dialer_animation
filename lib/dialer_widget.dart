import 'dart:math';

import 'package:dialer_animation/components/dialer_button.dart';
import 'package:dialer_animation/components/dialer_horseshoe.dart';
import 'package:dialer_animation/components/dialer_stopper.dart';
import 'package:flutter/material.dart';

class DialerWidget extends StatefulWidget {
  final double size;

  const DialerWidget(this.size, {Key? key}) : super(key: key);

  @override
  State<DialerWidget> createState() => _DialerWidgetState();
}

class _DialerWidgetState extends State<DialerWidget> {
  static const buttonSize = 80.0;
  static const stepAngle = pi / 7;
  static const startAngle = pi / 2 - stepAngle;

  static const List<Widget> _buttons = [
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
    DialerStopper(buttonSize),
  ];

  final List<Alignment> _circleAlignments = [];

  List<Widget> _buttonsWithAlignment = [];

  @override
  void initState() {
    super.initState();
    _fillCircleAlignments();
    _fillButtonsWithAlignment();
  }

  @override
  Widget build(BuildContext context) {
    const gap = 4.0;
    const holePadding = 16.0;
    final innerSize = widget.size - buttonSize * 2;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const _OuterCircle(),
          _InnerCircle(innerSize),
          ..._buttonsWithAlignment,
          Padding(
            padding: const EdgeInsets.all(gap),
            child: DialerHorseshoe(
              outerRadius: widget.size / 2 - gap,
              innerRadius: innerSize / 2 + gap,
              holeRadius: buttonSize / 2 - holePadding,
              startAngle: startAngle,
              stepAngle: stepAngle,
              endAngle: startAngle + stepAngle * 9,
            ),
          ),
        ],
      ),
    );
  }

  void _fillCircleAlignments() {
    const double radius = 1;
    double angle = startAngle;
    for (var i = 0; i < _buttons.length; i++) {
      final x = radius * cos(angle);
      final y = radius * sin(angle);
      _circleAlignments.add(Alignment(x, y * -1));
      angle += stepAngle;
    }
  }

  void _fillButtonsWithAlignment() {
    _buttonsWithAlignment = List.generate(
      _buttons.length,
      (index) {
        return Align(
          alignment: _circleAlignments[index],
          child: _buttons[index],
        );
      },
    );
  }
}

class _OuterCircle extends StatelessWidget {
  const _OuterCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
  }
}

class _InnerCircle extends StatelessWidget {
  final double size;

  const _InnerCircle(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}
