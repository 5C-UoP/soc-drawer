// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/to/unit-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:socdrawer/src/controllers/society_controller.dart';
import 'package:socdrawer/src/models/event.dart';

void main() {
  group('Plus Operator', () {
    test('should add two numbers together', () {
      expect(1 + 1, 2);
    });
  });

  group('Event Model', () {
    test('valid event', () {
      final event = Event(
        name: 'Christmas event',
        description: 'a totally normal and good event',
        location: 'USPU',
        society: socieities[0],
        dateTime: DateTime(2025, 12, 25, 18, 0),
      );

      expect(event.name, 'Christmas event');
      expect(event.description, 'a totally normal and good event');
      expect(event.location, 'USPU');
      expect(event.society.name, 'Aviation');
      expect(event.dateTime, DateTime(2005, 12, 25, 18, 0));
    });
    test('date is in past', () {
      expect(
        () => Event(
          name: '2005 christmas event',
          description: 'this happens in the past',
          location: 'USPU',
          society: socieities[0],
          dateTime: DateTime(2005, 12, 25, 18, 0),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
    test('error when event title is too long', () {
      expect(
        () => Event(
          name: 'this event title is really long, its a whole 60 characters!',
          description: 'title too long :(',
          location: 'USPU',
          society: socieities[0],
          dateTime: DateTime(2025, 12, 25, 18, 0),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('error when event description is too long', () {
      expect(
        () => Event(
          name: 'Event desciption is too long',
          description:
              'this description is too long, its 200 characeters!!!!! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
          location: 'USPU',
          society: socieities[0],
          dateTime: DateTime(2025, 12, 25, 18, 0),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
    test('time inputted invalid', () {
      expect(
        () => Event(
          name: 'event at 13pm!',
          description: "please show up 15 minutes early",
          location: 'USPU',
          society: socieities[0],
          dateTime: DateTime(2025, 12, 25, 25, 61),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  }); //end of  event model
}
