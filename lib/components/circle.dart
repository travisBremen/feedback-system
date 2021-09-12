import 'dart:developer';

import 'package:flutter/gestures.dart';
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

  int selectedIndex = -1;
  int itemIndex = 1;
  int itemCount = 5;
  bool _hasSelected = false;
  int _hoveringIndex = -1;
  double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      // height: 400,
      decoration: new BoxDecoration(color: Colors.grey),
      // width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildStackView(),
            _buildSlider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return Container(
      width: 200,
      child: Slider(
        value: _currentSliderValue,
        min: 1,
        max: 3,
        divisions: 2,
        label: _currentSliderValue.toString(),
        activeColor: Color(0xFF179E97),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }

  Widget _buildStackView() {
    final List<Widget> items = <Widget>[];
    final List<Widget> icons = _buildIcons();

    double width = 300;
    double height = 300;
    // double outerRadius = Math.min(width * 3 / 4, height * 3 / 4);
    double outerRadius = 200;
    double innerWhiteRadius = outerRadius * 3 / 4;

    for (int i = 0; i < itemCount; i++) {
      items.add(_buildItems(i));
    }

    return Flexible(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: new Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            _drawCircle(outerRadius + 35, Color.fromRGBO(255, 255, 255, 1.0)),
            Visibility(
              visible: _hasSelected,
              child: GestureDetector(
                onTap: () {
                  log('Box ' + itemIndex.toString() + ' selected!');
                },
                child: ClipOval(
                  child: Image.asset(
                    imageDir + itemIndex.toString() + imageFormat,
                    color: Color.fromRGBO(
                        23, 158, 151, _currentSliderValue / 3),
                    colorBlendMode: BlendMode.multiply,
                    width: innerWhiteRadius,
                    height: innerWhiteRadius,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            CustomMultiChildLayout(
              delegate: new _CircularLayoutDelegate(
                itemCount: itemCount,
                radius: outerRadius / 2.16,
              ),
              children: items,
            ),
            CustomMultiChildLayout(
              delegate: _CircularOuterLayoutDelegate(
                itemCount: itemCount,
                radius: outerRadius / 1.3,
              ),
              children: icons,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItems(int index) {
    String image;
    if (selectedIndex == index)
      image = '1';
    else
      image = '0';

    // final Widget item = items[index];
    final Widget item = Transform.rotate(
      angle: index * 72.0 * _radiansPerDegree,
      child: InkWell(
        onTap: () {
          setState(() {
            _hasSelected = true;
            itemIndex = index + 1;
            selectedIndex = index;
          });
        },
        child: MouseRegion(
          onEnter: (PointerEnterEvent details) {
            setState(() {
              _hoveringIndex = index;
            });
          },
          onExit: (PointerExitEvent details) {
            setState(() {
              _hoveringIndex = -1;
            });
          },
          child: Image.asset(
            'assets/circle/' + image + '.png',
          ),
        ),
      ),
    );

    return new LayoutId(
      id: 'BUTTON$index',
      child: item,
    );
  }

  List<Widget> _buildIcons() {
    List<Widget> icons = [];
    for (int i = 0; i < itemCount; i++) {
      icons.add(LayoutId(
        id: 'ICON$i',
        child: Visibility(
          visible: i == _hoveringIndex,
          child: MaterialButton(
            onPressed: () {},
            child: ClipOval(
              child: Image.asset(
                imageDir + (i + 1).toString() + imageFormat,
                width: 50,
                height: 50,
              ),
            ),
          ),
        ),
      ));
    }
    return icons;
  }
}

// Draw a circle with given radius and color.
Widget _drawCircle(double radius, Color color) {
  return new Container(
    decoration: new BoxDecoration(shape: BoxShape.circle, color: color),
    width: radius,
    height: radius,
  );
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

class _CircularOuterLayoutDelegate extends MultiChildLayoutDelegate {
  static const String actionButton = 'ICON';

  final int itemCount;
  final double radius;

  _CircularOuterLayoutDelegate({
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
  bool shouldRelayout(_CircularOuterLayoutDelegate oldDelegate) =>
      itemCount != oldDelegate.itemCount || radius != oldDelegate.radius;
}
