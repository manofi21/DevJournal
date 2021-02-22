import 'package:DevJournal/model/task/task_model.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class AddAndEditTaskPage extends StatefulWidget {
  final Task userTask;
  const AddAndEditTaskPage({Key key, this.userTask}) : super(key: key);

  @override
  _AddAndEditTaskPageState createState() => _AddAndEditTaskPageState();
}

class _AddAndEditTaskPageState extends State<AddAndEditTaskPage> {
  final projectNameController = TextEditingController();
  final featureNameController = TextEditingController();
  final timeStartController = TextEditingController();
  final timeFinishController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.userTask != null) {
      final start = widget.userTask.startTimes.split(" ")[1];
      final end = widget.userTask.finishTimes.split(" ")[1];
      projectNameController.text = widget.userTask.projectNames;
      featureNameController.text = widget.userTask.featureNames;
      timeStartController.text = start;
      timeFinishController.text = end;
      descriptionController.text = widget.userTask.description;
    } else {
      timeStartController.text = DateFormat("HH:mm").format(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(widget.userTask == null ? "Add" : "Edit"),
        ),
        body: Column(
          children: <Widget>[
            Text("Task"),
            SizedBox(
              height: 70,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          disabledHint: Container(),
                          iconSize: 40,
                          onChanged: (str) {
                            setState(() {
                              projectNameController.text = str;
                            });
                          },
                          // value: _chosenValue,
                          //elevation: 5,
                          style: TextStyle(color: Colors.black),
                          items: <String>[
                            'To-DO List',
                            'Simple Calculator',
                            'Cashier',
                            'Cartoon List',
                            'Book Store + Library + Trading Book + E-Book Promotion'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 360,
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: projectNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name of Project',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: TextFormField(
                controller: featureNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name of Feature',
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 170,
                      child: DateTimePicker(
                        type: DateTimePickerType.time,
                        controller: timeStartController,
                        //initialValue: _initialValue,
                        icon: Icon(Icons.access_time),
                        timeLabelText: "Start Time",
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      child: DateTimePicker(
                        type: DateTimePickerType.time,
                        controller: timeFinishController,
                        //initialValue: _initialValue,
                        icon: Icon(Icons.access_time),
                        timeLabelText: "End Time",
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  // helperText: 'Keep it short, this is just a demo.',
                  hintText:
                      'Tell the about feature Description (don\'t more than 150 char.)',
                ),
                maxLines: 3,
              ),
            ),
            FlatButton(
                onPressed: () {
                  // Task(startTimes: timeController)drop
                  // final times_start = timeController.text.split(":");
                  final dateTimeStart =
                      DateFormat("yyyy-MM-dd ").format(DateTime.now());
                  final result = Task(
                      projectNames: projectNameController.text,
                      featureNames: featureNameController.text,
                      startTimes: dateTimeStart + timeStartController.text,
                      finishTimes: dateTimeStart + timeFinishController.text,
                      description: descriptionController.text);
                  Navigator.pop(context, result);
                },
                child: Icon(Icons.print)),
            SizedBox(height: 20),
          ],
        ));
  }
}
