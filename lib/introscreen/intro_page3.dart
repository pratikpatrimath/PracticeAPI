import 'package:flutter/material.dart';

class Intro_page3 extends StatelessWidget {
  const Intro_page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: const Center(
            child: Text(
          'Pratik Patrimath',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
