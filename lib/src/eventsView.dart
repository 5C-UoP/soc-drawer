import 'package:flutter/material.dart';
import 'package:socdrawer/src/eventsViewExpanded.dart';
import 'event.dart';

class EventsView extends StatelessWidget {
  final List<Event> events = [
    Event(
      name: 'Purple Wednesday',
      description: 'description.. blah blah blah \n more text \n even more text',
      dateTime: DateTime.now(),
      location: 'one eyed dog portsmouth',
      society: 'society its in',
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
                        '${event.dateTime.toLocal()}\n${event.location}\n${event.society}'),
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
