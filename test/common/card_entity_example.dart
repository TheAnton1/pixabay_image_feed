import 'package:feed_test/features/main_screen/data/models/card_model.dart';
import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';

class CardEntityExamples {
  static const entityExample = CardEntity(
      id: 12879,
      image:
          "https://pixabay.com/get/g6cbbdcb2441583e08e0aeaaf28153264c61fd1aeca8393d63d19c63463e4282193f66137c43ed5f6856cc36aaa3533cf9ee8746c612f6608eb8046aff36363e0_640.jpg",
      likesAmount: 100,
      viewsAmount: 200);

  static const modelExample = CardModel(
      id: 7679117,
      image:
          "https://pixabay.com/get/g6cbbdcb2441583e08e0aeaaf28153264c61fd1aeca8393d63d19c63463e4282193f66137c43ed5f6856cc36aaa3533cf9ee8746c612f6608eb8046aff36363e0_640.jpg",
      likesAmount: 115,
      viewsAmount: 22298);
}
