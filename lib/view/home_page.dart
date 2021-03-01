import 'package:DevJournal/model/task/task_model.dart';
import 'package:DevJournal/view/details_dialog.dart';
import 'package:DevJournal/view_model/date_riverpod.dart';
import 'package:DevJournal/view_model/task_API_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'change_password.dart';
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
    ChangeNotifierProvider<DateTimeChangeNotifier>((ref) {
  final todosState = ref.watch(todosNotifierProvider.state);
  List<Task> eventsProvider = List();
  todosState.whenData((value) => eventsProvider = value);
  return DateTimeChangeNotifier(eventsProvider);
});

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
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                  0.0,
                  0.4
                ],
                    colors: [
                  Color.fromRGBO(64, 69, 76, 1),
                  Color.fromRGBO(32, 34, 38, 1)
                ])),
            child: todosState.when(
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
                                onTap:
                                    accessRiverpod.isAddTaskAvailable(context))
                          ],
                        ),
                      ),
                      Expanded(child: BuidlEventList()),
                    ],
                  );
                },
                loading: () => Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (e, _) => Center(
                      child: Text(e.toString()),
                    )),
          ),
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
    final accessRiverpod = context.read(dateTimeChangeProvider);
    final accessAPI = context.read(todosNotifierProvider.state);
    return TableCalendar(
      locale: 'en_US',
      calendarController: calendarController,
      events: eventsChanges(accessRiverpod.eventsProvider),
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekdayStyle: TextStyle(color: Colors.white),
        weekendStyle: TextStyle().copyWith(color: Colors.white),
        eventDayStyle: TextStyle().copyWith(color: Colors.white),
        holidayStyle: TextStyle().copyWith(color: Colors.white),
      ),
      headerStyle: HeaderStyle(
          rightChevronIcon:
              Icon(Icons.arrow_right, size: 25, color: Colors.white),
          leftChevronIcon:
              Icon(Icons.arrow_left, size: 25, color: Colors.white),
          centerHeaderTitle: true,
          formatButtonVisible: false,
          titleMonthStyle: TextStyle(color: Colors.orange)),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 2,
                    color: Color.fromRGBO(0, 0, 0, 0.3))
              ], shape: BoxShape.circle, color: Color.fromRGBO(0, 191, 218, 1)
                  // color: Colors.deepOrange[300],
                  ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            decoration: BoxDecoration(
                // color: Colors.orange[400],
                border: Border.all(color: Colors.orange[400]),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(color: Colors.white),
                // style: TextStyle().copyWith(fontSize: 16.0),
              ),
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
    return ListView.builder(
        itemCount: accessRiverpod.selectedEventProvider.length,
        itemBuilder: (context, index) {
          Task _task = accessRiverpod.selectedEventProvider[index] as Task;
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
