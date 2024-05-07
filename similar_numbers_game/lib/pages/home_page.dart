import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:similar_numbers_game/clasess/num.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int maxNumber = 6;
  int solved = 0;
  List<int> orderedNumbers = [];
  List<Number> listNumber = [];
  List<int> temporary = [];
  Random $random = Random();
  Number number = Number(
    number: 0,
    index: -1,
  );

  int currentNumber = 0;
  int prevNumber = 0;
  int prevIndex = -1;
  int counter = 0;

  int tick = 15;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int rand = $random.nextInt(5) + 1;
    for (int j = rand; j < maxNumber + rand; j++) {
      for (int i = 0; i < 4; i++) {
        orderedNumbers.add(j);
      }
    }
    for (int i = 0; i < maxNumber * 4; i++) {
      int n = $random.nextInt(orderedNumbers.length);
      number = Number(number: orderedNumbers[n], index: i);
      listNumber.add(number);
      orderedNumbers.removeAt(n);
    }

    Timer.periodic(const Duration(seconds: 1), (timer) {
      tick--;
      if (tick != -1) {
        setState(() {});
      } else {
        tick = 15;
        rebuild();
      }
    });
  }

  void click(Number num) {
    if (num.index != prevIndex) {
      prevIndex = num.index;
      if (prevNumber == num.number || prevNumber == 0) {
        counter++;
        if (counter < 4) {
          prevNumber = num.number;
          temporary.add(num.index);
          listNumber[num.index].color = Colors.red;
          setState(() {});
        } else if (counter == 4) {
          temporary.add(num.index);
          for (int i = 0; i < 4; i++) {
            listNumber[temporary[i]].color = Colors.blueAccent;
          }
          temporary = [];
          prevNumber = 0;
          counter = 0;
          solved++;
          if (solved == maxNumber) {
            rebuild();
          }
          setState(() {});
        }
      } else {
        counter = 0;
        prevNumber = 0;
        for (int i = 0; i < temporary.length; i++) {
          listNumber[temporary[i]].color = Colors.white;
        }
        temporary = [];
        setState(() {});
      }
    }
  }

  void rebuild() {
    maxNumber = 6;
    solved = 0;
    prevIndex = -1;
    orderedNumbers = [];
    listNumber = [];
    temporary = [];
    number = Number(
      number: 0,
      index: -1,
    );

    currentNumber = 0;
    prevNumber = 0;
    counter = 0;

    int rand = $random.nextInt(5) + 1;

    for (int j = rand; j < maxNumber + rand; j++) {
      for (int i = 0; i < 4; i++) {
        orderedNumbers.add(j);
      }
    }
    for (int i = 0; i < maxNumber * 4; i++) {
      int n = $random.nextInt(orderedNumbers.length);
      number = Number(number: orderedNumbers[n], index: i);
      listNumber.add(number);
      orderedNumbers.removeAt(n);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  const Text(
                    "Similar Number Game",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.timer,
                    color: tick > 3 ? Colors.blueAccent : Colors.red,
                    size: 40,
                  ),
                  Text(
                    "$tick",
                    style: TextStyle(
                        color: tick > 3 ? Colors.blueAccent : Colors.red,
                        fontSize: 30),
                  ),
                ],
              ),
              const Spacer(),
              GridView.builder(
                shrinkWrap: true,
                itemCount: listNumber.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      click(listNumber[i]);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: listNumber[i].color,
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${listNumber[i].number}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
