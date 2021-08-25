import 'package:feedback_system/components/conversation.dart';
import 'package:feedback_system/components/cross.dart';
import 'package:feedback_system/screens/end_page.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  Layout({Key? key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  static const double _iconSize = 50;
  static const double _space = 30;
  static const double _elevation = 30;

  bool _isShown = false;
  bool _isShown1 = false;
  bool _isShown2 = false;
  bool _hasReplied = false;
  List<bool> _hasReacted = [false, false, false];
  List<int> _index = [1, 1, 1];
  List<double> _opacity = [0, 0, 0];
  int _pageIndex = 0;

  _lastPage() {
    if (_pageIndex > 0) {
      setState(() {
        _pageIndex--;
        _isShown = false;
        _isShown1 = false;
        _isShown2 = false;
        _hasReplied = false;
        _hasReacted = [false, false, false];
      });
    } else {
      Navigator.pop(context);
    }
  }

  _nextPage() {
    if (_pageIndex < 9) {
      setState(() {
        _pageIndex++;
        _isShown = false;
        _isShown1 = false;
        _isShown2 = false;
        _hasReplied = false;
        _hasReacted = [false, false, false];
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EndPage()),
      );
    }
  }

  _sendFeedback(int index, double opacity) {
    setState(() {
      _hasReacted[0] = true;
      _hasReplied = true;
      _index[0] = index;
      _opacity[0] = opacity;
    });
  }

  _sendFeedback1(int index, double opacity) {
    setState(() {
      _hasReacted[1] = true;
      _hasReplied = true;
      _index[1] = index;
      _opacity[1] = opacity;
    });
  }

  _sendFeedback2(int index, double opacity) {
    setState(() {
      _hasReacted[2] = true;
      _hasReplied = true;
      _index[2] = index;
      _opacity[2] = opacity;
    });
  }

  _showFeedback() {
    setState(() {
      _isShown = !_isShown;
      _isShown1 = false;
      _isShown2 = false;
    });
  }

  _showFeedback1() {
    setState(() {
      _isShown1 = !_isShown1;
      _isShown = false;
      _isShown2 = false;
    });
  }

  _showFeedback2() {
    setState(() {
      _isShown2 = !_isShown2;
      _isShown = false;
      _isShown1 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 1280,
            height: 720,
            // ACTUAL CONTENT!
            child: Row(
              children: [
                _buildLeftBar(),
                _buildChat(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildChat() {
    return Expanded(
      child: Container(
        color: Color.fromRGBO(54, 52, 53, 1.0),
        padding: EdgeInsets.symmetric(vertical: _space, horizontal: _space * 2),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(),
                  _buildFeedbackSystem(),
                ],
              ),
              _buildInputField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      width: 600,
      // color: Colors.black87,
      child: Conversation(
        pageIndex: _pageIndex,
        hasReplied: _hasReplied,
        index: _index,
        opacity: _opacity,
        showFeedback: _showFeedback,
        showFeedback1: _showFeedback1,
        showFeedback2: _showFeedback2,
        hasReacted: _hasReacted,
      ),
    );
  }

  Widget _buildFeedbackSystem() {
    if (_isShown) {
      return Container(
        width: 228,
        // height: 380,
        // color: Colors.black87,
        child: Column(
          children: [
            SizedBox(height: 100),
            Visibility(
              visible: _isShown,
              child: Cross(
                onSelect: _sendFeedback,
              ),
            ),
          ],
        ),
      );
    }

    if (_isShown1) {
      return Container(
        width: 228,
        // height: 380,
        // color: Colors.black87,
        child: Column(
          children: [
            SizedBox(height: 100),
            Visibility(
              visible: _isShown1,
              child: Cross(
                onSelect: _sendFeedback1,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 228,
      // height: 380,
      // color: Colors.black87,
      child: Column(
        children: [
          SizedBox(height: 100),
          Visibility(
            visible: _isShown2,
            child: Cross(
              onSelect: _sendFeedback2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      height: _iconSize,
      padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(69, 68, 66, 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Message @',
            style: TextStyle(
              color: Color.fromRGBO(110, 110, 110, 1.0),
              fontSize: 18,
            ),
          ),
          MaterialButton(
            color: Color.fromRGBO(54, 52, 53, 1.0),
            shape: CircleBorder(),
            onPressed: _showFeedback,
            child: Icon(
              _isShown ? Icons.close : Icons.add,
              size: 40,
              color: Color.fromRGBO(110, 110, 110, 1.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _space, horizontal: _space / 2),
      color: Color.fromRGBO(15, 15, 15, 1.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints:
                BoxConstraints.tightFor(width: _iconSize, height: _iconSize),
            child: MaterialButton(
              color: Color.fromRGBO(238, 119, 132, 1.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {},
              elevation: _elevation,
            ),
          ),
          SizedBox(height: _space),
          _buildIcon(Color.fromRGBO(112, 189, 65, 1.0)),
          SizedBox(height: _space),
          _buildIcon(Color.fromRGBO(25, 53, 111, 1.0)),
          SizedBox(height: _space),
          _buildIcon(Color.fromRGBO(217, 180, 121, 1.0)),
          SizedBox(height: _space),
          ConstrainedBox(
            constraints:
                BoxConstraints.tightFor(width: _iconSize, height: _iconSize),
            child: MaterialButton(
              color: Color.fromRGBO(54, 52, 53, 1.0),
              shape: CircleBorder(),
              onPressed: () {},
              elevation: _elevation,
              child: Icon(
                Icons.add,
                size: _iconSize - 20,
                color: Color.fromRGBO(18, 113, 39, 1.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIcon(Color color) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: _iconSize, height: _iconSize),
      child: MaterialButton(
        color: color,
        shape: CircleBorder(),
        onPressed: () {},
        elevation: _elevation,
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: _lastPage,
            child: Icon(
              Icons.navigate_before,
            ),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: _nextPage,
            child: Icon(
              Icons.navigate_next,
            ),
          ),
        ],
      ),
    );
  }
}
