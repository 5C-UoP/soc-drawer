import 'package:flutter/material.dart';
import 'package:socdrawer/src/controllers/society_controller.dart';
import 'package:socdrawer/src/models/event.dart';
import 'event_view_expanded.dart';

class EventsView extends StatelessWidget {
  final List<Event> events = [
    Event(
      name: 'Purple Wednesday',
      description: 'description.. blah blah blah',
      dateTime: DateTime.now(),
      location: 'location',
      society: socieities.first,
    ),
  ];

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
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(event.name),
                    subtitle: Text(
                        '${event.dateTime.toLocal()}\n${event.location}\n${event.society.name}\n${event.description}'),
                    isThreeLine: true,
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // --- OPEN EVENT DETAILS ---
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventsViewExpanded(event: event),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
