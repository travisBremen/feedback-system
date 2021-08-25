import 'package:feedback_system/model/conversationText.dart';
import 'package:feedback_system/model/utils.dart';
import 'package:flutter/material.dart';

class Conversation extends StatelessWidget {
  final int pageIndex;
  final bool hasReplied;
  final List<int> index;
  final List<double> opacity;
  final Function() showFeedback;
  final Function() showFeedback1;
  final Function() showFeedback2;
  final List<bool> hasReacted;

  Conversation({
    Key? key,
    required this.pageIndex,
    required this.hasReplied,
    required this.index,
    required this.opacity,
    required this.showFeedback,
    required this.hasReacted,
    required this.showFeedback1,
    required this.showFeedback2,
  }) : super(key: key);

  static const double sizedBoxHeight = 30.0;
  static const double boxSize = 30.0;
  static const double imageSize = boxSize - 5.0;

  @override
  Widget build(BuildContext context) {
    List<ConversationText> conversationText = createText();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: sizedBoxHeight),
        InkWell(
          onTap: showFeedback,
          child: Text(
            conversationText[pageIndex].string1,
            style: _textStyle(),
          ),
        ),
        _buildReaction(hasReacted[0], index[0], opacity[0]),
        SizedBox(height: sizedBoxHeight),
        InkWell(
          onTap: showFeedback1,
          child: Text(
            conversationText[pageIndex].string2,
            style: _textStyle(),
          ),
        ),
        _buildReaction(hasReacted[1], index[1], opacity[1]),
        SizedBox(height: sizedBoxHeight),
        conversationText[pageIndex].string3 == 'null'
            ? Container()
            : InkWell(
                onTap: showFeedback2,
                child: Text(
                  conversationText[pageIndex].string3,
                  style: _textStyle(),
                ),
              ),
        _buildReaction(hasReacted[2], index[2], opacity[2]),
        // conversationText[pageIndex].string3 == 'null'
        //     ? Container()
        //     : SizedBox(height: sizedBoxHeight),
        // _buildResponse(),
      ],
    );
  }

  Widget _buildReaction(bool hasReacted, int index, double opacity) {
    return Visibility(
      visible: hasReacted,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
          width: boxSize,
          height: boxSize,
          child: Center(
            child: ClipOval(
              child: Image.asset(
                'assets/' + index.toString() + '.jpeg',
                color: Color.fromRGBO(23, 158, 151, opacity), // #179E97
                // modulate / multiply / darken /src
                colorBlendMode: BlendMode.multiply,
                height: imageSize,
                width: imageSize,
              ),
            ),
          )),
    );
  }

  // Widget _buildResponse() {
  //   return Visibility(
  //     visible: hasReplied,
  //     child: Row(
  //       children: [
  //         Text('Me: ', style: _textStyle()),
  //         ClipOval(
  //           child: Image.asset(
  //             'assets/' + index.toString() + '.jpeg',
  //             color: Color.fromRGBO(23, 158, 151, opacity), // #179E97
  //             // modulate / multiply / darken /src
  //             colorBlendMode: BlendMode.multiply,
  //             height: 50.0,
  //             width: 50.0,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  TextStyle _textStyle() {
    return TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(255, 255, 255, 1.0),
    );
  }
}
