// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_or_unblock_agency_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockOrUnblockAgencyRequest _$BlockOrUnblockAgencyRequestFromJson(
    Map<String, dynamic> json) {
  return BlockOrUnblockAgencyRequest(
    agencyid: json['agencyid'] as String,
    artistid: json['artistid'] as String,
  );
}

Map<String, dynamic> _$BlockOrUnblockAgencyRequestToJson(
        BlockOrUnblockAgencyRequest instance) =>
    <String, dynamic>{
      'agencyid': instance.agencyid,
      'artistid': instance.artistid,
    };
