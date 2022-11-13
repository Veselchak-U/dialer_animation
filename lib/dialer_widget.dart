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
  static const _buttonSize = 80.0;

  static const List<Widget> _buttons = [
    DialerButton(1, _buttonSize),
    DialerButton(2, _buttonSize),
    DialerButton(3, _buttonSize),
    DialerButton(4, _buttonSize),
    DialerButton(5, _buttonSize),
    DialerButton(6, _buttonSize),
    DialerButton(7, _buttonSize),
    DialerButton(8, _buttonSize),
    DialerButton(9, _buttonSize),
    DialerButton(0, _buttonSize),
    DialerStopper(_buttonSize),
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
    final innerSize = widget.size - _buttonSize * 2;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const _OuterCircle(),
          _InnerCircle(innerSize),
          ..._buttonsWithAlignment,
          DialerHorseshoe(
            outerSize: widget.size,
            innerSize: innerSize,
          ),
        ],
      ),
    );
  }

  void _fillCircleAlignments() {
    const double radius = 1;
    const double step = pi / 7;
    const double start = (pi / 2) - step;
    double angle = start;
    for (var i = 0; i < _buttons.length; i++) {
      final x = radius * cos(angle);
      final y = radius * sin(angle);
      _circleAlignments.add(Alignment(x, y * -1));
      angle += step;
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
