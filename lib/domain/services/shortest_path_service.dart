import 'package:webspark_test/domain/model/coordinate.dart';
import 'package:webspark_test/domain/model/grid.dart';
import 'package:webspark_test/domain/model/grid_point.dart';
import 'package:webspark_test/domain/model/path_finder.dart';
import 'package:webspark_test/domain/model/path_result.dart';
import 'package:webspark_test/domain/model/path_task.dart';

abstract interface class ShortestPathService {
  PathResult solve(PathTask task);
  List<PathResult> solveAll(Iterable<PathTask> tasks);
}

class ShortestPathServiceImpl implements ShortestPathService{
  final bool xIsRow;

  const ShortestPathServiceImpl({this.xIsRow = false});

  List<Coordinate> _findPath(
    List<String> field,
    Coordinate start,
    Coordinate end,
  ) {
    final grid = Grid.fromRows(field);
    final cells = PathFinder(grid).find(_toCell(start), _toCell(end));
    return cells.map(_toCoordinate).toList();
  }

  @override
  PathResult solve(PathTask task) =>
      PathResult(id: task.id, path: _findPath(task.field, task.start, task.end), field: task.field);

  @override
  List<PathResult> solveAll(Iterable<PathTask> tasks) =>
      tasks.map(solve).toList();

  GridPoint _toCell(Coordinate c) =>
      xIsRow ? GridPoint(c.x, c.y) : GridPoint(c.y, c.x);

  Coordinate _toCoordinate(GridPoint p) =>
      xIsRow ? Coordinate(p.row, p.col) : Coordinate(p.col, p.row);
}
