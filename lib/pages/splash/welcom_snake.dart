import 'package:flutter/material.dart';
import 'package:game_flutter/gen/assets.gen.dart';
import 'package:game_flutter/pages/splash/instruct.dart';

class WelcomSnake extends StatefulWidget {
  const WelcomSnake({super.key});

  @override
  State<WelcomSnake> createState() => _WelcomSnakeState();
}

class _WelcomSnakeState extends State<WelcomSnake> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          Assets.images.snake1.path,
          width: size.width,
          height: size.height,
          fit: BoxFit.fill,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Instruct()),
                        );
                      },
                      style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                              const BorderSide(color: Colors.white, width: 5)),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.yellow)),
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      label: const Text(
                        'Play',
                        style: TextStyle(color: Colors.grey, fontSize: 30.0),
                      ),
                    ),
                    // PlayButton(
                    //   text: 'Play',
                    //   color: Colors.yellow,
                    //   borderRadius:
                    //       const BorderRadius.all(Radius.circular(20.0)),
                    //   onPressed: () {},
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 190.0,
              )
            ],
          ),
        )
      ],
    );
  }
}
