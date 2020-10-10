// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_agency_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllAgencyProfileResponse _$AllAgencyProfileResponseFromJson(
    Map<String, dynamic> json) {
  return AllAgencyProfileResponse(
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AgencyProfileResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    success: json['success'] as String,
  );
}

Map<String, dynamic> _$AllAgencyProfileResponseToJson(
        AllAgencyProfileResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'success': instance.success,
    };
