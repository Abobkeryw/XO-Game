import 'package:flutter/material.dart';

class XoGame extends StatefulWidget {
  const XoGame({super.key});

  @override
  State<XoGame> createState() => _XoGameState();
}

class _XoGameState extends State<XoGame> {
  int playerX = 0;
  int playerO = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              SizedBox(height: 50),
              HeaderSection(o: playerO, x: playerX),
              XOBox(
                onPressed: (turn) {
                  if (turn == 'Winner is X') {
                    setState(() {
                      playerX++;
                    });
                  }
                  if (turn == 'Winner is O') {
                    setState(() {
                      playerO++;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final int x;
  final int o;
  const HeaderSection({super.key, required this.x, required this.o});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Tic Tac Tio',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          'Player X = $x',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          'Player O = $o',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class XOBox extends StatefulWidget {
  final void Function(String turn) onPressed;
  const XOBox({super.key, required this.onPressed});

  @override
  State<XOBox> createState() => _XOBoxState();
}

class _XOBoxState extends State<XOBox> {
  List<String> xoList = List.filled(9, '');
  String checkWinner() {
    if (xoList[0] == xoList[1] && xoList[0] == xoList[2] && xoList[0] != '') {
      return 'Winner is ${xoList[0]}';
    } else if (xoList[3] == xoList[4] &&
        xoList[3] == xoList[5] &&
        xoList[3] != '') {
      return 'Winner is ${xoList[3]}';
    } else if (xoList[6] == xoList[7] &&
        xoList[6] == xoList[8] &&
        xoList[6] != '') {
      return 'Winner is ${xoList[6]}';
    } else if (xoList[0] == xoList[3] &&
        xoList[0] == xoList[6] &&
        xoList[0] != '') {
      return 'Winner is ${xoList[0]}';
    } else if (xoList[1] == xoList[4] &&
        xoList[1] == xoList[7] &&
        xoList[1] != '') {
      return 'Winner is ${xoList[1]}';
    } else if (xoList[2] == xoList[5] &&
        xoList[2] == xoList[8] &&
        xoList[2] != '') {
      return 'Winner is ${xoList[2]}';
    } else if (xoList[0] == xoList[4] &&
        xoList[0] == xoList[8] &&
        xoList[0] != '') {
      return 'Winner is ${xoList[0]}';
    } else if (xoList[2] == xoList[4] &&
        xoList[2] == xoList[6] &&
        xoList[2] != '') {
      return 'Winner is ${xoList[2]}';
    }
    return '';
  }

  String turn = 'X';
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                if (xoList[index] == '') {
                  xoList[index] = turn;
                  turn = turn == 'X' ? 'O' : 'X';
                }
              });
              checkWinner();
              String winner = checkWinner();
              if (winner != '') {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Winner'),
                      content: Text(winner),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              xoList = List.filled(9, '');
                            });
                            Navigator.pop(context);
                          },
                          child: Text('Play Again'),
                        ),
                      ],
                    );
                  },
                );
                widget.onPressed(winner);
              }
            },
            child: Container(
              margin: EdgeInsets.all(5),
              color: Colors.blue,
              child: Center(
                child: Text(
                  xoList[index],
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
        itemCount: 9,
      ),
    );
  }
}
