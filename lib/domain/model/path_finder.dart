import 'dart:collection';

import 'package:webspark_test/domain/model/grid.dart';
import 'package:webspark_test/domain/model/grid_point.dart';

class PathFinder {
  final Grid grid;

  const PathFinder(this.grid);

  List<GridPoint> find(GridPoint start, GridPoint end) {
    if (!grid.isFree(start) || !grid.isFree(end)) return [];

    final parent = <GridPoint, GridPoint?>{start: null};
    final queue = Queue<GridPoint>()..add(start);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      if (current == end) return _restore(current, parent);

      for (final stop in grid.stopsFrom(current)) {
        if (!parent.containsKey(stop)) {
          parent[stop] = current;
          queue.add(stop);
        }
      }
    }
    return [];
  }

  List<GridPoint> _restore(GridPoint end, Map<GridPoint, GridPoint?> parent) {
    final stops = <GridPoint>[];
    for (GridPoint? p = end; p != null; p = parent[p]) {
      stops.add(p);
    }
    final ordered = stops.reversed.toList();

    final path = <GridPoint>[ordered.first];
    for (var i = 1; i < ordered.length; i++) {
      final from = ordered[i - 1];
      final to = ordered[i];
      final dRow = (to.row - from.row).sign;
      final dCol = (to.col - from.col).sign;
      var p = from;
      while (p != to) {
        p = GridPoint(p.row + dRow, p.col + dCol);
        path.add(p);
      }
    }
    return path;
  }
}
