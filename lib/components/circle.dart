import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:math' as Math;

const double _radiansPerDegree = Math.pi / 180;
final double _startAngle = -90.0 * _radiansPerDegree;

typedef double ItemAngleCalculator(int index);

class Circle extends StatefulWidget {
  @override
  _CircleState createState() => _CircleState();
}

// TODO RING
class _CircleState extends State<Circle> {
  /// 图片路径
  static const String imageDir = 'assets/cross/';
  static const String imageFormat = '.jpeg';

  int itemIndex = 1;
  int itemCount = 5;
  bool _hasSelected = false;

  _selectItem(int i) {
    setState(() {
      _hasSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: new BoxDecoration(color: Colors.teal),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildStackView(),
          ],
        ),
      ),
    );
  }

  Widget _buildStackView() {
    final List<Widget> beverages = <Widget>[];
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    double width = 300;
    double height = 300;
    // double outerRadius = Math.min(width * 3 / 4, height * 3 / 4);
    double outerRadius = 200;
    double innerWhiteRadius = outerRadius * 3 / 4;

    for (int i = 0; i < itemCount; i++) {
      beverages.add(_buildIcons(i));
    }

    return Flexible(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: new Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            // TODO: Send the emoji
            Visibility(
              visible: _hasSelected,
              child: GestureDetector(
                onTap: () {
                  log('Box selected!');
                },
                child: Image.asset(
                  imageDir + itemIndex.toString() + imageFormat,
                  width: innerWhiteRadius,
                  height: innerWhiteRadius,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // _drawCircle(outerRadius, Color.fromRGBO(255, 255, 255, 0.3)),
            CustomMultiChildLayout(
              delegate: new _CircularLayoutDelegate(
                itemCount: itemCount,
                radius: outerRadius / 2,
              ),
              children: beverages,
            ),
            // CustomMultiChildLayout(
            //   delegate: new _CircularLayoutDelegate(
            //     itemCount: items.length,
            //     radius: outerRadius / 1.2,
            //   ),
            //   children: beverages,
            // ),
          ],
        ),
      ),
    );
  }

  // Draw a circle with given radius and color.
  Widget _drawCircle(double radius, Color color) {
    return new Container(
      decoration: new BoxDecoration(shape: BoxShape.circle, color: color),
      width: radius,
      height: radius,
    );
  }

  Widget _buildIcons(int index) {
    // final Widget item = items[index];
    final Widget item = Transform.rotate(
      angle: index * 72.0 * _radiansPerDegree,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            _hasSelected = true;
            itemIndex = index + 1;
          });
        },
        child: new Image.asset(
          'assets/circle/0.png',
          // imageDir + '2' + imageFormat,
          // fit: BoxFit.cover,
        ),
      ),
    );

    return new LayoutId(
      id: 'BUTTON$index',
      child: item,
    );
  }
}

double _calculateItemAngle(int index) {
  double _itemSpacing = 360.0 / 5.0;
  return _startAngle + index * _itemSpacing * _radiansPerDegree;
}

class _CircularLayoutDelegate extends MultiChildLayoutDelegate {
  static const String actionButton = 'BUTTON';

  final int itemCount;
  final double radius;

  _CircularLayoutDelegate({
    required this.itemCount,
    required this.radius,
  });

  late Offset center;

  @override
  void performLayout(Size size) {
    center = new Offset(size.width / 2, size.height / 2);
    for (int i = 0; i < itemCount; i++) {
      final String actionButtonId = '$actionButton$i';

      if (hasChild(actionButtonId)) {
        final Size buttonSize =
            layoutChild(actionButtonId, new BoxConstraints.loose(size));

        final double itemAngle = _calculateItemAngle(i);

        positionChild(
          actionButtonId,
          new Offset(
            (center.dx - buttonSize.width / 2) + (radius) * Math.cos(itemAngle),
            (center.dy - buttonSize.height / 2) +
                (radius) * Math.sin(itemAngle),
          ),
        );
      }
    }
  }

  @override
  bool shouldRelayout(_CircularLayoutDelegate oldDelegate) =>
      itemCount != oldDelegate.itemCount || radius != oldDelegate.radius;
}
