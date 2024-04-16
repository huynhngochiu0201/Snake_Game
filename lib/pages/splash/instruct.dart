import 'package:flutter/material.dart';
import 'package:game_flutter/gen/assets.gen.dart';

import '../play_page.dart';

class Instruct extends StatelessWidget {
  const Instruct({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          Assets.images.snake2.path,
          width: size.width,
          height: size.height,
          fit: BoxFit.fill,
        ),
        const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hãy nhấm them hướng ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mũi tên để duy chuyển nhé ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
              // const SizedBox(height: 50.0),
            ],
          ),
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
                              builder: (context) => const PlayPage()),
                        );
                      },
                      style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                              const BorderSide(color: Colors.orange, width: 5)),
                          backgroundColor: const MaterialStatePropertyAll(
                              Color.fromARGB(255, 212, 57, 88))),
                      icon: const Icon(
                        Icons.skip_next_outlined,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      label: const Text(
                        'Next',
                        style: TextStyle(color: Colors.grey, fontSize: 50.0),
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
