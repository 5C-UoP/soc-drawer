import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:socdrawer/main.dart' as app;
import 'package:socdrawer/src/controllers/event_controller.dart';
import 'package:socdrawer/src/controllers/society_controller.dart';
import 'package:socdrawer/src/models/event.dart';
import 'package:socdrawer/src/views/components/event_card.dart' as event;

Future<void> loginAdmin(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.textContaining('Login'), findsWidgets);
  // Log in if needed
  await tester.enterText(find.byType(TextField).at(0), 'admin@myport.ac.uk');
  await tester.enterText(find.byType(TextField).at(1), 'admin');
  await tester.tap(find.text('Login'));
  await tester.pumpAndSettle();
}

Future<void> logout(WidgetTester tester) async {
  final profileFinder = find.text('Profile');
  final logoutFinder = find.text('Logout');

  if (profileFinder.evaluate().isNotEmpty) {
    await tester.tap(profileFinder);
    await tester.pumpAndSettle();

    if (logoutFinder.evaluate().isNotEmpty) {
      await tester.tap(logoutFinder);
      await tester.pumpAndSettle();
    }
  }
}

Future<void> selectTomorrowDate(WidgetTester tester) async {
  final tomorrow = DateTime.now().add(const Duration(days: 1));
  final today =
      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

  // Tap to open the date picker
  await tester.tap(find.text(today));
  await tester.pumpAndSettle();

  // Select the day
  await tester.tap(find.text('${tomorrow.day}'));
  await tester.pumpAndSettle();

  // Tap the OK or Confirm button in the date picker
  await tester
      .tap(find.text('OK')); // Replace with 'Save' or other label if needed
  await tester.pumpAndSettle();
}

void main() {
  group('Login Tests', () {
    testWidgets('Renders Login screen', (WidgetTester tester) async {
      app.main(); // this runs runApp
      await tester.pumpAndSettle();

      expect(find.textContaining('Login'),
          findsWidgets); // Checks to see if it opens the login page
    });

    // Should still be on login page
    testWidgets('Checks incorrect login', (WidgetTester tester) async {
      app.main(); // this runs runApp
      await tester.pumpAndSettle();

      expect(find.textContaining('Login'),
          findsWidgets); // Checks to see if it opens the login page

      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      expect(find.textContaining('Login'), findsWidgets);
    });

    // test valid login
    testWidgets(
      "Checks correct login",
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        await loginAdmin(tester);

        expect(find.textContaining('My Calendar'), findsWidgets);
        await logout(tester);
      },
    );

    testWidgets(
      "Checks non committee don't have access to create event",
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byType(TextField).at(0), 'example.user@myport.ac.uk');
        await tester.enterText(find.byType(TextField).at(1), 'test');
        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle();

        expect(find.text('Add Event'), findsNothing);
        await logout(tester);
      },
    );

    testWidgets(
      "Checks logout functionality",
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        await loginAdmin(tester);

        // Tap on the Profile button
        await tester.tap(find.text('Profile'));
        await tester.pumpAndSettle();

        // Tap on the Logout button
        await tester.tap(find.text('Logout'));
        await tester.pumpAndSettle();

        // Verify that the login screen is displayed
        expect(find.textContaining('Login'), findsWidgets);
      },
    );
  });

  // Tests to make sure that our event card works
  group(
    "Events Group",
    () {
      testWidgets('Paid Events', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: event.EventCard(
              event: Event(
                name: 'Christmas event',
                description: 'a totally normal and good event',
                location: 'USPU',
                society: societies[0],
                dateTime: DateTime(2025, 12, 25, 18, 0),
                isRepeating: false,
                needsPayment: true,
              ),
            ),
          ),
        ));
        await tester.pumpAndSettle();

        expect(find.textContaining('Paid event'), findsWidgets);
      });

      testWidgets('Free Events', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: event.EventCard(
              event: Event(
                name: 'Christmas event',
                description: 'a totally normal and good event',
                location: 'USPU',
                society: societies[0],
                dateTime: DateTime(2025, 12, 25, 18, 0),
                isRepeating: false,
                needsPayment: false,
              ),
            ),
          ),
        ));
        await tester.pumpAndSettle();

        expect(find.textContaining('Free event'), findsWidgets);
      });

      testWidgets('Add valid event through UI', (tester) async {
        app.main();
        await tester.pumpAndSettle();
        await loginAdmin(tester);

        await tester.tap(find.text('Add Event'));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField).at(0), 'My Event');
        await tester.enterText(
            find.byType(TextField).at(1), 'A fun test event');

        await selectTomorrowDate(tester);

        await tester.enterText(find.byType(TextField).at(2), 'Guildhall');
        await tester.pumpAndSettle();

        // scroll to create button and tap
        final createButton = find.byIcon(Icons.event);
        await tester.ensureVisible(createButton);
        await tester.tap(createButton);
        await tester.pumpAndSettle();

        expect(getAllEvents().any((event) => event.name == 'My Event'), true);

        await logout(tester);
      });

      testWidgets('Add repeating event', (tester) async {
        app.main();
        await tester.pumpAndSettle();
        await loginAdmin(tester);

        await tester.tap(find.text('Add Event'));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField).at(0), 'Repeating Event');
        await tester.enterText(find.byType(TextField).at(1), 'Weekly meetup');
        await selectTomorrowDate(tester);
        await tester.enterText(find.byType(TextField).at(2), 'Library');

        final weeklyChebox = find.byType(Checkbox).at(1);
        await tester.ensureVisible(weeklyChebox);
        await tester.tap(weeklyChebox);
        await tester.pumpAndSettle();

        final createButton = find.byIcon(Icons.event);
        await tester.ensureVisible(createButton);
        await tester.tap(createButton);
        await tester.pumpAndSettle();

        // see the comment in the unit testing
        expect(
            getAllEvents()
                .where((event) => event.name == 'Repeating Event')
                .length,
            1);

        await logout(tester);
      });

      testWidgets('Add bad event (no location)', (tester) async {
        app.main();
        await tester.pumpAndSettle();
        await loginAdmin(tester);

        await tester.tap(find.text('Add Event'));
        await tester.pumpAndSettle();

        await tester.enterText(
            find.byType(TextField).at(0), 'Nameless Locationless Event');
        await tester.enterText(
            find.byType(TextField).at(1), 'Forgot the location');

        await selectTomorrowDate(tester);

        // scroll to create button and tap
        final createButton = find.byIcon(Icons.event);
        await tester.ensureVisible(createButton);
        await tester.tap(createButton);
        await tester.pumpAndSettle();

        // expect that it hasn't been added
        expect(
          getAllEvents().any((event) => event.name.trim().isEmpty),
          false,
        );

        await logout(tester);
      });
    },
  );
}
