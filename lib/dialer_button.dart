import 'package:flutter/material.dart';

class DialerButton extends StatelessWidget {
  final int number;
  final double size;
  final VoidCallback? onPressed;

  const DialerButton(this.number, this.size, {Key? key, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(8),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Text(
          '$number',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
