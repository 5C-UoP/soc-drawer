import 'package:flutter/material.dart';
import 'package:socdrawer/src/controllers/event_controller.dart';
import 'package:socdrawer/src/controllers/user_controller.dart';
import 'package:socdrawer/src/models/user.dart';
import 'package:socdrawer/src/views/components/event_card.dart';
import 'package:socdrawer/src/views/events/event_create_view.dart';
import 'package:socdrawer/src/views/events/events_view.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/event.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  CalendarViewState createState() => CalendarViewState();
}

class CalendarViewState extends State<CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // final Map<DateTime, List<Event>> events = {};

  final User user = getLoggedInUser()!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 20.0,
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
                eventLoader: (day) {
                  return getEventsByDate(day);
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (events.isNotEmpty) {
                      return Positioned(
                        bottom: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              events.length > 3 ? 3 : events.length, (index) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.purple, // Color of the dot
                              ),
                            );
                          }),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // --- CALENDAR STYLE ---

                calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                )),
              ),
            ),
            if (user.comitteeSocieties.isNotEmpty)
              ElevatedButton(
                child: const Text('Add Event'),
                onPressed: () async {
                  final newEvent = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EventCreate()),
                  );

                  if (newEvent != null && newEvent is Event) {
                    setState(() {
                      // events
                    });
                  }
                },
              ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Column(
                      children: getEventsByDate(selectedDay).map((event) {
                        return EventCard(
                          event: event,
                        );
                      }).toList(),
                    )
                  ]),
            ));
      },
    );
  }
}
