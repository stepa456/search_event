// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meetup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Meetup _$MeetupFromJson(Map<String, dynamic> json) {
  return _Meetup.fromJson(json);
}

/// @nodoc
mixin _$Meetup {
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get startData => throw _privateConstructorUsedError;
  DateTime get endData => throw _privateConstructorUsedError;
  @JsonKey(name: 'picture')
  List<String> get pictures => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeetupCopyWith<Meetup> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetupCopyWith<$Res> {
  factory $MeetupCopyWith(Meetup value, $Res Function(Meetup) then) =
      _$MeetupCopyWithImpl<$Res, Meetup>;
  @useResult
  $Res call(
      {String id,
      String description,
      String title,
      DateTime startData,
      DateTime endData,
      @JsonKey(name: 'picture') List<String> pictures,
      String location,
      String phone});
}

/// @nodoc
class _$MeetupCopyWithImpl<$Res, $Val extends Meetup>
    implements $MeetupCopyWith<$Res> {
  _$MeetupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? title = null,
    Object? startData = null,
    Object? endData = null,
    Object? pictures = null,
    Object? location = null,
    Object? phone = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startData: null == startData
          ? _value.startData
          : startData // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endData: null == endData
          ? _value.endData
          : endData // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pictures: null == pictures
          ? _value.pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as List<String>,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeetupImplCopyWith<$Res> implements $MeetupCopyWith<$Res> {
  factory _$$MeetupImplCopyWith(
          _$MeetupImpl value, $Res Function(_$MeetupImpl) then) =
      __$$MeetupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String description,
      String title,
      DateTime startData,
      DateTime endData,
      @JsonKey(name: 'picture') List<String> pictures,
      String location,
      String phone});
}

/// @nodoc
class __$$MeetupImplCopyWithImpl<$Res>
    extends _$MeetupCopyWithImpl<$Res, _$MeetupImpl>
    implements _$$MeetupImplCopyWith<$Res> {
  __$$MeetupImplCopyWithImpl(
      _$MeetupImpl _value, $Res Function(_$MeetupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? title = null,
    Object? startData = null,
    Object? endData = null,
    Object? pictures = null,
    Object? location = null,
    Object? phone = null,
  }) {
    return _then(_$MeetupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startData: null == startData
          ? _value.startData
          : startData // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endData: null == endData
          ? _value.endData
          : endData // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pictures: null == pictures
          ? _value._pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as List<String>,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeetupImpl implements _Meetup {
  const _$MeetupImpl(
      {required this.id,
      required this.description,
      required this.title,
      required this.startData,
      required this.endData,
      @JsonKey(name: 'picture') required final List<String> pictures,
      required this.location,
      required this.phone})
      : _pictures = pictures;

  factory _$MeetupImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeetupImplFromJson(json);

  @override
  final String id;
  @override
  final String description;
  @override
  final String title;
  @override
  final DateTime startData;
  @override
  final DateTime endData;
  final List<String> _pictures;
  @override
  @JsonKey(name: 'picture')
  List<String> get pictures {
    if (_pictures is EqualUnmodifiableListView) return _pictures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pictures);
  }

  @override
  final String location;
  @override
  final String phone;

  @override
  String toString() {
    return 'Meetup(id: $id, description: $description, title: $title, startData: $startData, endData: $endData, pictures: $pictures, location: $location, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startData, startData) ||
                other.startData == startData) &&
            (identical(other.endData, endData) || other.endData == endData) &&
            const DeepCollectionEquality().equals(other._pictures, _pictures) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      description,
      title,
      startData,
      endData,
      const DeepCollectionEquality().hash(_pictures),
      location,
      phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetupImplCopyWith<_$MeetupImpl> get copyWith =>
      __$$MeetupImplCopyWithImpl<_$MeetupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetupImplToJson(
      this,
    );
  }
}

abstract class _Meetup implements Meetup {
  const factory _Meetup(
      {required final String id,
      required final String description,
      required final String title,
      required final DateTime startData,
      required final DateTime endData,
      @JsonKey(name: 'picture') required final List<String> pictures,
      required final String location,
      required final String phone}) = _$MeetupImpl;

  factory _Meetup.fromJson(Map<String, dynamic> json) = _$MeetupImpl.fromJson;

  @override
  String get id;
  @override
  String get description;
  @override
  String get title;
  @override
  DateTime get startData;
  @override
  DateTime get endData;
  @override
  @JsonKey(name: 'picture')
  List<String> get pictures;
  @override
  String get location;
  @override
  String get phone;
  @override
  @JsonKey(ignore: true)
  _$$MeetupImplCopyWith<_$MeetupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateMeetupDTO {
  String get description => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get startData => throw _privateConstructorUsedError;
  DateTime get endData => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateMeetupDTOCopyWith<CreateMeetupDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateMeetupDTOCopyWith<$Res> {
  factory $CreateMeetupDTOCopyWith(
          CreateMeetupDTO value, $Res Function(CreateMeetupDTO) then) =
      _$CreateMeetupDTOCopyWithImpl<$Res, CreateMeetupDTO>;
  @useResult
  $Res call(
      {String description,
      String title,
      DateTime startData,
      DateTime endData,
      String location,
      String phone});
}

/// @nodoc
class _$CreateMeetupDTOCopyWithImpl<$Res, $Val extends CreateMeetupDTO>
    implements $CreateMeetupDTOCopyWith<$Res> {
  _$CreateMeetupDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? title = null,
    Object? startData = null,
    Object? endData = null,
    Object? location = null,
    Object? phone = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startData: null == startData
          ? _value.startData
          : startData // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endData: null == endData
          ? _value.endData
          : endData // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateMeetupDTOImplCopyWith<$Res>
    implements $CreateMeetupDTOCopyWith<$Res> {
  factory _$$CreateMeetupDTOImplCopyWith(_$CreateMeetupDTOImpl value,
          $Res Function(_$CreateMeetupDTOImpl) then) =
      __$$CreateMeetupDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      String title,
      DateTime startData,
      DateTime endData,
      String location,
      String phone});
}

/// @nodoc
class __$$CreateMeetupDTOImplCopyWithImpl<$Res>
    extends _$CreateMeetupDTOCopyWithImpl<$Res, _$CreateMeetupDTOImpl>
    implements _$$CreateMeetupDTOImplCopyWith<$Res> {
  __$$CreateMeetupDTOImplCopyWithImpl(
      _$CreateMeetupDTOImpl _value, $Res Function(_$CreateMeetupDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? title = null,
    Object? startData = null,
    Object? endData = null,
    Object? location = null,
    Object? phone = null,
  }) {
    return _then(_$CreateMeetupDTOImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startData: null == startData
          ? _value.startData
          : startData // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endData: null == endData
          ? _value.endData
          : endData // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$CreateMeetupDTOImpl implements _CreateMeetupDTO {
  const _$CreateMeetupDTOImpl(
      {required this.description,
      required this.title,
      required this.startData,
      required this.endData,
      required this.location,
      required this.phone});

  @override
  final String description;
  @override
  final String title;
  @override
  final DateTime startData;
  @override
  final DateTime endData;
  @override
  final String location;
  @override
  final String phone;

  @override
  String toString() {
    return 'CreateMeetupDTO(description: $description, title: $title, startData: $startData, endData: $endData, location: $location, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateMeetupDTOImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startData, startData) ||
                other.startData == startData) &&
            (identical(other.endData, endData) || other.endData == endData) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, description, title, startData, endData, location, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateMeetupDTOImplCopyWith<_$CreateMeetupDTOImpl> get copyWith =>
      __$$CreateMeetupDTOImplCopyWithImpl<_$CreateMeetupDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateMeetupDTOImplToJson(
      this,
    );
  }
}

abstract class _CreateMeetupDTO implements CreateMeetupDTO {
  const factory _CreateMeetupDTO(
      {required final String description,
      required final String title,
      required final DateTime startData,
      required final DateTime endData,
      required final String location,
      required final String phone}) = _$CreateMeetupDTOImpl;

  @override
  String get description;
  @override
  String get title;
  @override
  DateTime get startData;
  @override
  DateTime get endData;
  @override
  String get location;
  @override
  String get phone;
  @override
  @JsonKey(ignore: true)
  _$$CreateMeetupDTOImplCopyWith<_$CreateMeetupDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
