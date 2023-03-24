import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class OffsetConverter implements JsonConverter<Offset, Map<String, dynamic>> {
  const OffsetConverter();

  @override
  Offset fromJson(Map<String, dynamic> value) => Offset(
        value['dx'] as double,
        value['dy'] as double,
      );

  @override
  Map<String, dynamic> toJson(Offset value) => {
        'dx': value.dx,
        'dy': value.dy,
      };
}
