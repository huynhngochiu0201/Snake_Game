import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  const ControlButton({super.key, required this.onPressed, required this.icon});
  final Function() onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 1.0,
        child: SizedBox(
            width: 80.0,
            height: 80.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: onPressed,
                backgroundColor: Colors.green,
                elevation: 0.0,
                child: icon,
              ),
            )));
  }
}
