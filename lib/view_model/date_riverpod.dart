import 'package:DevJournal/model/task/task_model.dart';
import 'package:DevJournal/view/create_update_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:DevJournal/view/home_page.dart';
import 'package:table_calendar/table_calendar.dart';

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

class DateTimeChangeNotifier with ChangeNotifier {
  String _selectedDay = DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
  Map<String, List<dynamic>> _events = {};
  List<dynamic> _selectedEvents;

  // Map<String, List<Task>> get getEventsProvider {
  //   if (_events == null) {
  //     _events = {_selectedDay: []};
  //     notifyListeners();
  //   }
  //   return this._events;
  // }

  Map<String, List<dynamic>> get eventsProvider => this._events;

  set eventsProvider(Map<String, List<dynamic>> event) {
    this._events = event;
    notifyListeners();
  }

  // _events == null ? {_selectedDay: []} : _events;

  // List<Task> get getSelectedEventProvider {
  //   if (_selectedEvents == null) {
  //     _selectedEvents = _events[_selectedDay] ?? [];
  //     notifyListeners();
  //   }
  //   return this._selectedEvents;
  // }

  List<dynamic> get selectedEventProvider => this._selectedEvents;
  // _events[_selectedDay] == null ? [] : _events[_selectedDay];

  set selectedEventProvider(List<dynamic> selectedEvent) {
    this._selectedEvents = selectedEvent;
    notifyListeners();
  }

  void onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    _selectedDay = DateFormat("yyyy-MM-dd HH:mm").format(day);
    // print(events.length == 0);
    if (eventsProvider[_selectedDay] == null) {
      List<dynamic> emtyList = [];
      eventsProvider[_selectedDay] = emtyList;
    }
    // print(events);
    selectedEventProvider = events;
    // notifyListeners();
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

      if (eventsProvider != null) {
        eventsChanges(
                eventsProvider)[DateTime.parse(_selectedDay.split(" ")[0])]
            .add(getTask);
        print(eventsProvider);
      } else {
        Map<String, List<dynamic>> mapInitial = {_selectedDay: []};
        eventsProvider = mapInitial;
        eventsProvider[_selectedDay].add(getTask);
      }

      _selectedEvents = eventsChanges(
          eventsProvider)[DateTime.parse(_selectedDay.split(" ")[0])];
      notifyListeners();
    };

    return isAvailable
        ? addTask
        : () {
            scaffoldKey.currentState.removeCurrentSnackBar();
            scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text("The date already past")));
          };
  }

  void removeTask(int index) {
    _selectedEvents.remove(_selectedEvents[index]);
    notifyListeners();
  }

  void editTask(int index, BuildContext context) async {
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
    notifyListeners();
  }
}
