// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleListResponse _$RoleListResponseFromJson(Map<String, dynamic> json) {
  return RoleListResponse(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : RoleModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    success: json['success'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$RoleListResponseToJson(RoleListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'message': instance.message,
    };
