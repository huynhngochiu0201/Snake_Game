import 'package:flutter/material.dart';

class Piece extends StatefulWidget {
  const Piece({
    super.key,
    required this.posX,
    required this.posY,
    required this.size,
    required this.color,
    this.isAnimated = false,
  });

  final int posX, posY, size;
  final Color color;
  final bool isAnimated;

  @override
  State<Piece> createState() => _PieceState();
}

class _PieceState extends State<Piece> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  //late Animation<double> _opacityAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.25,
      upperBound: 1.0,
      duration:
          const Duration(milliseconds: 1000), // Set duration for the animation
    );
    // _opacityAnimation = Tween<double>(
    //   begin: 0.0,
    //   end: 1.0,
    // ).animate(_animationController);

    // // Start the animation when the widget is initialized
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: widget.posY.toDouble(),
        left: widget.posX.toDouble(),
        child: Opacity(
          opacity: widget.isAnimated ? _animationController.value : 1,
          child: Container(
            width: widget.size.toDouble(),
            height: widget.size.toDouble(),
            decoration: BoxDecoration(
                color: widget.color,
                // borderRadius: const BorderRadius.all(
                //   Radius.circular(10.0),
                // ),
                border: Border.all(width: 2.0, color: Colors.red)),
          ),
        ));
  }
}
