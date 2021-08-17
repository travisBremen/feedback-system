import 'package:feedback_system/model/conversationText.dart';
import 'package:feedback_system/model/utils.dart';
import 'package:flutter/material.dart';

class Conversation extends StatelessWidget {
  final int pageIndex;
  final bool hasReplied;
  final int index;
  final double opacity;

  Conversation(
      {Key? key,
      required this.pageIndex,
      required this.hasReplied,
      required this.index,
      required this.opacity})
      : super(key: key);

  static const double height = 30.0;

  @override
  Widget build(BuildContext context) {
    List<ConversationText> conversationText = createText();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height),
        Text(
          conversationText[pageIndex].string1,
          style: _textStyle(),
        ),
        SizedBox(height: height),
        Text(
          conversationText[pageIndex].string2,
          style: _textStyle(),
        ),
        SizedBox(height: height),
        conversationText[pageIndex].string3 == 'null'
            ? Container()
            : Text(
                conversationText[pageIndex].string3,
                style: _textStyle(),
              ),
        conversationText[pageIndex].string3 == 'null'
            ? Container()
            : SizedBox(height: height),
        _buildResponse(index, opacity),
      ],
    );
  }

  Widget _buildResponse(int index, double opacity) {
    return Visibility(
      visible: hasReplied,
      child: Row(
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
