import 'package:flutter/material.dart';
import 'package:fclone/pages/fourByFour.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2048 Clone',
      home: FourByFour(),
    );
  }
}
