import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'meetup.freezed.dart';
part 'meetup.g.dart';

@freezed
class Meetup with _$Meetup {
  const factory Meetup(
      {required String id,
      required String description,
      required String title,
      required DateTime startData,
      required DateTime endData,
      @JsonKey(name: 'picture') required List<String> pictures,
      required String location,
      required String phone}) = _Meetup;
  factory Meetup.fromRecord(RecordModel record) =>
      Meetup.fromJson(record.toJson());

  factory Meetup.fromJson(Map<String, dynamic> json) => _$MeetupFromJson(json);
}

@Freezed(toJson: true)
class CreateMeetupDTO with _$CreateMeetupDTO {
  const factory CreateMeetupDTO({
    required String description,
    required String title,
    required DateTime startData,
    required DateTime endData,
    required String location,
    required String phone,
    // required Actors actors,
    // required Speches speches,
  }) = _CreateMeetupDTO;
}

// @freezed
// class Speches with _$Speches {
//   const factory Speches({
//     String? id,
//     required String theme,
//     required String description,
//   }) = _Speches;

//   factory Speches.fromRecord(RecordModel record) =>
//       Speches.fromJson(record.toJson());
//   factory Speches.fromJson(Map<String, dynamic> json) =>
//       _$SpechesFromJson(json);
// }

// @freezed
// class Actors with _$Actors {
//   const factory Actors({
//     String? id,
//     required String jobName,
//     required String firstName,
//     required String lastName,
//   }) = _Actors;
//   factory Actors.fromRecord(RecordModel record) =>
//       Actors.fromJson(record.toJson());
//   factory Actors.fromJson(Map<String, dynamic> json) => _$ActorsFromJson(json);
// }
