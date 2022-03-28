import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../feature_entering_args.dart';
import 'inputfields.dart';

class FeatureEnteringController extends GetxController {
  final numField = NumField(maxNum: 0, text: '').obs;

  FeatureEnteringController(FeatureEnteringArgs args) {
    numField.value = NumField(
      maxNum: args.maxNumber,
      text: args.numberIndex.toString(),
    );
  }

  void onNumFieldChanged(String txt) {
    numField.value = numField.value.copyWith(text: txt);
  }

  bool validFields(BuildContext context) {
    numField.value.isValid(context);
    return true;
  }
}
