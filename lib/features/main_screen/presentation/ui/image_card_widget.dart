import 'package:feed_test/core/common/dimen.dart';
import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';
import 'package:feed_test/features/details_screen/presentation/ui/image_screen_ui.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final CardEntity cardEntity;
  const ImageCard({super.key, required this.cardEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                      ImageDetailScreenUI(imageDetail: cardEntity),
                  ),
                );
              },
              child: Hero(
                tag: "${cardEntity.id}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimen.radius4),
                  child: Image.network(cardEntity.image),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    color: Colors.grey[400],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: Dimen.paddingHorizontal5),
                    child: Text(
                      cardEntity.likesAmount.toString(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey[400],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: Dimen.paddingHorizontal5),
                    child: Text(
                      cardEntity.viewsAmount.toString(),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
