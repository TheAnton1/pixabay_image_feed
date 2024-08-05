import 'dart:convert';
import 'dart:developer';
import 'package:feed_test/core/network/exceptions.dart';
import 'package:feed_test/features/main_screen/data/models/card_model.dart';
import 'package:http/http.dart' as http;

abstract class ImageRemoteDataSource {
  Future<List<CardModel>> getAllImages(int page);
  Future<List<CardModel>> searchImages(String query, int page);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final http.Client client;
  static const String apiKey = "45143379-b5893fe5f37d14da56cc48a0a";
  static const int perPage = 10;

  ImageRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<CardModel>> getAllImages(int page) => _getImagesFromUrl(
      "https://pixabay.com/api/?key=$apiKey&image_type=photo&page=$page&per_page=$perPage");

  @override
  Future<
      List<
          CardModel>> searchImages(String query, int page) => _getImagesFromUrl(
      "https://pixabay.com/api/?key=$apiKey&q=$query&image_type=photo&page=$page&per_page=$perPage");

  Future<List<CardModel>> _getImagesFromUrl(String url) async {
    try {
      final response = await client.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });
      log(response.headers.toString());
      log(response.statusCode.toString());
      log(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> images = json.decode(response.body);
        final List<CardModel> result = images['hits']
            .map<CardModel>((image) => CardModel.fromjson(image))
            .toList();
        return result;
      } else {
        throw ServerException();
      }
      
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }
}
