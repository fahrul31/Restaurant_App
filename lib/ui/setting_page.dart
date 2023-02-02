import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/prefences_provider.dart';
import '../provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, child) {
            return ListView(
              children: [
                Material(
                  child: ListTile(
                    title: const Text('Dark Theme'),
                    trailing: Switch.adaptive(
                      value: provider.isDarkTheme,
                      onChanged: (value) {
                        provider.enableDarkTheme(value);
                      },
                    ),
                  ),
                ),
                Material(
                  child: ListTile(
                    title: const Text('Scheduling News'),
                    trailing: Consumer<SchedulingProvider>(
                      builder: (context, scheduled, _) {
                        return Switch.adaptive(
                          value: provider.isDailyRestaurantActive,
                          onChanged: (value) async {
                            scheduled.scheduledNews(value);
                            provider.enableDailyNews(value);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
