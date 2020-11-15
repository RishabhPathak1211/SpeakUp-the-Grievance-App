// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    username: json['username'] as String,
    rollNo: json['rollNo'] as String,
    email: json['email'] as String,
    dept: json['dept'] as String,
    year: json['year'] as String,
  );
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'rollNo': instance.rollNo,
      'email': instance.email,
      'dept': instance.dept,
      'year': instance.year,
    };
