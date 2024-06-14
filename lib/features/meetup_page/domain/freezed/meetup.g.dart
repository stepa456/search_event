// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeetupImpl _$$MeetupImplFromJson(Map<String, dynamic> json) => _$MeetupImpl(
      id: json['id'] as String,
      description: json['description'] as String,
      title: json['title'] as String,
      startData: DateTime.parse(json['startData'] as String),
      endData: DateTime.parse(json['endData'] as String),
      pictures:
          (json['picture'] as List<dynamic>).map((e) => e as String).toList(),
      location: json['location'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$MeetupImplToJson(_$MeetupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'title': instance.title,
      'startData': instance.startData.toIso8601String(),
      'endData': instance.endData.toIso8601String(),
      'picture': instance.pictures,
      'location': instance.location,
      'phone': instance.phone,
    };

Map<String, dynamic> _$$CreateMeetupDTOImplToJson(
        _$CreateMeetupDTOImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'title': instance.title,
      'startData': instance.startData.toIso8601String(),
      'endData': instance.endData.toIso8601String(),
      'location': instance.location,
      'phone': instance.phone,
    };
