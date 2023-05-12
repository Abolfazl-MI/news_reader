// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'headline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeadLineNewsModel _$HeadLineNewsModelFromJson(Map<String, dynamic> json) =>
    HeadLineNewsModel(
      description: json['description'] as String?,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      title: json['title'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
    );

Map<String, dynamic> _$HeadLineNewsModelToJson(HeadLineNewsModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt?.toIso8601String(),
    };
