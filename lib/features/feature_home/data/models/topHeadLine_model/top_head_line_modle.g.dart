// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_head_line_modle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeadLineNewsSourceModel _$HeadLineNewsSourceModelFromJson(
        Map<String, dynamic> json) =>
    HeadLineNewsSourceModel(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$HeadLineNewsSourceModelToJson(
        HeadLineNewsSourceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

HeadLineNewsModel _$HeadLineNewsModelFromJson(Map<String, dynamic> json) =>
    HeadLineNewsModel(
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
      source: json['source'] == null
          ? null
          : HeadLineNewsSourceModel.fromJson(
              json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HeadLineNewsModelToJson(HeadLineNewsModel instance) =>
    <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
      'source': instance.source,
    };
