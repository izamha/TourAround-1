import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tour_around/constants/colors.dart';

class BodySettings extends StatefulWidget {
  const BodySettings({
    Key? key,
  }) : super(key: key);

  @override
  State<BodySettings> createState() => _BodySettingsState();
}

class _BodySettingsState extends State<BodySettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: SettingsList(
            sections: [
              SettingsSection(
                title: const Text('Common'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: const Icon(Icons.language),
                    title: const Text('Language'),
                    value: const Text('English'),
                  ),
                  SettingsTile.switchTile(
                    onToggle: (value) {},
                    initialValue: false,
                    leading: const Icon(Icons.format_paint),
                    title: const Text('Enable custom theme'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
