import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.leftPressed,
      this.color,
      required this.title,
      required this.icon});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  final Function()? leftPressed;
  final Color? color;
  final String title;
  final Icon icon;

  @override
  Size get preferredSize => const Size.fromHeight(86.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
          top: MediaQuery.of(context).padding.top + 6.0, bottom: 12.0),
      color: widget.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: widget.leftPressed,
            child: Transform.rotate(
              angle: 45 * math.pi / 180,
              child: Container(
                padding: const EdgeInsets.all(6.8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: Transform.rotate(
                    angle: -45 * math.pi / 180, child: widget.icon),
              ),
            ),
          ),
          Center(
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(
            color: Colors.black26,
            Icons.settings_applications,
            size: 45.0,
          ),
        ],
      ),
    );
  }
}
