import 'package:donezoid/providers/settings_provider.dart';
import 'package:donezoid/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSectionTitle(context, 'Appearance'),
          ListTile(
            title: const Text('Theme'),
            trailing: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.wb_sunny), label: Text('Light')),
                ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.brightness_auto), label: Text('System')),
                ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.nightlight_round), label: Text('Dark')),
              ],
              selected: {settingsProvider.themeMode},
              onSelectionChanged: (newSelection) {
                settingsProvider.updateThemeMode(newSelection.first);
              },
            ),
          ),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<Locale>(
              value: settingsProvider.locale,
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('es'), child: Text('Español')),
              ],
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  settingsProvider.updateLocale(newLocale);
                }
              },
            ),
          ),
          const Divider(),
          _buildSectionTitle(context, 'Data Management'),
          ListTile(
            title: const Text('Export Data'),
            leading: const Icon(Icons.upload_file),
            onTap: () {
              // TODO: Implement export
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export functionality not implemented yet.')),
              );
            },
          ),
          ListTile(
            title: const Text('Import Data'),
            leading: const Icon(Icons.download),
            onTap: () {
              // TODO: Implement import
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Import functionality not implemented yet.')),
              );
            },
          ),
          ListTile(
            title: const Text('Clear All Data'),
            leading: Icon(Icons.delete_forever, color: Colors.red.shade700),
            onTap: () => _showClearDataDialog(context, taskProvider),
          ),
          const Divider(),
           _buildSectionTitle(context, 'About'),
          ListTile(
            title: const Text('About Donezoid'),
            leading: const Icon(Icons.info_outline),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Donezoid',
                applicationVersion: '1.0.0', // TODO: Get from pubspec
                applicationIcon: const FlutterLogo(), // TODO: Add app icon
                children: [
                  const Text('A modern, advanced To-Do Task Manager app.'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Padding _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  void _showClearDataDialog(BuildContext context, TaskProvider taskProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Data?'),
          content: const Text('This action cannot be undone. All your tasks will be permanently deleted.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Clear', style: TextStyle(color: Colors.red.shade700)),
              onPressed: () {
                taskProvider.clearAllTasks();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All tasks have been cleared.')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
