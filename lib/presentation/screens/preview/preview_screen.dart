import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webspark_test/domain/model/coordinate.dart';
import 'package:webspark_test/domain/model/path_result.dart';
import 'package:webspark_test/presentation/theme/theme.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({required PathResult pathResult, super.key})
      : _pathResult = pathResult;

  final PathResult _pathResult;

  @override
  Widget build(BuildContext context) {
    final size = _pathResult.deskSize;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size),
              itemCount: pow(size, 2).toInt(),
              itemBuilder: (BuildContext context, int index) =>
                  _buildGridCell(index, size),
            ),
          ),
          Text(_pathResult.hasPath
              ? _pathResult.formattedPath
              : 'Path not available'),
        ],
      ),
    );
  }

  Container _buildGridCell(int index, int size) {
    final point = Coordinate(index % size, index ~/ size);
    return Container(
      decoration: BoxDecoration(
        color: _pointBackground(point),
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          point.toString(),
          style: TextStyle(
              color: _pathResult.isBlocked(point) ? Colors.white : null),
        ),
      ),
    );
  }

  Color _pointBackground(Coordinate point) {
    if (_pathResult.isBlocked(point)) return Colors.black;

    final path = _pathResult.path;
    if (path.isEmpty) return Colors.white;
    if (path.first == point) return startPointColor;
    if (path.last == point) return endPointColor;
    if (path.contains(point)) return mainPointColor;
    return Colors.white;
  }
}
