import 'package:flutter/material.dart';

class Intro_page2 extends StatelessWidget {
  const Intro_page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple[100],
        child: const Center(
            child: Text(
          'This is',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
