// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_cred_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CredResponse _$CredResponseFromJson(Map<String, dynamic> json) {
  return CredResponse(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CreditModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    success: json['success'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CredResponseToJson(CredResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'message': instance.message,
    };
