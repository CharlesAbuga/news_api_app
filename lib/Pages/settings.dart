import 'package:flutter/material.dart';
import 'package:news_app_ui/provider/theme_provider.dart';
import 'package:news_app_ui/themes.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late bool light0;

  @override
  void initState() {
    super.initState();
    // Initialize light0 based on the current theme

    final theme = Provider.of<ThemeChange>(context, listen: false);
    setState(() {
      light0 = theme.getTheme() == lightTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          Consumer<ThemeChange>(builder: (context, theme, child) {
            return ListTile(
              title: Text(light0 ? 'Light Mode' : 'Dark Mode'),
              trailing: Switch(
                  thumbColor: WidgetStatePropertyAll(
                      light0 ? Colors.white : Colors.black),
                  activeColor: Colors.black,
                  activeTrackColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                  value: light0,
                  onChanged: (value) {
                    setState(() {
                      light0 = value;
                      theme.setTheme(light0 ? lightTheme : darkTheme);
                    });
                  }),
            );
          }),
          ListTile(
            title: Text('Notifications'),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
