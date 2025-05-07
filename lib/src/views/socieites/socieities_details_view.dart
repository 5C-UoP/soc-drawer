import 'package:flutter/material.dart';
import 'package:socdrawer/src/controllers/event_controller.dart';
import 'package:socdrawer/src/views/components/event_card.dart';
import 'package:socdrawer/src/views/components/social_card.dart';
import 'package:url_launcher/url_launcher.dart';

/// Displays detailed information about a SampleItem.
class SocietyItemDetailsView extends StatelessWidget {
  const SocietyItemDetailsView({super.key, required this.args});

  static const routeName = '/society_view';
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

    // Fail safe in case no society is passed through for whatever reason
    // (or this eventually goes to web and the user tries to go to a page where there is no society)
    if (soc == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Society'),
        ),
        body: const Center(
          child: Text('No society data available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Society Information"),
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(soc.icon),
              title: Text(soc.name),
              trailing: GestureDetector(
                onTap: () async {
                  final url =
                      "https://upsu.net/groups/${soc.code}/${soc.name.toString().toLowerCase().replaceAll(" ", "-")}";
                  await launchUrl(Uri.parse(url));
                },
                child: Text(
                  soc.joined ? "Open" : "Join",
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const TabBar(
              tabs: [
                Tab(
                  text: "About",
                  icon: Icon(Icons.info_outline),
                ),
                Tab(text: "Events", icon: Icon(Icons.event)),
                Tab(text: "Committee", icon: Icon(Icons.people)),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TabBarView(children: [
                  // We can't have SingleChildScrollView otherwise the tabs would scroll too
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(soc.description),
                        if (soc.discordCode != null)
                          DiscordCard(
                            code: soc.discordCode,
                          ),
                        if (soc.instagramHandle != null)
                          InstagramCard(
                            code: soc.instagramHandle,
                          ),
                        if (soc.whatsapp != null)
                          WhatsappCard(code: soc.whatsapp),
                        if (soc.mail != null) EmailCard(code: soc.mail),
                        if (soc.website != null) WebsiteCard(code: soc.website)
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: getEventsBySocieity(soc).isEmpty
                          ? const Text("This society has no events yet :(")
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: getEventsBySocieity(soc).length,
                              itemBuilder: (context, index) {
                                final event = getEventsBySocieity(soc)[index];
                                return EventCard(event: event);
                              },
                            ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
