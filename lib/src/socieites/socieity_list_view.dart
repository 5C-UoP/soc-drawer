import 'package:flutter/material.dart';

import 'socieity_details_view.dart';
import 'society.dart';

/// Displays a list of Socieities.
class SocietyItemListView extends StatelessWidget {
  const SocietyItemListView({
    super.key,
    this.items = const [
      Socieity(1, "Aviation", 'assets/images/societies/aviation.png', true),
      Socieity(2, "IT Soc", 'assets/images/societies/IT.png', true),
      Socieity(3, "Pool", 'assets/images/societies/pool.jpg', false),
      Socieity(5, "Pool", 'assets/images/societies/pool.jpg', false),
      Socieity(4, "Jolly Roger", 'assets/images/societies/JR.png', true)
    ],
  });

  static const routeName = '/societies';

  final List<Socieity> items;

  @override
  Widget build(BuildContext context) {
    // Sort the societies so ones you've joined are at the top, else alphabetically by name
    final modifiableItems = List<Socieity>.from(items);
    modifiableItems.sort((a, b) {
      if (a.joined && !b.joined) return -1;
      if (!a.joined && b.joined) return 1;
      return a.name.compareTo(b.name);
    });
    var listedAllJoined = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Societies'),
        actions: const [
          // IconButton(
          //   icon: const Icon(Icons.settings),
          //   onPressed: () {
          //     // Navigate to the settings page. If the user leaves and returns
          //     // to the app after it has been killed while running in the
          //     // background, the navigation stack is restored.
          //     Navigator.restorablePushNamed(context, SettingsView.routeName);
          //   },
          // ), //TODO Be in the navbar, no?
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          // Providing a restorationId allows the ListView to restore the
          // scroll position when a user leaves and returns to the app after it
          // has been killed while running in the background.
          restorationId: 'socieitiesListView',
          itemCount: modifiableItems.length,
          itemBuilder: (BuildContext context, int index) {
            final item = modifiableItems[index];

            // If the socieity we're on AND the society before are not joined
            // AND we've listed all the joined socieities, then we can updated listed all joined socieities to be true
            if (!listedAllJoined &&
                (!item.joined && !modifiableItems[index - 1].joined)) {
              listedAllJoined = true;
            }

            return Column(
              children: [
                !item.joined && !listedAllJoined
                    ? const Divider()
                    : const SizedBox.shrink(),
                ListTile(
                    title: Text(item.name),
                    leading: CircleAvatar(
                      // Display the Flutter Logo image asset.
                      foregroundImage: AssetImage(item.icon),
                    ),
                    trailing: item.joined ? null : const Text("Join"),
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.pushNamed(
                        context,
                        SocietyItemDetailsView.routeName,
                        arguments: {'society': item, 'e': 'a'},
                      );
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
