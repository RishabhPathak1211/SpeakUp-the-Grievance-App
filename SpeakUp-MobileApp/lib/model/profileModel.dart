import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String username;
  String rollNo;
  String email;
  String year;
  String dept;
  ProfileModel({
    this.username,
    this.rollNo,
    this.email,
    this.year,
    this.dept,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
