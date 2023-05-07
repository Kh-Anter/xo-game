import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(154, 40, 33, 33),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var mystyle = const TextStyle(color: Colors.white, fontSize: 27);
  List boxesValues = [];
  String winner = "";
  Set xPlayer = {};
  Set oPlayer = {};
  bool newGame = true;
  var currentPlayer = "X";
  List<Widget> boxes = [];
  int O_count = 0, X_count = 0;

  @override
  Widget build(BuildContext context) {
    boxes = buildArray();
    print("CURRENT PLAYER :" + currentPlayer);
    newGame = false;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                "Tic Tac Toe",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      boxesValues = [];
                      winner = "";
                      xPlayer = {};
                      oPlayer = {};
                      newGame = true;
                      currentPlayer = "X";
                      boxes = [];
                      O_count = 0;
                      X_count = 0;
                    });
                  },
                  icon: const Icon(Icons.refresh, color: Colors.white))
            ]),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Player O", style: mystyle),
                Text("Player X", style: mystyle)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(O_count.toString(), style: mystyle),
              Text(X_count.toString(), style: mystyle)
            ]),
            const SizedBox(height: 30),
            SizedBox(
              height: 450,
              child: GridView.count(crossAxisCount: 3, children: [...boxes]),
            ),
            const Spacer(),
            Text(
              "Player ${currentPlayer}",
              style: mystyle,
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  buildArray() {
    List<Widget> newBoxes = [];
    for (int i = 0; i < 9; i++) {
      newBoxes.add(InkWell(
          onTap: () {
            if (boxesValues[i] == "") {
              setState(() {
                if (currentPlayer == "X") {
                  xPlayer.add(i);
                  boxesValues[i] = "X";
                  currentPlayer = "O";
                } else {
                  oPlayer.add(i);
                  boxesValues[i] = "O";
                  currentPlayer = "X";
                }
                newGame = false;
              });
            }
            checkWinner();
            if (winner != "") {
              showDialog(
                  barrierDismissible: false,
                  barrierLabel: "hhh",
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text("Congratulation"),
                        content: Text(winner),
                        actions: [
                          TextButton(
                              onPressed: () {
                                oPlayer = {};
                                xPlayer = {};
                                boxesValues = [];
                                if (winner == "Player X wine !") {
                                  currentPlayer = "X";
                                  X_count++;
                                } else if (winner == "Player O wine !") {
                                  currentPlayer = "O";
                                  O_count++;
                                }
                                winner = "";

                                Navigator.pop(ctx);
                                setState(() {
                                  boxes = [];
                                  newGame = true;
                                });
                              },
                              child: const Text("Containue")),
                          TextButton(
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              child: const Text("Exit")),
                        ],
                      ));
            }
          },
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.white)),
              child: xPlayer.contains(i)
                  ? const Text("X",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))
                  : oPlayer.contains(i)
                      ? const Text("O",
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 143, 1, 1),
                              fontWeight: FontWeight.bold))
                      : const Text(""))));
      if (newGame) {
        boxesValues.add("");
      }
    }

    return newBoxes;
  }

  checkWinner() {
    if (xPlayer.containsAll({0, 1, 2}) ||
        xPlayer.containsAll({3, 4, 5}) ||
        xPlayer.containsAll({6, 7, 8}) ||
        xPlayer.containsAll({0, 3, 6}) ||
        xPlayer.containsAll({1, 4, 7}) ||
        xPlayer.containsAll({2, 5, 8}) ||
        xPlayer.containsAll({0, 4, 8}) ||
        xPlayer.containsAll({2, 4, 6})) {
      winner = "Player X wine !";
    }
    if (oPlayer.containsAll({0, 1, 2}) ||
        oPlayer.containsAll({3, 4, 5}) ||
        oPlayer.containsAll({6, 7, 8}) ||
        oPlayer.containsAll({0, 3, 6}) ||
        oPlayer.containsAll({1, 4, 7}) ||
        oPlayer.containsAll({2, 5, 8}) ||
        oPlayer.containsAll({0, 4, 8}) ||
        oPlayer.containsAll({2, 4, 6})) {
      winner = "Player O wine !";
    }
  }
}
