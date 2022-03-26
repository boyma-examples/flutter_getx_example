import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../feature-list-core/domain/feature_list_controller/feature_list_controller.dart';
import '../domain/feature_entering_args.dart';
import '../domain/feature_entering_controller/feature_entering_controller.dart';
import '../domain/message_exception.dart';

class FeatureEntering extends StatelessWidget {
  final FeatureEnteringArgs args;

  const FeatureEntering({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FeatureEnteringController featureEnteringController =
        Get.put(FeatureEnteringController(args));
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Scaffold(
        body: Column(
          children: [
            TextFormField(
              key: const ValueKey("input"),
              keyboardType: TextInputType.number,
              initialValue: featureEnteringController.numField.value.text,
              autofocus: true,
              onChanged: (txt) {
                featureEnteringController.onNumFieldChanged(txt);
              },
            ),
            TextButton(
              onPressed: () {
                try {
                  if (featureEnteringController.numField.value
                      .isValid(context)) {
                    int index = int.parse(
                      featureEnteringController.numField.value.text,
                    );
                    Get.find<FeatureListController>().onSaveNewValue(index);
                    Get.back(result: index);
                  }
                } on MessageException catch (e) {
                  Get.snackbar("Error", e.message);
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
