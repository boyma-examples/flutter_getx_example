import 'package:flutter/cupertino.dart';
import 'package:flutter_getx_example/generated/l10n.dart';

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
    int? intText = int.tryParse(text);
    if (text.isEmpty) {
      throw MessageException(S.of(context).empty_error);
    }
    if (intText == null) {
      throw MessageException(S.of(context).parse_error);
    }
    if (intText > maxNum) {
      throw MessageException(S.of(context).validation_error);
    }
    return true;
  }
}
