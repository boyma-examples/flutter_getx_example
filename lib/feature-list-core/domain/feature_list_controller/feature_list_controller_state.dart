import '../../data/models/item_dto.dart';

class FeatureListControllerState {}

class FeatureListControllerStateError extends FeatureListControllerState {}

class FeatureListControllerStateProgress extends FeatureListControllerState {}

class FeatureListControllerStateData extends FeatureListControllerState {
  final List<SomeItemDto> list;
  final int? choosedIndex;

  FeatureListControllerStateData({required this.list, this.choosedIndex});

  FeatureListControllerStateData copyWith({
    List<SomeItemDto>? list,
    int? choosedIndex,
  }) {
    return FeatureListControllerStateData(
      list: list ?? this.list,
      choosedIndex: choosedIndex ?? this.choosedIndex,
    );
  }
}
