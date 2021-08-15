import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cross extends StatefulWidget {
  final Function(int index, double opacity) onSelect;

  Cross({required this.onSelect});

  @override
  _CrossState createState() => _CrossState();
}

class _CrossState extends State<Cross> {
  /// 图片路径
  static const String imageDir = 'assets/';

  /// 元素大小
  static const double boxSize = 70.0;
  static const double space = 3.0;
  static const double fullBoxSize = boxSize + space * 2;

  static const double imageSize = boxSize - 20;

  /// 行、列元素个数
  static const int columnElement = 5;
  static const int rowElement = 3;

  /// 列高，行宽
  // 76 * 5 = 380
  static const double columnHeight = fullBoxSize * columnElement;

  // 76 * 3 = 228
  static const double rowWidth = fullBoxSize * rowElement;

  /// 行、列的box的坐标
  int _columnIndex = 0;
  int _rowIndex = 0;

  int rowData = 0;
  double columnData = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black87,
      width: rowWidth,
      height: columnHeight,
      // constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ..._buildColumnTargets(),
          ..._buildRowTargets(),
        ],
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
        child: _buildColumnTarget(i),
      ));
    }
    return columnTargets;
  }

  /// 行：总共有5行，5个DragTarget
  List<Widget> _buildRowTargets() {
    List<Widget> rowTargets = [];
    for (int i = 0; i < columnElement; i++) {
      rowTargets.add(Positioned(
        left: 0,
        top: fullBoxSize * i,
        child: _buildRowTarget(i),
      ));
    }
    return rowTargets;
  }

  /// 每一个Draggable COLUMN 包在一个DragTarget里面
  Widget _buildColumnTarget(int index) {
    return DragTarget<double>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        // 不是当前正在显示的COLUMN的话，返回原列大小的Container
        if (index != _columnIndex) {
          return Container(
            height: columnHeight,
            width: fullBoxSize,
          );
        }
        return _buildDraggableColumn(index);
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
  Widget _buildRowTarget(int index) {
    return DragTarget<int>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        // 不是当前正在显示的ROW的话，返回原行大小的Container
        if (index != _rowIndex) {
          return Container(
            height: fullBoxSize,
            width: rowWidth,
          );
        }
        return _buildDraggableRow(index);
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
  Widget _buildDraggableColumn(int columnIndex) {
    return Draggable<double>(
      // Data is the value this Draggable stores.
      data: 10,
      axis: Axis.horizontal,
      child: _buildColumn(columnIndex),
      feedback: Material(child: _buildColumn(columnIndex)),
      childWhenDragging: Container(),
    );
  }

  /// 每一行包在一个Draggable里面
  Widget _buildDraggableRow(int rowIndex) {
    return Draggable<int>(
      // Data is the value this Draggable stores.
      data: 10,
      axis: Axis.vertical,
      child: _buildRow(rowIndex),
      feedback: Material(child: _buildRow(rowIndex)),
      childWhenDragging: Container(),
    );
  }

  /// 一列，5个（行）元素
  Widget _buildColumn(int columnIndex) {
    List<Widget> column = [];
    for (int i = 0; i < columnElement; i++) {
      column.add(_buildBox(i, columnIndex));
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
  Widget _buildRow(int rowIndex) {
    List<Widget> row = [];
    Widget widget;
    for (int i = 0; i < rowElement; i++) {
      // 非相交点 => 返回正常的box
      if (i != _columnIndex) {
        widget = _buildBox(rowIndex, i);
      } else {
        // 相交点：通过column index判断 => 返回手势检测
        widget = GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xFF23DFD5), width: 6.0),
            ),
            margin: EdgeInsets.all(space),
            width: boxSize,
            height: boxSize,
            child: _buildImage(rowIndex + 1, (i + 1) / 3),
          ),
          onTap: () {
            log('Box selected!');
            this.widget.onSelect(rowIndex + 1, (i + 1) / 3);
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

  Widget _buildBox(int rowIndex, int columnIndex) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(space),
      width: boxSize,
      height: boxSize,
      child: _buildImage(rowIndex + 1, (columnIndex + 1) / 3),
    );
  }

  Widget _buildImage(int rowIndex, double opacity) {
    return Center(
      child: ClipOval(
        child: Image.asset(
          imageDir + rowIndex.toString() + '.jpeg',
          color: Color.fromRGBO(23, 158, 151, opacity), // #179E97
          // modulate / multiply / darken /src
          colorBlendMode: BlendMode.multiply,
          height: imageSize,
          width: imageSize,
        ),
      ),
    );
  }
}
