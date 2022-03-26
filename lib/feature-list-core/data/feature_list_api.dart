import 'dart:math';

import 'models/item_dto.dart';

const uniqItems = {
  "sprite": "http://assets.stickpng.com/thumbs/580b57fcd9996e24bc43c1ed.png",
  "cola": "https://crispycrust.no/wp-content/uploads/2018/11/05Cola.png",
};

class FeatureListApi {
  Future<List<SomeItemDto>> loadData() async {
    var r = getRandomNumber(5, 10);
    print("r:$r");
    List<SomeItemDto> list = List.generate(r, (index) {
      return generateItem();
    });
    return Future.value(list);
  }

  getRandomNumber(int min, int max) {
    Random rnd = Random();
    var r = min + rnd.nextInt(max - min);
    return r;
  }

  SomeItemDto generateItem() {
    var choosenIndexOfElement = getRandomNumber(0, uniqItems.length);
    return SomeItemDto(uniqItems.keys.elementAt(choosenIndexOfElement),
        uniqItems.values.elementAt(choosenIndexOfElement));
  }
}
