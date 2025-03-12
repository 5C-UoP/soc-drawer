import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class SocietyItemDetailsView extends StatelessWidget {
  const SocietyItemDetailsView({super.key, required this.args});

  static const routeName = '/sample_item';
  final Map<String, dynamic>? args;

  @override
  Widget build(BuildContext context) {
    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Society'),
        ),
        body: const Center(
          child: Text('No data passed to this view'),
        ),
      );
    }

    final soc = args!['society'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Society Information"),
      ),
      body: DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: Column(
          children: [
            ListTile(leading: Image.asset(soc.icon), title: Text(soc.name)),
            TabBar(
              tabs: [
                Tab(
                  text: "About",
                ),
                Tab(
                  text: "Events",
                ),
                Tab(
                  text: "Products",
                ),
                Tab(
                  text: "Committee",
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text("About")),
                  Center(child: Text("Events")),
                  Center(child: Text("Products")),
                  Center(child: Text("Committee")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
