import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/feature_list_repository.dart';
import '../../data/models/item_dto.dart';
import 'feature_list_controller_state.dart';

class FeatureListController extends GetxController {
  final FeatureListRepository featureListRepository;

  FeatureListController({
    required this.featureListRepository,
  });

  final state = FeatureListControllerState().obs;

  final _subs = CompositeSubscription();

  @override
  void onClose() {
    _subs.clear();
    super.onClose();
  }

  void loadData() {
    print("loadData");
    state.value = FeatureListControllerStateProgress();
    featureListRepository.loadData().listen(
      (data) {
        state.value = FeatureListControllerStateData(list: data);
      },
      onError: (e) {
        state.value = FeatureListControllerStateError();
      },
    ).addTo(_subs);
  }

  void onAddItemClick() {
    featureListRepository.generateItem().listen(
      (data) {
        state.value = dataState().copyWith(
          list: dataState().list..add(data),
        );
      },
      onError: (e) {
        state.value = FeatureListControllerStateError();
      },
    ).addTo(_subs);
  }

  void onDeleteItemClick(SomeItemDto e) {
    state.value = dataState().copyWith(
      list: dataState().list..remove(e),
    );
  }

  FeatureListControllerStateData dataState() {
    return state.value as FeatureListControllerStateData;
  }

  void onSaveNewValue(int choosedIndex) {
    print("onSaveNewValue");
    state.value = dataState().copyWith(choosedIndex: choosedIndex);
  }
}
