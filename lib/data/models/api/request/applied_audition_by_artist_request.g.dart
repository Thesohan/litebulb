// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_audition_by_artist_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppliedAuditionByArtistRequest _$AppliedAuditionByArtistRequestFromJson(
    Map<String, dynamic> json) {
  return AppliedAuditionByArtistRequest(
    artistid: json['artistid'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$AppliedAuditionByArtistRequestToJson(
        AppliedAuditionByArtistRequest instance) =>
    <String, dynamic>{
      'artistid': instance.artistid,
      'status': instance.status,
    };
