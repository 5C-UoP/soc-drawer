import 'package:flutter/material.dart';
import 'package:socdrawer/src/settings/settings_view.dart';
import 'package:socdrawer/src/socieites/socieity_details_view.dart';
import 'package:socdrawer/src/socieites/socieity_list_view.dart';

import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  //await windowManager.ensureInitialized();

  //windowManager.setSize(const Size(412 , 915));
  //windowManager.setMinimumSize(const Size(375, 667));

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MaterialApp(
    restorationScopeId: 'app',
    home: SocietyItemListView(),
    onGenerateRoute: (RouteSettings routeSettings) {
      return MaterialPageRoute<void>(
        builder: (BuildContext context) {
          switch (routeSettings.name) {
            case SettingsView.routeName:
              return SettingsView(controller: settingsController);
            case SocietyItemDetailsView.routeName:
              final args = routeSettings.arguments
                  as Map<String, dynamic>?; // Extract the arguments
              return SocietyItemDetailsView(args: args);
            case SocietyItemListView.routeName:
            default:
              return SocietyItemListView();
          }
        },
      );
    },
  ));
}
