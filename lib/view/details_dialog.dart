import 'package:DevJournal/model/task/task_model.dart';
import 'package:flutter/material.dart';

void showDetailDialog(BuildContext context, Task task) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) => DetailDialog(task),
  );
}

class DetailDialog extends StatefulWidget {
  final Task task;
  DetailDialog(this.task);
  @override
  _DetailDialogState createState() => _DetailDialogState();
}

String timesString(Task _task) {
  String firstTime = _task.startTimes.split(" ")[1];
  String lastTime = _task.finishTimes.split(" ")[1];
  String lastText = _task.finishTimes != null ? lastTime : "...";
  return firstTime + " - " + lastText;
}

class _DetailDialogState extends State<DetailDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          Text('Project Name : ${widget.task.projectNames}'),
          Text('Feature Name : ${widget.task.featureNames}'),
          Text('Time : ${timesString(widget.task)}'),
          Text('Description : ${widget.task.description}'),
        ],
      ),
    );
  }
}
