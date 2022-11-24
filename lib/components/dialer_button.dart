import 'package:flutter/material.dart';

class DialerButton extends StatelessWidget {
  final int number;
  final double size;
  final void Function()? onTap;
  final void Function(DragStartDetails)? onPanStart;
  final void Function(DragUpdateDetails)? onPanUpdate;
  final void Function(DragEndDetails)? onPanEnd;

  const DialerButton(
    this.number,
    this.size, {
    Key? key,
    this.onTap,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(size / 6),
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Text(
            '$number',
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
