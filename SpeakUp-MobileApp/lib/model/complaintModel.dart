import 'package:json_annotation/json_annotation.dart';

part 'complaintModel.g.dart';

@JsonSerializable()
class ComplaintModel {
  String date;
  String category;
  @JsonKey(name: "_id")
  String id;

  ComplaintModel({
    this.date,
    this.category,
    this.id,
  });
  factory ComplaintModel.fromJson(Map<String, dynamic> json) =>
      _$AddBlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddBlogModelToJson(this);
}
