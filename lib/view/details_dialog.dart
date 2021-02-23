import 'package:DevJournal/model/task/task_model.dart';
import 'package:DevJournal/view_model/date_riverpod.dart';
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

class _DetailDialogState extends State<DetailDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Project Name : ${widget.task.projectNames}'),
          Text('Feature Name : ${widget.task.featureNames}'),
          Text('Time : ${timesString(widget.task)}'),
          Text('Description : ${widget.task.description}'),
          Center(
            child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK")),
          )
        ],
      ),
    );
  }
}
