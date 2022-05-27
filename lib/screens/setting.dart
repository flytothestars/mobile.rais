import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: SettingsList(
      sections: [
        SettingsSection(
          title: Text('Общий'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.language),
              title: Text('Язык'),
              value: Text('English'),
              onPressed: (value){
                DropdownButton(
                  value: value,
                  items: dropdownItems, 
                  onChanged: (Object? value) {  },
                );
              },
            ),
            SettingsTile.switchTile(
              onToggle: (value) {},
              initialValue: true,
              leading: Icon(Icons.format_paint),
              title: Text('Тема приложение системный'),
            ),
          ],
        ),
        SettingsSection(
          title: Text('Уведомление'),
          tiles: <SettingsTile>[
            SettingsTile.switchTile(

              onToggle: (value) {},
              initialValue: true,
              leading: Icon(Icons.notifications),
              title: Text('О пауербанках при аренде'),
            ),
            SettingsTile.switchTile(

              onToggle: (value) {},
              initialValue: true,
              leading: Icon(Icons.format_paint),
              title: Text('Об акциях и предложениях'),
            ),
          ],
        ),
      ],
    ),
    );
  }
}
List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("USA"),value: "USA"),
    DropdownMenuItem(child: Text("Canada"),value: "Canada"),
    DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
    DropdownMenuItem(child: Text("England"),value: "England"),
  ];
  return menuItems;
}

void _dropButtons(context, value) {
  DropdownButton(
    value: value,
      items: dropdownItems, onChanged: (Object? value) {  },
    );
  }