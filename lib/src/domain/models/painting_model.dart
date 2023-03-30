import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:perfect_freehand/perfect_freehand.dart';
import 'package:stories_editor/src/domain/converters/color_converter.dart';
import 'package:stories_editor/src/domain/converters/point_converter.dart';
import 'package:stories_editor/src/presentation/utils/constants/app_enums.dart';
import 'package:uuid/uuid.dart';

part 'painting_model.g.dart';

@PointConverter()
@ColorConverter()
@JsonSerializable(explicitToJson: true)
class PaintingModel {
  /// lines coordinates
  List<Point> points;

  /// The base size (diameter) of the stroke.
  double size = 10;

  /// The effect of pressure on the stroke's size.
  double thinning = 1;

  /// Controls the density of points along the stroke's edges.
  double smoothing = 1;

  /// Whether the line is complete.
  bool isComplete = false;

  /// line Color
  Color lineColor = Colors.black;

  /// Controls the level of variation allowed in the input points.
  double streamline;

  /// Whether to simulate pressure or use the point's provided pressures.
  final bool simulatePressure;

  /// painting type
  PaintingType paintingType = PaintingType.pen;

  String id = const Uuid().v4();

  PaintingModel(
    this.points,
    this.size,
    this.thinning,
    this.smoothing,
    this.isComplete,
    this.lineColor,
    this.streamline,
    this.simulatePressure,
    this.paintingType,
  );

  static PaintingModel fromJson(Map<String, dynamic> json) =>
      _$PaintingModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaintingModelToJson(this);
}
