// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_audition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppliedAuditionModel _$AppliedAuditionModelFromJson(Map<String, dynamic> json) {
  return AppliedAuditionModel(
    auditionUserId: json['auditionUserId'] as String,
    postId: json['postId'] as String,
    auditionDetails: json['auditionDetails'] == null
        ? null
        : AuditionResponse.fromJson(
            json['auditionDetails'] as Map<String, dynamic>),
    vibeUserId: json['vibeUserId'] as String,
    appliedAt: json['appliedAt'] as String,
    status: json['status'] as String,
    statusUpdatedon: json['statusUpdatedon'] as String,
  );
}

Map<String, dynamic> _$AppliedAuditionModelToJson(
        AppliedAuditionModel instance) =>
    <String, dynamic>{
      'auditionUserId': instance.auditionUserId,
      'postId': instance.postId,
      'vibeUserId': instance.vibeUserId,
      'appliedAt': instance.appliedAt,
      'status': instance.status,
      'statusUpdatedon': instance.statusUpdatedon,
      'auditionDetails': instance.auditionDetails,
    };
