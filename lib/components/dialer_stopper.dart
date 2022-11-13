import 'package:flutter/material.dart';

class DialerStopper extends StatelessWidget {
  final double size;

  const DialerStopper(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size / 3),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}
