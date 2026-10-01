import 'package:webspark_test/domain/model/grid_point.dart';

class Grid {
  static const String blocked = 'X';
  static const List<List<int>> _directions = [
    [-1, -1], [-1, 1], [1, -1], [1, 1],
    [-1, 0], [1, 0], [0, -1], [0, 1],
  ];

  final int size;
  final List<String> _rows;

  Grid._(this.size, this._rows);

  factory Grid.fromRows(List<String> rows) {
    final size = rows.length;
    if (size <= 1 || size >= 100) {
      throw RangeError('Grid length must be > 1 and < 100');
    }
    if (rows.any((r) => r.length != size)) {
      throw ArgumentError('Grid must be square');
    }
    return Grid._(size, List.unmodifiable(rows));
  }

  bool isInside(GridPoint p) =>
      p.row >= 0 && p.col >= 0 && p.row < size && p.col < size;

  bool isFree(GridPoint p) => isInside(p) && _rows[p.row][p.col] != blocked;

  Iterable<GridPoint> stopsFrom(GridPoint from) sync* {
    for (final d in _directions) {
      var last = from;
      var next = GridPoint(from.row + d[0], from.col + d[1]);
      while (isFree(next)) {
        last = next;
        next = GridPoint(next.row + d[0], next.col + d[1]);
      }
      if (last != from) yield last;
    }
  }
}