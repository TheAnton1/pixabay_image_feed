import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';
import 'package:flutter/material.dart';

class ImageDetailScreenUI extends StatelessWidget {
  final CardEntity imageDetail;
  const ImageDetailScreenUI({required this.imageDetail, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Hero(
        tag: "${imageDetail.id}",
        child: Container(
          alignment: Alignment.topCenter,
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageDetail.image),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
