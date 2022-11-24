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

  late final List<Widget> _buttons;

  final List<Alignment> _circleAlignments = [];

  List<Widget> _buttonsWithAlignment = [];

  double turns = 0.0;

  @override
  void initState() {
    super.initState();
    _initButtons();
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
          IgnorePointer(
            child: Padding(
              padding: const EdgeInsets.all(gap),
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 500),
                turns: turns,
                child: DialerHorseshoe(
                  outerRadius: widget.size / 2 - gap,
                  innerRadius: innerSize / 2 + gap,
                  holeRadius: buttonSize / 2 - holePadding,
                  startAngle: startAngle,
                  stepAngle: stepAngle,
                  endAngle: startAngle + stepAngle * 9,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setTurns(double value) {
    setState(() {
      turns = value;
    });
  }

  void _onPanStart(int index) {
    print('!!! _onPanStart($index)');
  }

  void _onPanUpdate(int index, DragUpdateDetails info) {
    print('!!! _onPanUpdate($index): ${info.delta.dx} ${info.delta.dy}');
    final deltaTurns = _calcDeltaTurns(info.delta);
    _setTurns(turns + deltaTurns);
  }

  void _onPanEnd(int index) {
    print('!!! _onPanEnd($index)');
    _setTurns(0);
  }

  double _calcDeltaTurns(Offset delta) {
    final mult = 2 * pi / widget.size;
    return -delta.dy * mult;
  }

  void _initButtons() {
    _buttons = [
      DialerButton(
        1,
        buttonSize,
        onPanStart: (_) => _onPanStart(1),
        onPanUpdate: (info) => _onPanUpdate(1, info),
        onPanEnd: (_) => _onPanEnd(1),
      ),
      DialerButton(
        2,
        buttonSize,
        onPanStart: (_) => _onPanStart(2),
        onPanUpdate: (info) => _onPanUpdate(2, info),
        onPanEnd: (_) => _onPanEnd(2),
      ),
      DialerButton(
        3,
        buttonSize,
        onPanStart: (_) => _onPanStart(3),
        onPanUpdate: (info) => _onPanUpdate(3, info),
        onPanEnd: (_) => _onPanEnd(3),
      ),
      DialerButton(
        4,
        buttonSize,
        onPanStart: (_) => _onPanStart(4),
        onPanUpdate: (info) => _onPanUpdate(4, info),
        onPanEnd: (_) => _onPanEnd(4),
      ),
      DialerButton(
        5,
        buttonSize,
        onPanStart: (_) => _onPanStart(5),
        onPanUpdate: (info) => _onPanUpdate(5, info),
        onPanEnd: (_) => _onPanEnd(5),
      ),
      DialerButton(
        6,
        buttonSize,
        onPanStart: (_) => _onPanStart(6),
        onPanUpdate: (info) => _onPanUpdate(6, info),
        onPanEnd: (_) => _onPanEnd(6),
      ),
      DialerButton(
        7,
        buttonSize,
        onPanStart: (_) => _onPanStart(7),
        onPanUpdate: (info) => _onPanUpdate(7, info),
        onPanEnd: (_) => _onPanEnd(7),
      ),
      DialerButton(
        8,
        buttonSize,
        onPanStart: (_) => _onPanStart(8),
        onPanUpdate: (info) => _onPanUpdate(8, info),
        onPanEnd: (_) => _onPanEnd(8),
      ),
      DialerButton(
        9,
        buttonSize,
        onPanStart: (_) => _onPanStart(9),
        onPanUpdate: (info) => _onPanUpdate(9, info),
        onPanEnd: (_) => _onPanEnd(9),
      ),
      DialerButton(
        0,
        buttonSize,
        onPanStart: (_) => _onPanStart(0),
        onPanUpdate: (info) => _onPanUpdate(0, info),
        onPanEnd: (_) => _onPanEnd(0),
      ),
      const DialerStopper(buttonSize),
    ];
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
