import 'package:blueberry/utils/locale/base_language.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  Languages get translate => Languages.of(this);
}
