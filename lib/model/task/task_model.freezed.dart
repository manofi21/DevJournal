// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$TaskTearOff {
  const _$TaskTearOff();

// ignore: unused_element
  _Task call(
      {int id,
      String idProject,
      String idUser,
      String projectNames,
      String featureNames,
      String startTimes,
      String finishTimes,
      String description}) {
    return _Task(
      id: id,
      idProject: idProject,
      idUser: idUser,
      projectNames: projectNames,
      featureNames: featureNames,
      startTimes: startTimes,
      finishTimes: finishTimes,
      description: description,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Task = _$TaskTearOff();

/// @nodoc
mixin _$Task {
  int get id;
  String get idProject;
  String get idUser;
  String get projectNames;
  String get featureNames;
  String get startTimes;
  String get finishTimes;
  String get description;

  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String idProject,
      String idUser,
      String projectNames,
      String featureNames,
      String startTimes,
      String finishTimes,
      String description});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res> implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  final Task _value;
  // ignore: unused_field
  final $Res Function(Task) _then;

  @override
  $Res call({
    Object id = freezed,
    Object idProject = freezed,
    Object idUser = freezed,
    Object projectNames = freezed,
    Object featureNames = freezed,
    Object startTimes = freezed,
    Object finishTimes = freezed,
    Object description = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      idProject: idProject == freezed ? _value.idProject : idProject as String,
      idUser: idUser == freezed ? _value.idUser : idUser as String,
      projectNames: projectNames == freezed
          ? _value.projectNames
          : projectNames as String,
      featureNames: featureNames == freezed
          ? _value.featureNames
          : featureNames as String,
      startTimes:
          startTimes == freezed ? _value.startTimes : startTimes as String,
      finishTimes:
          finishTimes == freezed ? _value.finishTimes : finishTimes as String,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }
}

/// @nodoc
abstract class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) then) =
      __$TaskCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String idProject,
      String idUser,
      String projectNames,
      String featureNames,
      String startTimes,
      String finishTimes,
      String description});
}

/// @nodoc
class __$TaskCopyWithImpl<$Res> extends _$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(_Task _value, $Res Function(_Task) _then)
      : super(_value, (v) => _then(v as _Task));

  @override
  _Task get _value => super._value as _Task;

  @override
  $Res call({
    Object id = freezed,
    Object idProject = freezed,
    Object idUser = freezed,
    Object projectNames = freezed,
    Object featureNames = freezed,
    Object startTimes = freezed,
    Object finishTimes = freezed,
    Object description = freezed,
  }) {
    return _then(_Task(
      id: id == freezed ? _value.id : id as int,
      idProject: idProject == freezed ? _value.idProject : idProject as String,
      idUser: idUser == freezed ? _value.idUser : idUser as String,
      projectNames: projectNames == freezed
          ? _value.projectNames
          : projectNames as String,
      featureNames: featureNames == freezed
          ? _value.featureNames
          : featureNames as String,
      startTimes:
          startTimes == freezed ? _value.startTimes : startTimes as String,
      finishTimes:
          finishTimes == freezed ? _value.finishTimes : finishTimes as String,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }
}

/// @nodoc
class _$_Task with DiagnosticableTreeMixin implements _Task {
  _$_Task(
      {this.id,
      this.idProject,
      this.idUser,
      this.projectNames,
      this.featureNames,
      this.startTimes,
      this.finishTimes,
      this.description});

  @override
  final int id;
  @override
  final String idProject;
  @override
  final String idUser;
  @override
  final String projectNames;
  @override
  final String featureNames;
  @override
  final String startTimes;
  @override
  final String finishTimes;
  @override
  final String description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Task(id: $id, idProject: $idProject, idUser: $idUser, projectNames: $projectNames, featureNames: $featureNames, startTimes: $startTimes, finishTimes: $finishTimes, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Task'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('idProject', idProject))
      ..add(DiagnosticsProperty('idUser', idUser))
      ..add(DiagnosticsProperty('projectNames', projectNames))
      ..add(DiagnosticsProperty('featureNames', featureNames))
      ..add(DiagnosticsProperty('startTimes', startTimes))
      ..add(DiagnosticsProperty('finishTimes', finishTimes))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Task &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.idProject, idProject) ||
                const DeepCollectionEquality()
                    .equals(other.idProject, idProject)) &&
            (identical(other.idUser, idUser) ||
                const DeepCollectionEquality().equals(other.idUser, idUser)) &&
            (identical(other.projectNames, projectNames) ||
                const DeepCollectionEquality()
                    .equals(other.projectNames, projectNames)) &&
            (identical(other.featureNames, featureNames) ||
                const DeepCollectionEquality()
                    .equals(other.featureNames, featureNames)) &&
            (identical(other.startTimes, startTimes) ||
                const DeepCollectionEquality()
                    .equals(other.startTimes, startTimes)) &&
            (identical(other.finishTimes, finishTimes) ||
                const DeepCollectionEquality()
                    .equals(other.finishTimes, finishTimes)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(idProject) ^
      const DeepCollectionEquality().hash(idUser) ^
      const DeepCollectionEquality().hash(projectNames) ^
      const DeepCollectionEquality().hash(featureNames) ^
      const DeepCollectionEquality().hash(startTimes) ^
      const DeepCollectionEquality().hash(finishTimes) ^
      const DeepCollectionEquality().hash(description);

  @JsonKey(ignore: true)
  @override
  _$TaskCopyWith<_Task> get copyWith =>
      __$TaskCopyWithImpl<_Task>(this, _$identity);
}

abstract class _Task implements Task {
  factory _Task(
      {int id,
      String idProject,
      String idUser,
      String projectNames,
      String featureNames,
      String startTimes,
      String finishTimes,
      String description}) = _$_Task;

  @override
  int get id;
  @override
  String get idProject;
  @override
  String get idUser;
  @override
  String get projectNames;
  @override
  String get featureNames;
  @override
  String get startTimes;
  @override
  String get finishTimes;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$TaskCopyWith<_Task> get copyWith;
}
