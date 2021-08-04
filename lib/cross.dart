import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cross extends StatefulWidget {
  @override
  _CrossState createState() => _CrossState();
}

class _CrossState extends State<Cross> {
  /// 图片路径
  static const String imageDir = 'assets/';

  /// 元素大小
  static const double boxSize = 80.0;
  static const double space = 3.0;
  static const double fullBoxSize = boxSize + space * 2;

  /// 行、列元素个数
  static const int columnElement = 5;
  static const int rowElement = 3;

  /// 列高，行宽
  static const double columnHeight = fullBoxSize * columnElement;
  static const double rowWidth = fullBoxSize * rowElement;

  /// 行、列的box的坐标
  int _columnIndex = 0;
  int _rowIndex = 0;

  int rowData = 0;
  double columnData = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cross'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black87,
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ..._buildColumnTargets(),
            ..._buildRowTargets(),
          ],
        ),
      ),
    );
  }

  /// 列：总共有3列（暂定），3个DragTarget
  List<Widget> _buildColumnTargets() {
    List<Widget> columnTargets = [];
    for (int i = 0; i < rowElement; i++) {
      columnTargets.add(Positioned(
        left: fullBoxSize * i,
        top: 0,
        child: _buildColumnTarget(i, (i + 1) * 100),
      ));
    }
    return columnTargets;
  }

  /// 行：总共有5行，5个DragTarget
  List<Widget> _buildRowTargets() {
    List<Widget> rowTargets = [];
    MaterialColor color = Colors.red;
    for (int i = 0; i < columnElement; i++) {
      switch (i) {
        case 1:
          color = Colors.green;
          break;
        case 2:
          color = Colors.blue;
          break;
        case 3:
          color = Colors.yellow;
          break;
        case 4:
          color = Colors.purple;
          break;
      }
      rowTargets.add(Positioned(
        left: 0,
        top: fullBoxSize * i,
        child: _buildRowTarget(i, color),
      ));
    }
    return rowTargets;
  }

  /// 每一个Draggable COLUMN 包在一个DragTarget里面
  Widget _buildColumnTarget(int index, int shade) {
    return DragTarget<double>(
      builder: (BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,) {
        // 不是当前正在显示的COLUMN的话，返回原列大小的Container
        if (index != _columnIndex) {
          return Container(
            height: columnHeight,
            width: fullBoxSize,
          );
        }
        return _buildDraggableColumn(shade);
      },
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          _columnIndex = index;

          // columnData += data.count;
          columnData += data;
          log('Column Target Data: ' + columnData.toString());
          log('Column ' +
              (_columnIndex + 1).toString() +
              ', _columnIndex = ' +
              _columnIndex.toString());
        });
      },
    );
  }

  /// 每一个Draggable ROW 包在一个DragTarget里面
  Widget _buildRowTarget(int index, MaterialColor color) {
    return DragTarget<int>(
      builder: (BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,) {
        // 不是当前正在显示的ROW的话，返回原行大小的Container
        if (index != _rowIndex) {
          return Container(
            height: fullBoxSize,
            width: rowWidth,
          );
        }
        return _buildDraggableRow(color);
      },
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          _rowIndex = index;

          // rowData += data.count;
          rowData += data;
          log('Row Target Data: ' + rowData.toString());
          log('Row ' +
              (_rowIndex + 1).toString() +
              ', _rowIndex = ' +
              _rowIndex.toString());
        });
      },
    );
  }

  /// 每一列包在一个Draggable里面
  Widget _buildDraggableColumn(int shade) {
    return Draggable<double>(
      // Data is the value this Draggable stores.
      data: 10,
      axis: Axis.horizontal,
      child: _buildColumn(shade),
      feedback: Material(child: _buildColumn(shade)),
      childWhenDragging: Container(),
    );
  }

  /// 每一行包在一个Draggable里面
  Widget _buildDraggableRow(MaterialColor color) {
    return Draggable<int>(
      // Data is the value this Draggable stores.
      data: 10,
      axis: Axis.vertical,
      child: _buildRow(color),
      feedback: Material(child: _buildRow(color)),
      childWhenDragging: Container(),
    );
  }

  /// 一列，5个（行）元素
  Widget _buildColumn(int shade) {
    List<Widget> column = [];
    Color color = Colors.red[shade]!;

    for (int i = 0; i < columnElement; i++) {
      switch (i) {
        case 1:
          color = Colors.green[shade]!;
          break;
        case 2:
          color = Colors.blue[shade]!;
          break;
        case 3:
          color = Colors.yellow[shade]!;
          break;
        case 4:
          color = Colors.purple[shade]!;
          break;
      }
      column.add(
        Container(
          margin: EdgeInsets.all(space),
          width: boxSize,
          height: boxSize,
          color: color,
          // child: _buildText((i + 1).toString()),
        ),
      );
    }
    return Container(
      constraints: BoxConstraints(maxHeight: columnHeight),
      // color: const Color.fromRGBO(255, 255, 255, 0),
      child: Column(
        children: column,
      ),
    );
  }

  /// 一行，3个（列）元素
  Widget _buildRow(MaterialColor color) {
    List<Widget> row = [];
    Widget widget;

    for (int i = 0; i < rowElement; i++) {
      // 非相交点 => 返回正常的box
      if (i != _columnIndex) {
        widget = Container(
          decoration: BoxDecoration(
            // color: color[(i + 1) * 100],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.all(space),
          width: boxSize,
          height: boxSize,
          // color: color[(i + 1) * 100],
          // TODO: IMAGE
          child: _buildImage(i + 1),
        );
      } else {
        // 相交点：通过column index判断 => 返回手势检测
        widget = GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              color: color[(i + 1) * 100],
              // borderRadius: BorderRadiusGeometry
            ),
            margin: EdgeInsets.all(space),
            width: boxSize,
            height: boxSize,
            child: _buildImage(i + 1),
          ),
          onTap: () {
            log('Box selected!');
            setState(() {});
          },
        );
      }
      row.add(widget);
    }
    return Container(
      // color: const Color.fromRGBO(255, 255, 255, 0),
      constraints: BoxConstraints(maxWidth: rowWidth),
      child: Row(
        children: row,
      ),
    );
  }

  Widget _buildImage(int index) {
    return Center(
      child: ClipOval(
        child: Image.asset(
          imageDir + index.toString() + '.jpeg',
          color: const Color.fromRGBO(23, 158, 151, 1.0),
          colorBlendMode: BlendMode.modulate,
          height: 70,
          width: 70,
        ),
      ),
    );
  }
}
