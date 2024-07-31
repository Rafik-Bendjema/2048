import 'package:flutter/material.dart';
import 'package:two_thousend_forty_eight/gameLogic.dart';

class Gamepage extends StatefulWidget {
  const Gamepage({super.key});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  Gamelogic gamelogic = Gamelogic();
  List<double> elements = List.filled(16, 0);

  @override
  void initState() {
    elements = gamelogic.generate(elements);
    super.initState();
  }

  void replayGame() {
    setState(() {
      elements = List.filled(16, 0);
      elements = gamelogic.generate(elements);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width, // Ensure it's a square
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) async {
                if (details.primaryVelocity! < 0) {
                  print("Swiped left!");
                  setState(() {
                    elements = gamelogic.swipeleft(elements);
                  });
                  await Future.delayed(const Duration(milliseconds: 350))
                      .then((v) {
                    setState(() {
                      elements = gamelogic.generate(elements);
                    });
                  });
                } else if (details.primaryVelocity! > 0) {
                  print("Swiped right!");
                  setState(() {
                    elements = gamelogic.swiperight(elements);
                  });
                  await Future.delayed(const Duration(milliseconds: 350))
                      .then((v) {
                    setState(() {
                      elements = gamelogic.generate(elements);
                    });
                  });
                }
              },
              onVerticalDragEnd: (DragEndDetails details) async {
                if (details.primaryVelocity! < 0) {
                  print("Swiped up!");
                  setState(() {
                    elements = gamelogic.swipeup(elements);
                  });
                  await Future.delayed(const Duration(milliseconds: 350))
                      .then((v) {
                    setState(() {
                      elements = gamelogic.generate(elements);
                    });
                  });
                } else if (details.primaryVelocity! > 0) {
                  print("Swiped down!");
                  setState(() {
                    elements = gamelogic.swipedown(elements);
                  });
                  await Future.delayed(const Duration(milliseconds: 350))
                      .then((v) {
                    setState(() {
                      elements = gamelogic.generate(elements);
                    });
                  });
                }
              },
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: elements.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: gamelogic
                              .getColorForNumber(elements[index].toInt()),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: elements[index] == 0
                          ? const Text("")
                          : Center(
                              child: Text("${elements[index].toInt()}"),
                            ),
                    );
                  }),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: replayGame,
            child: const Text("Replay"),
          ),
        ],
      ),
    );
  }
}