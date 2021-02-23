// class Task {
//   String idProject;
//   String idUser;
//   String projectNames;
//   String featureNames;
//   String startTimes;
//   String finishTimes;
//   String description;
// }

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

part 'task_model.freezed.dart';

@freezed
abstract class Task with _$Task {
  factory Task(
      {
      int id,  
      String idProject,
      String idUser,
      String projectNames,
      String featureNames,
      String startTimes,
      String finishTimes,
      String description}) = _Task;
}