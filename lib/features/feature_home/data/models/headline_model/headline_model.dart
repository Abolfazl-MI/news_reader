import 'package:json_annotation/json_annotation.dart';
part 'headline_model.g.dart';

@JsonSerializable()
class HeadLineNewsModel {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;

  const HeadLineNewsModel({
    this.description,
    this.publishedAt,
    this.title,
    this.url,
    this.urlToImage,
  });

  factory HeadLineNewsModel.fromJson(Map<String, dynamic> json) =>
      _$HeadLineNewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HeadLineNewsModelToJson(this);

  String getTimeDifference() {
    int difference = DateTime.now().difference(publishedAt!).inHours;
    return "${difference}h ago";
  }
}
