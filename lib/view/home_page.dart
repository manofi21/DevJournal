import 'package:DevJournal/model/task/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'edit_page.dart';

class HomePageHook extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final tickerProvider = useSingleTickerProvider();
    final _animationController = useAnimationController(
        vsync: tickerProvider, duration: const Duration(milliseconds: 400));
    return MyHomePage(_animationController);
  }
}

class HomePageProvider extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader reader) {
    return Container();
  }
}

//----------------------------------//

class MyHomePage extends StatefulWidget {
  final AnimationController animationController;

  const MyHomePage(this.animationController);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, List<Task>> _events;
  List _selectedEvents;
  // AnimationController _animationController;
  CalendarController _calendarController;
  String _selectedDay = DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());

  @override
  void initState() {
    super.initState();

    _events = {_selectedDay: []};

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    widget.animationController
        .forward()
        .whenComplete(() => widget.animationController.stop());
  }

  @override
  void dispose() {
    widget.animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedDay = DateFormat("yyyy-MM-dd HH:mm").format(day);
      if (events.length == 0) {
        _events[DateFormat("yyyy-MM-dd HH:mm").format(day)] = [];
      }
      print(events);
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendarWithBuilders(),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Task"),
                InkWell(
                    child: Text("Add Task"),
                    onTap: DateTime.parse(_selectedDay.split(" ")[0])
                            .isAfter(DateTime.now().subtract(Duration(days: 1)))
                        ? () async {
                            print(_selectedDay);
                            final Task get_task = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddAndEditTaskPage()));
                            if (get_task == null) {
                              return;
                            }
                            setState(() {
                              eventsChanges(_events)[DateTime.parse(
                                      _selectedDay.split(" ")[0])]
                                  .add(get_task);
                              _selectedEvents = eventsChanges(_events)[
                                  DateTime.parse(_selectedDay.split(" ")[0])];
                            });
                          }
                        : null)
              ],
            ),
          ),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Map<DateTime, List<dynamic>> eventsChanges(
      Map<String, List<dynamic>> _events) {
    Map<DateTime, List<dynamic>> events = Map<DateTime, List<dynamic>>();
    for (MapEntry<String, List<dynamic>> entry in _events.entries) {
      List<String> justDate = entry.key.split(" ");
      events[DateTime.parse(justDate[0])] = entry.value;
    }
    print(events);
    return events;
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'en_US',
      calendarController: _calendarController,
      events: eventsChanges(_events),
      // holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity:
                Tween(begin: 0.0, end: 1.0).animate(widget.animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: 0,
                top: 0,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        widget.animationController.forward(from: 0.0);
      },

      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 40.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    return ListView.builder(
        itemCount: _selectedEvents.length,
        itemBuilder: (context, index) {
          Task _task = (_selectedEvents[index] as Task);
          return Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: _task.projectNames,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: " - ${_task.featureNames}",
                              // style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                    subtitle: Text(
                      _task.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(_task.startTimes.split(" ")[1] +
                        " - " +
                        (_task.finishTimes != null
                            ? _task.finishTimes.split(" ")[1]
                            : "...")),
                    onTap: () {},
                  ),
                ),
              ),
              DateTime.now()
                          .difference(DateTime.parse((_task).startTimes))
                          .inHours >=
                      24
                  ? Container()
                  : Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _selectedEvents.remove(_selectedEvents[index]);
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              final Task get_task = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddAndEditTaskPage(
                                            userTask: _task,
                                          )));
                              if (get_task == null) {
                                return;
                              }
                              _selectedEvents[index] = get_task;
                            }),
                      ],
                    ),
            ],
          );
        });
  }
}
