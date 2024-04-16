import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.text,
    required this.color,
    required this.borderRadius,
    required this.onPressed,
    this.textcolor = Colors.grey,
    this.formSize = 60.0,
  });
  final String text;
  final Color color;
  final Color textcolor;
  final double formSize;
  final BorderRadius borderRadius;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3.0),
        borderRadius: borderRadius,
        color: color,
      ),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(text,
              style: TextStyle(
                color: textcolor,
                fontSize: formSize,
              )),
        ),
      ),
    );
  }
}
