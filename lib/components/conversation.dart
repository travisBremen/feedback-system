import 'package:flutter/material.dart';

class Conversation extends StatelessWidget {
  final bool hasReplied;
  final int index;
  final double opacity;

  Conversation(
      {required this.hasReplied, required this.index, required this.opacity});

  static const double height = 30.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height),
        Text(
          'David: You know what? I just passed the exam with a 1.0!',
          style: _textStyle(),
        ),
        SizedBox(height: height),
        Text(
          'Eva: Wow, congrats!',
          style: _textStyle(),
        ),
        SizedBox(height: height),
        _buildResponse(index, opacity),
      ],
    );
  }

  Widget _buildResponse(int index, double opacity) {
    return Visibility(
      visible: hasReplied,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Me: ', style: _textStyle()),
          ClipOval(
            child: Image.asset(
              'assets/' + index.toString() + '.jpeg',
              color: Color.fromRGBO(23, 158, 151, opacity), // #179E97
              // modulate / multiply / darken /src
              colorBlendMode: BlendMode.multiply,
              height: 50.0,
              width: 50.0,
            ),
          )
        ],
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(255, 255, 255, 1.0),
    );
  }
}
