import 'package:flutter/material.dart';
import 'package:socdrawer/src/calendarView.dart';
import 'package:socdrawer/src/event_create.dart';
import 'package:socdrawer/src/eventsView.dart';
import 'package:socdrawer/src/socieites/socieity_list_view.dart';
// import 'package:socdrawer/src/settings/settings_view.dart';
// import 'package:socdrawer/src/socieites/socieity_details_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    SocietyItemListView(),
    CalendarView(),
    EventsView(),
    EventCreate(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Societies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Create Event',
          ),
        ],
      ),
    );
  }
}
