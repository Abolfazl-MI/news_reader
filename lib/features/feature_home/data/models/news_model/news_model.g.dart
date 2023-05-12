// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModelSourceModel _$NewsModelSourceModelFromJson(
        Map<String, dynamic> json) =>
    NewsModelSourceModel(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$NewsModelSourceModelToJson(
        NewsModelSourceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
      source: json['source'] == null
          ? null
          : NewsModelSourceModel.fromJson(
              json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
      'source': instance.source,
    };
