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
        initialIndex: 0,
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(soc.icon),
              title: Text(soc.name),
              trailing: soc.joined ? null : const Text("Join"),
            ),
            const TabBar(
              tabs: [
                Tab(
                  text: "About",
                  icon: Icon(Icons.info_outline),
                ),
                Tab(text: "Events", icon: Icon(Icons.event)),
                Tab(text: "Products", icon: Icon(Icons.monetization_on)),
                Tab(text: "Committee", icon: Icon(Icons.people)),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TabBarView(
                  children: [
                    Text(soc.description),
                    const Center(child: Text("Events")),
                    const Center(child: Text("Products")),
                    ListView.builder(
                      itemCount: soc.committee.length,
                      itemBuilder: (context, index) {
                        final memberKey = soc.committee.keys.elementAt(index);
                        final member = soc.committee[memberKey];
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(memberKey),
                          subtitle: Text(member),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
