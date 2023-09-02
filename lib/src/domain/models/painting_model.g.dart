// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaintingModel _$PaintingModelFromJson(Map<String, dynamic> json) =>
    PaintingModel(
      (json['points'] as List<dynamic>)
          .map(
              (e) => const PointConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['size'] as num).toDouble(),
      (json['thinning'] as num).toDouble(),
      (json['smoothing'] as num).toDouble(),
      json['isComplete'] as bool,
      const ColorConverter().fromJson(json['lineColor'] as String),
      (json['streamline'] as num).toDouble(),
      json['simulatePressure'] as bool,
      $enumDecode(_$PaintingTypeEnumMap, json['paintingType']),
    )..id = json['id'] as String;

Map<String, dynamic> _$PaintingModelToJson(PaintingModel instance) =>
    <String, dynamic>{
      'points': instance.points.map(const PointConverter().toJson).toList(),
      'size': instance.size,
      'thinning': instance.thinning,
      'smoothing': instance.smoothing,
      'isComplete': instance.isComplete,
      'lineColor': const ColorConverter().toJson(instance.lineColor),
      'streamline': instance.streamline,
      'simulatePressure': instance.simulatePressure,
      'paintingType': _$PaintingTypeEnumMap[instance.paintingType]!,
      'id': instance.id,
    };

const _$PaintingTypeEnumMap = {
  PaintingType.pen: 'pen',
  PaintingType.marker: 'marker',
  PaintingType.neon: 'neon',
};
