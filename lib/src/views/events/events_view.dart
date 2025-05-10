import 'package:flutter/material.dart';
import 'package:socdrawer/src/controllers/event_controller.dart';
import 'package:socdrawer/src/models/event.dart';
import 'package:socdrawer/src/views/components/event_card.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => EventsViewState();
}

class EventsViewState extends State<EventsView> {
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    refreshEvents();
  }

  void refreshEvents() {
    setState(() {
      _events = getAllEvents();
      _events.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      print('Events refreshed: ${_events.length} events loaded');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events:'),
      ),
      body: _events.isEmpty
          ? const Center(child: Text('No events :('))
          : ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return EventCard(event: event);
              },
            ),
    );
  }
}
