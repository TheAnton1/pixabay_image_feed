import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final int id;
  final String image;
  final int likesAmount;
  final int viewsAmount;

  const CardEntity(
      {required this.id,
      required this.image,
      required this.likesAmount,
      required this.viewsAmount});

    

  @override
  List<Object?> get props => [id, image, likesAmount, viewsAmount];
}
