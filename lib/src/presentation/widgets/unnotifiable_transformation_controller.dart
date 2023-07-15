import 'package:flutter/material.dart';

class UnNotifiableTransformationController extends TransformationController {
  UnNotifiableTransformationController([Matrix4? value])
      : super(value ?? Matrix4.identity()) {
    _value = value ?? Matrix4.identity();
  }

  @override
  Matrix4 get value => _value;
  late Matrix4 _value;

  @override
  set value(Matrix4 newValue) {
    if (_value == newValue) {
      return;
    }
    _value = newValue;
    notifyListeners();
  }

  // ignore: use_setters_to_change_properties
  void unNotifiedSetValue(Matrix4 newValue) {
    _value = newValue;
  }
}
