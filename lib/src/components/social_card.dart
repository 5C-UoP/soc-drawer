import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String code;
  final Color bg;
  final String url;
  final bool isMail;

  const SocialCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.code,
      required this.url,
      required this.bg,
      this.isMail = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: InkWell(
        onTap: () async {
          if (!isMail) {
            await launchUrl(Uri.parse(url));
          } else {
            await launchUrl(
              Uri(
                scheme: 'mailto',
                path: code,
                queryParameters: {
                  'subject': 'Test',
                },
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      code,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiscordCard extends SocialCard {
  DiscordCard({
    super.key,
    required super.code,
  }) : super(
          icon: const Icon(Icons.discord, size: 40, color: Colors.blue),
          title: "Discord",
          url: "https://discord.com/invite/${code}",
          bg: Colors.blue.shade100,
        );
}

class InstagramCard extends SocialCard {
  const InstagramCard({
    super.key,
    required super.code,
  }) : super(
          icon: const Icon(
            FontAwesomeIcons.instagram,
            size: 40,
            color: Colors.white,
          ),
          title: "Instagram",
          url: "https://instagram.com/${code}",
          bg: const Color(0xFFC13584),
        );
}

class WhatsappCard extends SocialCard {
  const WhatsappCard({
    super.key,
    required super.code,
  }) : super(
          icon: const Icon(
            FontAwesomeIcons.whatsapp,
            size: 40,
            color: Colors.white,
          ),
          title: "Whtasapp",
          url: "https://chat.whatsapp.com/${code}",
          bg: const Color(0xFF25D366),
        );
}

class EmailCard extends SocialCard {
  EmailCard({
    super.key,
    required super.code,
  }) : super(
            icon: const Icon(
              Icons.email,
              size: 40,
              color: Colors.white,
            ),
            title: "Email",
            url: "mailto:${code}",
            bg: Colors.orange.shade300,
            isMail: true);
}

// I expect very few if not no societies to have a website. BUT the it society does have one :)
class WebsiteCard extends SocialCard {
  WebsiteCard({
    super.key,
    required super.code,
  }) : super(
            icon: const Icon(
              FontAwesomeIcons.globe,
              size: 40,
              color: Colors.black,
            ),
            title: "Website",
            url: code,
            bg: Colors.white);
}
