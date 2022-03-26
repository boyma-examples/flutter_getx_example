import 'feature_list_api.dart';
import 'models/item_dto.dart';

abstract class FeatureListRepository {
  Stream<List<SomeItemDto>> loadData();

  Stream generateItem();
}

class FeatureListRepositoryImpl extends FeatureListRepository {
  final FeatureListApi featureApi;

  FeatureListRepositoryImpl(this.featureApi);

  @override
  Stream<List<SomeItemDto>> loadData() {
    return Stream.fromFuture(featureApi.loadData());
  }

  @override
  Stream<SomeItemDto> generateItem() {
    return Stream.value(featureApi.generateItem());
  }
}
