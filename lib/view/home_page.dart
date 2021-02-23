import 'package:DevJournal/model/task/task_model.dart';
import 'package:DevJournal/view/details_dialog.dart';
import 'package:DevJournal/view_model/date_riverpod.dart';
import 'package:DevJournal/view_model/task_API_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'change_password.dart';
import 'create_update_page.dart';
import 'log_out.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomePageHook extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final tickerProvider = useSingleTickerProvider();
    final _animationController = useAnimationController(
        vsync: tickerProvider, duration: const Duration(milliseconds: 400));
    return HomePageRiverpod(_animationController);
  }
}

final dateTimeChangeProvider =
    ChangeNotifierProvider((ref) => DateTimeChangeNotifier());

class HomePageRiverpod extends StatefulWidget {
  final AnimationController animationController;

  const HomePageRiverpod(this.animationController);
  @override
  _HomePageRiverpodState createState() =>
      _HomePageRiverpodState(this.animationController);
}

class _HomePageRiverpodState extends State<HomePageRiverpod> {
  final AnimationController animationController;
  _HomePageRiverpodState(this.animationController);
  CalendarController calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    animationController
        .forward()
        .whenComplete(() => widget.animationController.stop());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final accessRiverpod = watch(dateTimeChangeProvider);
        final todosState = watch(todosNotifierProvider.state);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            actions: [
              PopupMenuButton(onSelected: (value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            value == "/LogOut" ? LogOut() : ChangePassword()));
              }, itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      child: Text("Change Password"), value: "/ChangePassword"),
                  PopupMenuItem(child: Text("Log Out"), value: "/LogOut")
                ];
              })
            ],
          ),
          // yang ini udah pake StateNotifier
          body: todosState.when(
              data: (data) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    BuidlTableCalendar(
                      animationController: animationController,
                      calendarController: calendarController,
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Task"),
                          InkWell(
                              child: Text("Add Task"),
                              onTap: accessRiverpod.isAddTaskAvailable(context))
                        ],
                      ),
                    ),
                    Expanded(child: BuidlEventList()),
                  ],
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString()))),

          // Yang Ini data nya masih kosong
          // body: Column(
          //   mainAxisSize: MainAxisSize.max,
          //   children: <Widget>[
          //     BuidlTableCalendar(
          //       animationController: animationController,
          //       calendarController: calendarController,
          //     ),
          //     const SizedBox(height: 10.0),
          //     Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text("Task"),
          //           InkWell(
          //               child: Text("Add Task"),
          //               onTap: accessRiverpod.isAddTaskAvailable(context))
          //         ],
          //       ),
          //     ),
          //     Expanded(child: BuidlEventList()),
          //   ],
          // ),
        );
      },
    );
  }
}

class BuidlTableCalendar extends StatelessWidget {
  final CalendarController calendarController;
  final AnimationController animationController;
  // final Map<String, List<dynamic>> events;
  const BuidlTableCalendar(
      {Key key, this.calendarController, this.animationController})
      : super(key: key);

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: calendarController.isSelected(date)
            ? Colors.brown[500]
            : calendarController.isToday(date)
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

  @override
  Widget build(BuildContext context) {
    String _selectedDay = DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
    Map<String, List<dynamic>> _events = {_selectedDay: []};
    final accessRiverpod = context.read(dateTimeChangeProvider);
    // final accessAPI = context.read(todosNotifierProvider.state);
    // // ini nanti munculin data dari _events doang.
    // // klo tablenya di select
    // accessAPI.whenData((value) => value.forEach((result) {
    //       if (_events[result.startTimes] == null) {
    //         _events[result.startTimes] = [];
    //       }
    //       print(result);
    //       _events[result.startTimes].add(result);
    //       print(_events[result.startTimes]);
    //     }));
    
    return TableCalendar(
      locale: 'en_US',
      calendarController: calendarController,
      events: eventsChanges(accessRiverpod.eventsProvider ?? _events),
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
            opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
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
          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        accessRiverpod.onDaySelected(date, events, []);
        animationController.forward(from: 0.0);
      },
    );
  }
}

class BuidlEventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accessRiverpod = context.read(dateTimeChangeProvider);
    String _selectedDay = DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
    Map<String, List<dynamic>> _events = {_selectedDay: []};
    List _selectedEvents = _events[_selectedDay] ?? [];
    return ListView.builder(
        itemCount: (accessRiverpod.selectedEventProvider == null
                ? _selectedEvents
                : accessRiverpod.selectedEventProvider)
            .length,
        itemBuilder: (context, index) {
          Task _task = ((accessRiverpod.selectedEventProvider == null
              ? _selectedEvents
              : accessRiverpod.selectedEventProvider)[index] as Task);
          return Row(
            children: [
              // showDetailDialog
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
                    trailing: Text(timesString(_task)),
                    onTap: () {
                      showDetailDialog(context, _task);
                    },
                  ),
                ),
              ),
              isUpdateDeleteAvailable(_task)
                  ? Container()
                  : Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              accessRiverpod.removeTask(index);
                            }),
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              accessRiverpod.editTask(index, context);
                            }),
                      ],
                    ),
            ],
          );
        });
  }
}

//-------------------------------------------------------------//
//-------------------------------------------------------------//
//-------------------------------------------------------------//
