class Coordinate {
  final int x;
  final int y;

  const Coordinate(this.x, this.y);

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      Coordinate(json['x'] as int, json['y'] as int);

  Map<String, int> toJson() => {'x': x, 'y': y};

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'x': x.toString(),
      'y': y.toString(),
    };
  }

  @override
  bool operator ==(Object other) =>
      other is Coordinate && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => '($x,$y)';
}
