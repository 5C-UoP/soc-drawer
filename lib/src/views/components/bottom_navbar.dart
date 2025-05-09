import 'package:flutter/material.dart';
import 'package:socdrawer/src/views/events/events_view.dart';
import 'package:socdrawer/src/views/home/home_view.dart';
import 'package:socdrawer/src/views/socieites/socieities_list_view.dart';
import 'package:socdrawer/src/views/user/user_view.dart';
// import 'package:socdrawer/src/settings/settings_view.dart';
// import 'package:socdrawer/src/socieites/socieity_details_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() {
    return _BottomNavBarState();
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0; // Home page by defualt

  final List<Widget> _screens = [
    const CalendarView(),
    const SocietyItemListView(),
    EventsView(),
    UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // if (getLoggedInUser() == null) {
    //   Navigator.pushNamed(context, 'login');
    // }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Societies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
