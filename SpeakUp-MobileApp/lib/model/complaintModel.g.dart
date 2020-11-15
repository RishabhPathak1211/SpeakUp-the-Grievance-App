// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaintModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintModel _$AddBlogModelFromJson(Map<String, dynamic> json) {
  return ComplaintModel(
    date: json['date'] as String,
    id: json['_id'] as String,
    category: json['category'] as String,
  );
}

Map<String, dynamic> _$AddBlogModelToJson(ComplaintModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      '_id': instance.id,
      'category': instance.category,
    };
