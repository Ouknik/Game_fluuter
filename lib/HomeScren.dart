import 'dart:async';
import 'package:flutter/material.dart';
import 'Blouque.dart';
import 'barrier.dart';
import 'bride.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({Key? key}) : super(key: key);

  @override
  _HomeScrenState createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  static double bridY = 0;
  static final double bridX = 0;
  double vite = 0.1;
  double time = 0;
  double Note = 0;
  double sazexone = 180.0;
  double NoteApre = 0;
  double height = 0;
  double initalHeight = bridY;
  bool gameHasStarted = false;
  static double barrerXone = 1;
  static double barrerXtwo = barrerXone + 2;
  double barrerXthre = barrerXtwo + 2;

  void jump() {
    setState(() {
      time = 0;
      initalHeight = bridY;
    });
  }

  void STartGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      vite += 0.002;
      barrerXone -= vite;
      barrerXtwo -= vite;
      barrerXthre -= vite;

      Note += 1;

      time += 0.05;
      height = -9.8 * time * time + time * 1.5;
      setState(() {
        bridY = initalHeight - height;
      });

      setState(() {
        if (barrerXone < -2) {
          barrerXone += 3.5;
        } else {
          barrerXone -= 0.01;
        }
      });
      setState(() {
        if (barrerXtwo < -2) {
          barrerXtwo += 3.5;
        } else {
          barrerXtwo -= 0.01;
        }
      });

      setState(() {
        if (barrerXthre < -2) {
          barrerXthre += 5.5;
        } else {
          barrerXthre -= 0.01;
        }
      });

      if (
          //hada dyal twiyr 1
          ((((Note <= 80 && Note >= 50) || (Note > 120 && Note <= 200)) &&
                  bridX == 0.0 &&
                  bridY < -0.15 &&
                  bridY > -0.3)) ||
              //hada dyal twiyr 2
              ((Note <= 200 &&
                  Note >= 100 &&
                  bridX == 0.0 &&
                  bridY < 0.4 &&
                  bridY > 0.2)) ||

              //hada dyal l7odod dyal scafold
              (bridY > 1 || bridY < 0 - 1) ||
              //hado dyol the barrire
              (barrerXone < 0.1 &&
                  barrerXone > -0.1 &&
                  (bridY > 0.3 || bridY < -0.4)) ||
              (barrerXtwo < 0.1 &&
                  barrerXtwo > -0.1 &&
                  (bridY > 0.5 || bridY < -0.09)) ||
              (barrerXthre < 0.1 &&
                  barrerXthre > -0.1 &&
                  (bridY > 0.09 || bridY < -0.5))) {
        _showDialog();
        timer.cancel();
      }
    });
  }

  void resetGame() {
    setState(() {
      Navigator.pop(context);
      NoteApre = Note;
      Note = 0;
      vite = 0.1;
      height = 0;
      bridY = 0;
      gameHasStarted = false;
      barrerXone = 1;
      barrerXtwo = barrerXone + 2;
      barrerXthre = barrerXtwo + 2;
      gameHasStarted = false;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!gameHasStarted) {
          STartGame();
        } else {
          jump();
        }
      },
      child: Scaffold(
        // backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    GestureDetector(
                      child: AnimatedContainer(
                        alignment: Alignment(bridX, bridY),
                        duration: Duration(milliseconds: 0),
                        child: MyBird(),
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: gameHasStarted
                          ? Text('$Note')
                          : Text(
                              'P L A Y  ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                    ),

//tswira dyal charchabil llowla
                    (Note < 10 || (Note > 30 && Note < 50))
                        ? GestureDetector(
                            child: AnimatedContainer(
                              alignment: Alignment(-1, 0.0),
                              duration: Duration(milliseconds: 0),
                              child: Blouque(),
                            ),
                          )
                        : Text(''),
                    //hadi fach tayosl 100 tay3ti charchabil lta7t
                    (Note > 100 && Note <= 200)
                        ? GestureDetector(
                            child: AnimatedContainer(
                              alignment: Alignment(0, 0.5),
                              duration: Duration(milliseconds: 0),
                              child: Blouque(),
                            ),
                          )
                        : Text(''),

                    //hadi fach tayosl 50 tay3ti charchabil lfo9
                    ((Note > 50 && Note <= 100))
                        ? GestureDetector(
                            child: AnimatedContainer(
                              alignment: Alignment(0, -0.3),
                              duration: Duration(milliseconds: 0),
                              child: Blouque(),
                            ),
                          )
                        : Text(''),
                    //hadi fach tayosl 120 tay3ti 2 dyal charchabil llowla
                    (Note > 120 && Note <= 200)
                        ? GestureDetector(
                            child: AnimatedContainer(
                              alignment: Alignment(-0.5, -0.3),
                              duration: Duration(milliseconds: 0),
                              child: Blouque(),
                            ),
                          )
                        : Text(''),

                    /// hadi dyal la3mida lkhdrin  homa rah 3 kolla olmaw9i3 dyalo
                    AnimatedContainer(
                      alignment: Alignment(barrerXone, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 180.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrerXone, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 160.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrerXtwo, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 120.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrerXtwo, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 230.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrerXthre, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 230.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrerXthre, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 120.0,
                      ),
                    ),
                    ////////////************************************** */
                  ],
                )),
            Container(
              height: 15,
              color: Colors.greenAccent,
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$Note',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'natija',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$NoteApre',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'loala',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
