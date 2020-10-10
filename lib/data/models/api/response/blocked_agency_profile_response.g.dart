// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_agency_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockedAgencyProfileResponse _$BlockedAgencyProfileResponseFromJson(
    Map<String, dynamic> json) {
  return BlockedAgencyProfileResponse(
    success: json['success'] as String,
    data: (json['data'] as List)
        ?.map((e) => (e as List)
            ?.map((e) => e == null
                ? null
                : AgencyProfileResponse.fromJson(e as Map<String, dynamic>))
            ?.toList())
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$BlockedAgencyProfileResponseToJson(
        BlockedAgencyProfileResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
