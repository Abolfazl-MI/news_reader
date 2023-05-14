import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_reader/config/api_constants.dart';
import 'package:news_reader/common/error_handling/check_exceptions.dart';

class NewsApiProvider {
  final Dio _dio;
  NewsApiProvider({required Dio dio}) : _dio = dio;

  Future<dynamic> getTopHeadLines() async {
    log('Requesting =>${ApiUrls.baseUrl}${ApiUrls.topHeadLineNews}');
    final response = await _dio.get(
      '${ApiUrls.baseUrl}${ApiUrls.topHeadLineNews}',
      queryParameters: {
        'country': 'us',
        'pageSize': 10,
        'apiKey': apiKey,
      },
    ).onError(
      (DioError error, stackTrace) => CheckExceptions.response(error.response!),
    );
    log('Req to =>${response.requestOptions.path},status:${response.statusCode}');
    return response;
  }

  Future<dynamic> getNewsByTopic(String topic) async {
    log('Requesting=>${ApiUrls.baseUrl}${ApiUrls.getTopicNews}');
    final response =await
        _dio.get('${ApiUrls.baseUrl}${ApiUrls.getTopicNews}', queryParameters: {
      'q': topic,
      'sortBy': 'popularity',
      'pageSize': 10,
      'sortBy': 'relevancy',
      'apiKey': apiKey,
    }).onError(
      (DioError error, stackTrace) => CheckExceptions.response(
        error.response!,
      ),
    );
    log('Req to =>${response.requestOptions.path},status:${response.statusCode}');
    return response;
  }
}
