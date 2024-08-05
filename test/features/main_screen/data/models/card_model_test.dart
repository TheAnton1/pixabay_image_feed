import 'dart:convert';

import 'package:feed_test/features/main_screen/data/models/card_model.dart';
import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../common/card_entity_example.dart';
import '../../../../common/file_reader.dart';

void main() {
  
  const modelExample = CardEntityExamples.modelExample;

  group("card model tests", () {
    test("should be a subclass of entity", () {
      expect(modelExample, isA<CardEntity>());
    });

    test("fromJson should create card model", () {
      final jsonFile = readFile('one_image.json');
      final image = json.decode(jsonFile);

      expect(CardModel.fromjson(image), modelExample);
    });
  });
}