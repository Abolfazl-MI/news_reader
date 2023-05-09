import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_reader/common/error_handling/app_exceptions.dart';
import 'package:news_reader/common/error_handling/check_exceptions.dart';
import 'package:news_reader/common/resources/data_state.dart';
import 'package:news_reader/features/feature_home/data/data_source/news_api_provider.dart';
import 'package:news_reader/features/feature_home/data/models/topHeadLine_model/top_head_line_modle.dart';

class HomeNewsRepository {
  final NewsApiProvider _newsApiProvider;
  const HomeNewsRepository({required NewsApiProvider newsApiProvider})
      : _newsApiProvider = newsApiProvider;

  ///fetches the headline news of the country
  Future<DataState<List<NewsModel>>> fetchHeadLineNews() async {
    try {
      final Response response = await _newsApiProvider.getTopHeadLines();
      final rawData = response.data['articles'];
      List<NewsModel> headLineNews =
          rawData.map((e) => NewsModel.fromJson(e)).toList();
      return DataSuccess(headLineNews);
    } on AppException catch (e) {
      return await CheckExceptions.getError(e);
    }
  }

  /// fetch the topic news from endpoint
  Future<DataState<List<NewsModel>>> getNewsBaseOnTopic(String topic) async {
    try {
      final Response response = await _newsApiProvider.getNewsByTopic(topic);
      final rawData = response.data['articles'];
      List<NewsModel> topicNews =
          rawData.map((e) => NewsModel.fromJson(e)).toList();
      return DataSuccess(topicNews);
    } on AppException catch (e) {
      return await CheckExceptions.getError(e);
    }
  }
}
