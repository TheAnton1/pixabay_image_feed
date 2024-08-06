import 'package:feed_test/core/network/exceptions.dart';
import 'package:feed_test/features/main_screen/data/datasources/remote_data_source.dart';
import 'package:feed_test/features/main_screen/data/models/card_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../common/file_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late ImageRemoteDataSource dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ImageRemoteDataSourceImpl(client: mockHttpClient);
  });

  group("Get all images (remote data source)", () {
    int page = 1;
    String apiKey = "45143379-b5893fe5f37d14da56cc48a0a";
    int perPage = 30;
    String uri =
        "https://pixabay.com/api/?key=$apiKey&image_type=photo&page=$page&per_page=$perPage";

    test("Should call a GET method", () async {
      when(() => mockHttpClient.get(Uri.parse(uri))).thenAnswer((_) async {
        return http.Response(readFile("all_images_response.json"), 200);
      });

      await dataSource.getAllImages(page);

      verify(() => mockHttpClient.get(Uri.parse(uri)));
    });
    test("Should return list of card models", () async {
      when(() => mockHttpClient.get(Uri.parse(uri))).thenAnswer((_) async =>
          http.Response(readFile("all_images_response.json"), 200));

      final result = await dataSource.getAllImages(page);

      expect(result, isA<List<CardModel>>());
      expect(
          result[0],
          equals(const CardModel(
              id: 7679117,
              image:
                  "https://pixabay.com/get/g6cbbdcb2441583e08e0aeaaf28153264c61fd1aeca8393d63d19c63463e4282193f66137c43ed5f6856cc36aaa3533cf9ee8746c612f6608eb8046aff36363e0_640.jpg",
              likesAmount: 115,
              viewsAmount: 22298)));
    });

    test("Should throw an ServerException", () async {
      when(() => mockHttpClient.get(Uri.parse(uri)))
          .thenAnswer((_) async => http.Response("Something went wrong", 400));
      expect(() async => await dataSource.getAllImages(page),
          throwsA(isA<ServerException>()));
    });
  });

  group("Search images (remote data source)", () {
    int page = 1;
    String apiKey = "45143379-b5893fe5f37d14da56cc48a0a";
    int perPage = 30;
    String query = "kittens";
    String uri =
        "https://pixabay.com/api/?key=$apiKey&q=$query&image_type=photo&page=$page&per_page=$perPage";
    test("Should call a GET method", () async {
      when(() => mockHttpClient.get(Uri.parse(uri))).thenAnswer((_) async {
        return http.Response(readFile("search_response.json"), 200);
      });

      await dataSource.searchImages(query, page);

      verify(() => mockHttpClient.get(Uri.parse(uri)));
    });
    test("Should return list of card models", () async {
      when(() => mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (_) async => http.Response(readFile("search_response.json"), 200));

      final result = await dataSource.searchImages(query, page);

      expect(result, isA<List<CardModel>>());
      expect(
          result[0],
          equals(const CardModel(
              id: 4558651,
              image:
                  "https://pixabay.com/get/g10eabe1914eeec555e039b99370dcf4cc2e62c8af94211e85e81d30750e2556bc06ac7da4f2bbc9d59bff44ab45fed347e9d4e9b1e0b72509caa7b2bf5b22724_640.jpg",
              likesAmount: 305,
              viewsAmount: 95202)));
    });

    test("Should throw an ServerException", () async {
      when(() => mockHttpClient.get(Uri.parse(uri)))
          .thenAnswer((_) async => http.Response("Something went wrong", 400));

      expect(() async => await dataSource.searchImages(query, page),
          throwsA(isA<ServerException>()));
    });
  });
}
