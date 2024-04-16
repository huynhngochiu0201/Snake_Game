import 'package:flutter/material.dart';
import 'package:game_flutter/direction.dart';
import 'package:game_flutter/pages/control_button.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key, required this.onTapped});
  final void Function(Direction direction) onTapped;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0.0,
        right: 0.0,
        bottom: 50.0,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(child: Container()),
                  ControlButton(
                    onPressed: () {
                      onTapped(Direction.left);
                    },
                    icon: const Icon(Icons.arrow_left),
                  ),
                  ControlButton(
                    onPressed: () {
                      onTapped(Direction.right);
                    },
                    icon: const Icon(Icons.arrow_right),
                  ),
                  Expanded(child: Container()),
                  ControlButton(
                    onPressed: () {
                      onTapped(Direction.up);
                    },
                    icon: const Icon(Icons.arrow_drop_up),
                  ),
                  ControlButton(
                    onPressed: () {
                      onTapped(Direction.down);
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ],
        ));
  }
}
