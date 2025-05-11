import 'package:flutter/material.dart';
import 'package:socdrawer/src/app.dart';

import 'src/controllers/settings_controller.dart';
import 'src/views/settings/settings_service.dart';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a   theme change when the app is first displayed.
  await settingsController.loadSettings();
  //await windowManager.ensureInitialized();

  //windowManager.setSize(const Size(412 , 915));
  //windowManager.setMinimumSize(const Size(375, 667));

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(SocDrawer(settingsController: settingsController));
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class Basic extends StatefulWidget {
  const Basic({super.key});

  @override
  BasicState createState() => BasicState();
}

class BasicState extends State<Basic> {
  final _chatController = InMemoryChatController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        chatController: _chatController,
        currentUserId: 'user1',
        onMessageSend: (text) {
          _chatController.insertMessage(
            TextMessage(
              // Better to use UUID or similar for the ID - IDs must be unique
              id: '${Random().nextInt(1000) + 1}',
              authorId: 'user1',
              createdAt: DateTime.now().toUtc(),
              text: text,
            ),
          );
        },
        resolveUser: (UserID id) async {
          return User(id: id, name: 'Farid');
        },
      ),
    );
  }
}
