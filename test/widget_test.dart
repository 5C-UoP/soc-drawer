import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:socdrawer/main.dart' as app;
import 'package:socdrawer/src/controllers/society_controller.dart';
import 'package:socdrawer/src/models/event.dart';
import 'package:socdrawer/src/views/components/event_card.dart' as event;
import 'package:socdrawer/src/views/events/events_view.dart';

void main() {
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

      // Log in if needed
      await tester.enterText(
          find.byType(TextField).at(0), 'admin@myport.ac.uk');
      await tester.enterText(find.byType(TextField).at(1), 'admin');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.textContaining('My Calendar'), findsWidgets);
    },
  );

  // Tests to make sure that our event card works
  testWidgets('Visible Events', (WidgetTester tester) async {
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

  testWidgets('navigates to EventsView when "Events" is tapped',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Log in if needed
    await tester.enterText(find.byType(TextField).at(0), 'admin@myport.ac.uk');
    await tester.enterText(find.byType(TextField).at(1), 'admin');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // there is no events by defualt
    await tester.tap(find.text('Events'));
    await tester.pumpAndSettle();

    // Verify navigation to EventsView
    expect(find.byType(EventsView), findsOneWidget);
  });
}
