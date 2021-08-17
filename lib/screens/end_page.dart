import 'package:flutter/material.dart';

class EndPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: Text(
              'Thank you for experiencing the prototype, '
              'please return to the study web page and fill out the questionnaire.',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
