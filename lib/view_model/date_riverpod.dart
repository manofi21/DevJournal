import 'package:DevJournal/model/task/task_model.dart';
import 'package:DevJournal/view/create_update_page.dart';
import 'package:DevJournal/view_model/task_API_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:DevJournal/view/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

bool isUpdateDeleteAvailable(Task _task) =>
    DateTime.now().difference(DateTime.parse((_task).startTimes)).inHours >= 24;

class DateTimeChangeNotifier with ChangeNotifier {
  final List<Task> events_provider;
  DateTimeChangeNotifier(this.events_provider) : _events = {_selectedDay: []} {
    events_provider.forEach((result) {
      DateTime getDate = DateTime.parse(result.startTimes.split(" ")[0]);

      if (eventsProvider[result.startTimes] != null) {
        eventsChanges(eventsProvider)[getDate].add(result);
      } else {
        eventsProvider[result.startTimes] = [];
        eventsProvider[result.startTimes].add(result);
      }
    });
  }

  static String _selectedDay =
      DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
  Map<String, List<dynamic>> _events;
  List<dynamic> _selectedEvents = [];

  Map<String, List<dynamic>> get eventsProvider => this._events;

  set eventsProvider(Map<String, List<dynamic>> event) {
    this._events = event;
    notifyListeners();
  }

  List<dynamic> get selectedEventProvider => this._selectedEvents;

  set selectedEventProvider(List<dynamic> selectedEvent) {
    this._selectedEvents = selectedEvent;
    notifyListeners();
  }

  void onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    _selectedDay = DateFormat("yyyy-MM-dd HH:mm").format(day);
    if (eventsProvider[_selectedDay] == null && events.length == 0) {
      List<dynamic> emtyList = [];
      eventsProvider[_selectedDay] = emtyList;
    }
    selectedEventProvider = events;
  }

  Function() isAddTaskAvailable(BuildContext context) {
    DateTime getDate = DateTime.parse(_selectedDay.split(" ")[0]);
    bool isAvailable =
        getDate.isAfter(DateTime.now().subtract(Duration(days: 1)));

    Function() addTask = () async {
      final Task getTask = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddAndEditTaskPage(anotherDay: _selectedDay.split(" ")[0])));
      if (getTask == null) {
        return;
      }
      // print(getTask.startTimes);
      if (eventsChanges(eventsProvider)[getDate] != null) {
        eventsChanges(eventsProvider)[getDate].add(getTask);
      } else {
        eventsProvider[_selectedDay] = [];
        eventsProvider[_selectedDay].add(getTask);
      }
      // print(getTask.startEnds);

      selectedEventProvider = eventsChanges(eventsProvider)[getDate];
      scaffoldKey.currentContext.read(todosNotifierProvider).add(getTask);
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
    // scaffoldKey.currentContext
    //     .read(todosNotifierProvider)
    //     .remove(index, _selectedEvents[index]);
    notifyListeners();
  }

  void editTask(int index, BuildContext context) async {
    final Task getTask = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddAndEditTaskPage(
                  userTask: _selectedEvents[index],
                  // anotherDay: _selectedDay,
                )));
    if (getTask == null) {
      return;
    }
    _selectedEvents[index] = getTask;
    // scaffoldKey.currentContext.read(todosNotifierProvider).edit(index, getTask);
    notifyListeners();
  }
}
