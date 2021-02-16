import 'package:DevJournal/model/task/task_model.dart';
import 'package:DevJournal/view/edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Map<DateTime, List<dynamic>> eventsChanges(Map<String, List<dynamic>> _events) {
  Map<DateTime, List<dynamic>> events = Map<DateTime, List<dynamic>>();
  for (MapEntry<String, List<dynamic>> entry in _events.entries) {
    List<String> justDate = entry.key.split(" ");
    events[DateTime.parse(justDate[0])] = entry.value;
  }

  return events;
}

String timesString(Task _task) {
  String firstTime = _task.startTimes.split(" ")[1];
  String lastTime = _task.finishTimes.split(" ")[1];
  String lastText = _task.finishTimes != null ? lastTime : "...";
  return firstTime + " - " + lastText;
}

bool isUpdateDeleteAvailable(_task) =>
    DateTime.now().difference(DateTime.parse((_task).startTimes)).inHours >= 24;

class DateTimeNotifierRiverpod with ChangeNotifier {
  String _selectedDay = DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
  Map<String, List<Task>> _events;
  List<Task> _selectedEvents;

  Map<String, List<Task>> get getEventsProvider {
    if (_events == null) {
      _events = {_selectedDay: []};
      notifyListeners();
    }
    return this._events;
  }

  List<Task> get getSelectedTaskProvider {
    if (_selectedEvents == null) {
      _selectedEvents = _events[_selectedDay];
      notifyListeners();
    }
    return this._selectedEvents;
  }

  void onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    _selectedDay = DateFormat("yyyy-MM-dd HH:mm").format(day);
    if (events.length == 0) {
      _events[DateFormat("yyyy-MM-dd HH:mm").format(day)] = [];
    }
    print(events);
    _selectedEvents = events;
    notifyListeners();
  }

  Function() isAddTaskAvailable(BuildContext context) {
    bool isAvailable = DateTime.parse(_selectedDay.split(" ")[0])
        .isAfter(DateTime.now().subtract(Duration(days: 1)));

    Function() addTask = () async {
      final Task getTask = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddAndEditTaskPage()));
      if (getTask == null) {
        return;
      }
      eventsChanges(_events)[DateTime.parse(_selectedDay.split(" ")[0])]
          .add(getTask);
      _selectedEvents =
          eventsChanges(_events)[DateTime.parse(_selectedDay.split(" ")[0])];
      notifyListeners();
    };

    Function() notAvailable = () => Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("The date already past")));

    return isAvailable ? addTask : notAvailable;
  }

  void removeTask(int index) {
    _selectedEvents.remove(_selectedEvents[index]);
    notifyListeners();
  }

  Function() editTask(int index, BuildContext context) {
    Function() getEditedData = () async {
      final Task getTask = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddAndEditTaskPage(
                    userTask: _selectedEvents[index],
                  )));
      if (getTask == null) {
        return;
      }
      _selectedEvents[index] = getTask;
    };
    return getEditedData;
  }
}
