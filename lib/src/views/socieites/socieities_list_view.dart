import 'package:flutter/material.dart';
import 'package:socdrawer/src/controllers/society_controller.dart';
import 'package:socdrawer/src/views/components/socieity_card.dart';

import '../../models/society.dart';

/// Displays a list of Socieities.
class SocietyItemListView extends StatelessWidget {
  const SocietyItemListView({
    super.key,
    List<Socieity>? items,
  });

  static const routeName = '/societies';

  final List<Socieity> items = societies;

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
                SocieityCard(society: item)
              ],
            );
          },
        ),
      ),
    );
  }
}
