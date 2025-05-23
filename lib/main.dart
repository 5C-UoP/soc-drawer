import 'package:flutter/material.dart';
import 'package:socdrawer/src/app.dart';

import 'src/controllers/settings_controller.dart';
import 'src/views/settings/settings_service.dart';

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
