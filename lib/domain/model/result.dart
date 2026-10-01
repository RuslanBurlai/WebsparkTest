import 'dart:convert';

import 'package:webspark_test/domain/model/coordinate.dart';

class Result {
  final List<Coordinate> steps;
  final String path;

  Result(this.steps, this.path);


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'steps': steps.map((x) => x.toMap()).toList(),
      'path': path
    };
  }

  String toJson() => json.encode(toMap());
}
