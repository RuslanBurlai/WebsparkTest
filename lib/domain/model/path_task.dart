import 'package:webspark_test/domain/model/coordinate.dart';

class PathTask {
  final String id;
  final List<String> field;
  final Coordinate start;
  final Coordinate end;

  const PathTask({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory PathTask.fromJson(Map<String, dynamic> json) => PathTask(
        id: json['id'] as String,
        field: List<String>.from(json['field'] as List),
        start: Coordinate.fromJson(json['start'] as Map<String, dynamic>),
        end: Coordinate.fromJson(json['end'] as Map<String, dynamic>),
      );
}