import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';

class CardModel extends CardEntity {
  const CardModel(
      {required id, required image, required likesAmount, required viewsAmount})
      : super(
            id: id,
            image: image,
            likesAmount: likesAmount,
            viewsAmount: viewsAmount);
  factory CardModel.fromjson(Map<String, dynamic> json) {
    return CardModel(
        id: json['id'],
        image: json['webformatURL'],
        likesAmount: json['likes'],
        viewsAmount: json['views']);
  }
}
