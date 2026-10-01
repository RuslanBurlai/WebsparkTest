import 'package:webspark_test/domain/model/coordinate.dart';

class PathResult {
  final String id;
  final List<Coordinate> path;
  final List<String> field;

  const PathResult({
    required this.id,
    required this.path,
    required this.field,
  });

  int get deskSize => field.length;
  bool get hasPath => path.isNotEmpty;
  String get formattedPath => path.map((p) => p.toString()).join('->');

  bool isBlocked(Coordinate c) => field[c.y][c.x] == 'X';

  Map<String, dynamic> toJson() => {
        'id': id,
        'path': formattedPath,
      };
}
