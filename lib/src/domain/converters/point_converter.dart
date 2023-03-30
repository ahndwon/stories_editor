import 'package:json_annotation/json_annotation.dart';
import 'package:perfect_freehand/perfect_freehand.dart';

class PointConverter implements JsonConverter<Point, Map<String, dynamic>> {
  const PointConverter();

  @override
  Point fromJson(Map<String, dynamic> json) => Point(
        json['x'] as double,
        json['y'] as double,
        json['p'] as double,
      );

  @override
  Map<String, dynamic> toJson(Point value) => {
        'x': value.x,
        'y': value.y,
        'p': value.p,
      };
}
