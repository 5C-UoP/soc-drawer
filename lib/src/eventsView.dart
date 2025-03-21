import 'package:flutter/material.dart';
import 'event.dart';

class EventsView extends StatelessWidget {
  final List<Event> events = [
    Event(
      name: 'Purple Wednesday',
      description: 'description.. blah blah blah',
      dateTime: DateTime.now(),
      location: 'location',
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
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(event.name),
                    subtitle: Text('${event.dateTime.toLocal()}\n${event.location}\n${event.society}${event.description}'),
                    isThreeLine: true,
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {

                      // --- OPEN EVENT DETAILS ---
                      
                    },
                  ),
                );
              },
            ),
    );
  }
}
