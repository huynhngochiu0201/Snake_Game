// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_flutter/pages/control_panel.dart';
import '../direction.dart';
import '../piece.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int upperBoundX, upperBoundY, lowerBoundX, lowerBoundY;
  late double screenWidth, screenHeight;
  int step = 30;
  int length = 5;
  Piece? food;
  Offset? foodPosition;
  int score = 0;
  double speed = 1.0;

  List<Offset> positions = [];
  Direction direction = Direction.right;
  Timer? timer;

  void changeSpeed() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    timer = Timer.periodic(Duration(milliseconds: 200 ~/ speed), (timer) {
      setState(() {});
    });
  }

  Widget getControls() {
    return ControlPanel(onTapped: (Direction newDirection) {
      direction = newDirection;
    });
  }

  Direction getRandomDirection() {
    int val = Random().nextInt(4);
    direction = Direction.values[val];
    return direction;
  }

  void restart() {
    length = 5;
    score = 0;
    speed = 1;
    positions = [];
    direction = getRandomDirection();
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    changeSpeed();
  }

  @override
  void initState() {
    super.initState();
    restart();
  }

  int getNearestTens(int num) {
    int output;
    output = (num ~/ step) *
        step; //toán tử ~/ được gọi là toán tử chia lấy phần nguyên.
    //Khi sử dụng toán tử này, kết quả của phép chia sẽ được làm tròn về phần nguyên gần nhất
    if (output == 0) {
      output += step;
    }
    return output;
  }

  Offset getRandomPosition() {
    Offset position;
    int posX = Random().nextInt(upperBoundX) + lowerBoundX;
    int posY = Random().nextInt(upperBoundY) + lowerBoundY;

    position = Offset(
        getNearestTens(posX).toDouble(), getNearestTens(posY).toDouble());
    return position;
  }

  void draw() async {
    if (positions.isEmpty) {
      positions.add(getRandomPosition());
    }

    while (positions.isEmpty) {
      positions.add(getRandomPosition());
    }
    while (length > positions.length) {
      positions.add(positions[positions.length - 1]);
    }
    for (var i = positions.length - 1; i > 0; i--) {
      positions[i] = positions[i - 1];
    }

    positions[0] = await getNextPosition(positions[0]);
  }

  bool detectConllision(Offset position) {
    if (position.dx >= upperBoundX && direction == Direction.right) {
      return true;
    } else if (position.dx <= lowerBoundX && direction == Direction.left) {
      return true;
    } else if (position.dy >= upperBoundY && direction == Direction.down) {
      return true;
    } else if (position.dy <= lowerBoundY && direction == Direction.up) {
      return true;
    }

    return false;
  }

  void showGameDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.red,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.blue, width: 3.0),
            ),
            title: const Text(
              'Game Over',
              style: TextStyle(color: Colors.white),
            ),
            content: Text('data' + score.toString() + "-.-"),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    restart();
                  },
                  child: const Text(
                    'Restart',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ))
            ],
          );
        });
  }

  Future<Offset> getNextPosition(Offset position) async {
    Offset nextPosition = position;

    if (direction == Direction.right) {
      nextPosition = Offset(position.dx + step, position.dy);
    } else if (direction == Direction.left) {
      nextPosition = Offset(position.dx - step, position.dy);
    } else if (direction == Direction.up) {
      nextPosition = Offset(position.dx, position.dy - step);
    } else if (direction == Direction.down) {
      nextPosition = Offset(position.dx, position.dy + step);
    }

    if (detectConllision(position) == true) {
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
      await Future.delayed(
          const Duration(milliseconds: 200), () => showGameDialog());
      return position;
    }
    return nextPosition;
  }

  void drawFood() {
    foodPosition ??= getRandomPosition();
    if (foodPosition == positions[0]) {
      length++;
      score = score + 5;
      speed = speed + 0.25;
      foodPosition = getRandomPosition();
    }
    food = Piece(
      isAnimated: true,
      posX: foodPosition!.dx.toInt(),
      posY: foodPosition!.dy.toInt(),
      size: step,
      color: Colors.red,
    );
  }

  List<Piece> getPieces() {
    final pieces = <Piece>[];
    draw();
    drawFood();

    for (var i = 0; i < length; ++i) {
      if (i >= positions.length) {
        continue;
      }
      pieces.add(
        Piece(
          isAnimated: false,
          posX: positions[i].dx.toInt(),
          posY: positions[i].dy.toInt(),
          size: step,
          color: i.isEven ? Colors.yellow : Colors.blue,
        ),
      );
    }

    return pieces;
  }

  getScore() {
    return Positioned(
        top: 10.0,
        right: 20.0,
        child: Text(
          "Score: $score",
          style: const TextStyle(fontSize: 30.0, color: Colors.green),
        ));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    lowerBoundY = step;
    lowerBoundX = step;

    upperBoundY = getNearestTens(screenHeight.toInt() - step);
    upperBoundX = getNearestTens(screenWidth.toInt() - step);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Stack(
              children: getPieces(),
            ),
            getControls(),
            food!,
            getScore(),
          ],
        ),
      ),
    );
  }
}
