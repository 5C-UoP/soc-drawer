
import 'package:flutter_test/flutter_test.dart';
import 'package:socdrawer/src/views/components/bottom_navbar.dart' as bottom_navbar;
import 'package:socdrawer/src/views/components/event_card.dart' as event;
import 'package:socdrawer/main.dart' as app;

void main() {
  testWidgets('Renders default screen', (WidgetTester tester) async {
    app.main(); // this runs runApp
    await tester.pumpAndSettle();

    expect(find.textContaining('Society'), findsWidgets); // Adjust based on your UI
  });
    testWidgets('Checks navbar', (WidgetTester tester) async {
    bottom_navbar.BottomNavBar(); // this runs runApp
    await tester.pumpAndSettle();

    expect(find.textContaining('Home'), findsWidgets); // Adjust based on your UI
  });
    testWidgets('Visible Events', (WidgetTester tester) async {
    event.EventCard(); // this runs runApp
    await tester.pumpAndSettle();

    expect(find.textContaining('Paid event'), findsWidgets); // Adjust based on your UI
  });
}