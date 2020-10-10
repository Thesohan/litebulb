// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) {
  return CommentResponse(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CommentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    success: json['success'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'message': instance.message,
    };
