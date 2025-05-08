import 'package:flutter/material.dart';
import 'package:socdrawer/src/controllers/event_controller.dart';
import 'package:socdrawer/src/models/event.dart';
import 'package:socdrawer/src/views/components/event_card.dart';

class EventsView extends StatelessWidget {
  // final List<Event> events = [
  //   Event(
  //     name: 'Purple Wednesday',
  //     description: 'description.. blah blah blah',
  //     dateTime: DateTime.now(),
  //     location: 'location',
  //     society: socieities.first,
  //   ),
  // ];

  final List<Event> events = getAllEvents();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
      ),
      body: events.isEmpty
          ? const Center(child: Text('No events'))
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(event: event);
              },
            ),
    );
  }
}
