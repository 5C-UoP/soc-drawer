import 'package:socdrawer/src/models/event.dart';
import 'package:socdrawer/src/models/society.dart';

List<Event> events = [];

List<Event> getAllEvents() {
  print(events.length);
  print(events);
  return events;
}

void createEvent(Event event) {
  events.add(event);
}

List<Event> getEventsByDate(DateTime date) {
  return events
      .where((event) =>
          event.dateTime.year == date.year &&
          event.dateTime.month == date.month &&
          event.dateTime.day == date.day)
      .toList();
}

List<Event> getEventsBySocieity(Socieity society) {
  return events.where((event) => event.society.name == society.name).toList();
}
