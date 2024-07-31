import 'package:flutter/material.dart';
import 'package:two_thousend_forty_eight/GamePage.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Gamepage()),
      ),
    );
  }
}
