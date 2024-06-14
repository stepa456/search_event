import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    String? username,
    String? email,
    String? password,
    String? passwordConfirm,
  }) = _User;
  factory User.fromRecord(RecordModel record) => User.fromJson(record.toJson());
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
