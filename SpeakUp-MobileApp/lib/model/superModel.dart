import 'package:json_annotation/json_annotation.dart';
import 'complaintModel.dart';

part 'superModel.g.dart';

@JsonSerializable()
class SuperModel {
  List<ComplaintModel> data;
  SuperModel({this.data});
  factory SuperModel.fromJson(Map<String, dynamic> json) =>
      _$SuperModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelToJson(this);
}
