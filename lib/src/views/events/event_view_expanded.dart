import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/event.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class EventsViewExpanded extends StatelessWidget {
  final Event event;
  static const containerBackgroundColour = Color.fromARGB(255, 233, 233, 233);
  const EventsViewExpanded({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- SOCIETY ---
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: containerBackgroundColour,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.group),
                  const SizedBox(width: 10),
                  Expanded(child: Text(event.society.name)),
                ],
              ),
            ),

            // --- DATE TIME ---
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: containerBackgroundColour,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${event.dateTime.toLocal().day}/${event.dateTime.toLocal().month}/${event.dateTime.toLocal().year} at ${event.dateTime.toLocal().hour.toString().padLeft(2, '0')}:${event.dateTime.toLocal().minute.toString().padLeft(2, '0')}',
                    ),
                  ),
                ],
              ),
            ),

            // --- LOCATION ---
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: containerBackgroundColour,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(width: 10),
                  Expanded(child: Text(event.location)),
                ],
              ),
            ),

            GestureDetector(
              onTap: () async {
                final googleMapsUrl =
                    'https://www.google.com/maps/search/?api=1&query=${event.location}';

                if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
                  await launchUrl(Uri.parse(googleMapsUrl),
                      mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not open Google Maps')),
                  );
                }
              },
              child: const Text(
                'Open in Google Maps',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            // --- DESCRIPTION ---
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: containerBackgroundColour,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //const Icon(Icons.description),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        event.description != null
                            ? Text(
                                event.description!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            : const Text(
                                '(No more details)',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
