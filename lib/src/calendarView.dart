import 'package:flutter/material.dart';
import 'package:socdrawer/src/eventsView.dart';
//import 'package:socdrawer/src/sample_feature/sample_item.dart';
//import 'package:socdrawer/src/sample_feature/sample_item_list_view.dart';
import 'package:table_calendar/table_calendar.dart';
import 'event.dart';

class CalendarView extends StatefulWidget {
  @override
  CalendarViewState createState() => CalendarViewState();
}

class CalendarViewState extends State<CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  final Map<DateTime, List<Event>> events = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Calendar'),
        // actions: [
        //   // --- TEMPORARY BACK BUTTON TO GO BACK TO TEMPLATE ---
        //   // IconButton(
        //   //     onPressed: () {
        //   //       Navigator.pushReplacement(
        //   //         context,
        //   //         MaterialPageRoute(builder: (context) =>
        //   //       );
        //   //     },
        //   //     icon: const Icon(Icons.arrow_back))
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              // --- CALENDAR CONTAINER BOX ---
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),

              // --- CALENDAR ---
              child: TableCalendar(
                startingDayOfWeek: StartingDayOfWeek.monday,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  showEventsPopup(selectedDay);
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },

                // --- CALENDAR STYLE ---

                calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  // --- EVENTS SCREEN ---
  void showEventsPopup(DateTime selectedDay) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FractionallySizedBox(
            heightFactor: 0.8,
            widthFactor: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text(
                          "Events:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventsView()),
                            );
                          },
                          child: const Text("View All Events"),
                        ),
                      ],
                    ),
                  ]),
            ));
      },
    );
  }
}
