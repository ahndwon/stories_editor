import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class Matrix4Converter implements JsonConverter<Matrix4, List<dynamic>> {
  const Matrix4Converter();

  @override
  Matrix4 fromJson(List<dynamic> value) {
    final matrixList = Float64List.fromList(
      value.map((e) => double.parse(e.toString())).toList(),
    );
    return Matrix4.fromFloat64List(matrixList);
  }

  @override
  List<double> toJson(Matrix4 value) => value.storage.toList();
}
