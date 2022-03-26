import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../feature-entering/domain/feature_entering_args.dart';
import '../../feature-entering/ui/feature_entering.dart';
import '../../feature-list-core/domain/feature_list_controller/feature_list_controller.dart';
import '../../feature-list-core/domain/feature_list_controller/feature_list_controller_state.dart';

class FeatureListBody extends StatelessWidget {
  final Size size;
  final scrollController = ScrollController();
  final double horItemWidth = 100.0;
  final double horItemPaddingLeft = 8.0;
  final double horItemHeight = 150.0;

  FeatureListBody({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<FeatureListController>(
      builder: (controller) {
        final state = controller.state.value;
        if (state is FeatureListControllerStateData) {
          var list = List.generate(
            state.list.length,
            (index) => Padding(
              padding: EdgeInsets.only(left: horItemPaddingLeft),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    _navToFeatureEntering(
                      index,
                      state.list.length,
                      scrollController,
                    );
                  },
                  child: Container(
                    height: horItemHeight,
                    width: horItemWidth,
                    color: index == state.choosedIndex
                        ? Colors.purple
                        : Colors.lightBlueAccent,
                    child: Center(child: Text(index.toString())),
                  ),
                ),
              ),
            ),
          );
          return Container(
            color: Colors.grey,
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: horItemHeight,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(children: list),
                  ),
                ),
                const SizedBox(
                  height: 715,
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  _navToFeatureEntering(
    int index,
    int maxCount,
    ScrollController scrollController,
  ) async {
    int? newValue = await Get.to(
      () => FeatureEntering(
        args: FeatureEnteringArgs(
          numberIndex: index,
          maxNumber: maxCount - 1,
        ),
      ),
    );
    if (newValue != null) {
      _scroll(scrollController, newValue, horItemWidth + horItemPaddingLeft);
    }
  }

  _scroll(
    ScrollController scrollController,
    int i,
    double horItemWidth,
  ) {
    if (scrollController.hasClients == false) return;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      var maxVisibleItems = size.width / (horItemWidth);
      var aLength = maxVisibleItems * horItemWidth;
      var bLength = (maxVisibleItems.toInt() + 1) * horItemWidth;
      var offset = bLength - aLength;

      var sc = 0.0;
      if (i >= maxVisibleItems.toInt()) {
        sc = offset + (i - maxVisibleItems.toInt()) * horItemWidth;
      }

      scrollController.position.animateTo(
        sc,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }
}
