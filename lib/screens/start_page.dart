import 'package:feedback_system/screens/layout.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 900,
            height: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Multi-Scale Feedback System Prototype',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Text(
                  'In this prototype, ten short conversations covering different topics are provided. '
                  'For each conversation, imagine you receive messages '
                  'from your friends on an instant messaging platform, '
                  'and now you want to send an emoji to reply. ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'There are 5 types of emoji here: smile, frown, open mouth, think, clap. '
                  'Each emoji has a scale from 1 to 3 indicating the level of feedback '
                  'you want to give to the speakers.',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Please tap the button at the bottom right to open the feedback system. '
                  'Select an emoji with a scale to reply and then you can go to the next conversation.',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Please maximize your web browser for presenting content correctly when using the prototype. ',
                  style: TextStyle(fontSize: 20),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Layout()),
                      );
                    },
                    child: Text(
                      'START',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
