import 'package:flutter/cupertino.dart';

import '../message_exception.dart';

abstract class ValidationField {
  final String text;

  ValidationField({
    required this.text,
  });

  isValid(BuildContext context);
}

class NumField extends ValidationField {
  final int maxNum;

  NumField({
    required String text,
    required this.maxNum,
  }) : super(text: text);

  NumField copyWith({
    int? maxNum,
    String? text,
  }) {
    return NumField(
      text: text ?? this.text,
      maxNum: maxNum ?? this.maxNum,
    );
  }

  @override
  isValid(BuildContext context) {
    if (text.isEmpty) throw MessageException("isEmpty");
    int? intText = int.tryParse(text);
    if (intText == null) throw MessageException("Parse error");
    if (intText > maxNum) throw MessageException("Validation error");
    return true;
  }
}
