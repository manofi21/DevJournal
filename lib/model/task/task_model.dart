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
      {String idProject,
      String idUser,
      String projectNames,
      String featureNames,
      String startTimes,
      String finishTimes,
      String description}) = _Task;
}

List<Task> lTask = [
  Task(
      idUser: "1",
      idProject: "1",
      projectNames: "DevJournal",
      featureNames: "Dev Schedule",
      description: "App for record dev activitiy",
      startTimes: "2021-02-15 16:20",
      finishTimes: DateFormat("yyyy-MM-dd")
          .format(DateTime.now().add(Duration(days: 7))))
];

List<Task> lTask2 = [
  Task(
      idUser: "1",
      idProject: "2",
      projectNames: "DevJournal",
      featureNames: "Dev Schedule",
      description: "App for record dev activitiy",
      startTimes: DateFormat("yyyy-MM-dd HH:mm")
          .format(DateTime.now().subtract(Duration(days: 1))),
      finishTimes: DateFormat("yyyy-MM-dd")
          .format(DateTime.now().add(Duration(days: 7))))
];
