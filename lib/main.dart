import 'package:flutter/material.dart';
import 'package:xo_game/xo_game.dart';

void main(List<String> args) {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: XoGame(),);
  }
}

