import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_head_line_modle.g.dart';

@JsonSerializable()
@immutable
class HeadLineNewsSourceModel extends Equatable {
  final String? name;

  const HeadLineNewsSourceModel({this.name});

  factory HeadLineNewsSourceModel.fromJson(Map<String, dynamic> json) =>
      _$HeadLineNewsSourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$HeadLineNewsSourceModelToJson(this);

  @override
  List<Object?> get props => [name];
  @override
  String toString() => 'HeadLineNewsSource(name:$name)';
}

@JsonSerializable()
@immutable
class HeadLineNewsModel extends Equatable {
  final String? author;
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  @JsonKey(name: 'source')
  final HeadLineNewsSourceModel? source;
  const HeadLineNewsModel(
      {this.author,
      this.title,
      this.description,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.source});

  factory HeadLineNewsModel.fromJson(Map<String, dynamic> json) =>
      _$HeadLineNewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HeadLineNewsModelToJson(this);

  @override
  String toString() => 'TopHeadLineNews(title:$title,content:$content)';

  @override
  List<Object?> get props => [
        author,
        title,
        description,
        urlToImage,
        publishedAt,
        content,
        source,
      ];
}
