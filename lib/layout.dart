import 'package:feedback_system/components/cross.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  Layout({Key? key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  static const double _iconSize = 60;
  static const double _space = 30;
  static const double _elevation = 30;

  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // constraints: BoxConstraints.tightFor(width: 1600, height: 900),
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 200),
          // child: Center(
          //   child: Container(
          // width: 800,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(20),
          //   border: Border.all(width: 10),
          // ),
          // ACTUAL CONTENT!
          child: Row(
            children: [
              _buildLeftBar(),
              _buildChat(),
            ],
          ),
          //   ),
          // ),
        ),
      ),
    );
  }

  Widget _buildChat() {
    return Expanded(
      child: Container(
        color: Color.fromRGBO(45, 42, 42, 1.0),
        padding: EdgeInsets.symmetric(vertical: _space, horizontal: _space * 2),
        child: Container(
          color: Colors.redAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      color: Colors.white,
      child: Text('sdfs'),
    );
  }

  Widget _buildFeedbackSystem() {
    return Container(
      color: Colors.black87,
      child: Visibility(
        visible: isShown,
        child: Cross(),
      ),
    );
  }

  _showFeedback() {
    setState(() {
      isShown = !isShown;
    });
  }

  Widget _buildInputField() {
    return Container(
      height: _iconSize,
      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(78, 74, 74, 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Message @',
            style: TextStyle(
              color: Color.fromRGBO(108, 108, 108, 1.0),
              fontSize: 18,
            ),
          ),
          MaterialButton(
            color: Color.fromRGBO(45, 42, 42, 1.0),
            shape: CircleBorder(),
            onPressed: _showFeedback,
            child: Icon(
              Icons.add,
              size: 40,
              color: Color.fromRGBO(108, 108, 108, 1.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _space, horizontal: _space / 2),
      color: Color.fromRGBO(16, 15, 15, 1.0),
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
              color: Color.fromRGBO(45, 42, 42, 1.0),
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
}
