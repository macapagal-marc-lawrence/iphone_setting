//commit by mac
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: SettingsPage(),
    theme: CupertinoThemeData(
      brightness: Brightness.light,
    ),
  ));
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}
//
class _SettingsPageState extends State<SettingsPage> {
  bool _airplaneMode = false;
  bool _wifi = true;
  bool _bluetooth = true;
  bool _hotspot = false;
  bool _bluetoothLoading = false;
  String? _connectedDevice;
  bool _wifiBeforeAirplaneMode = true; // Store wifi state before airplane mode.

  void _toggleAirplaneMode(bool value) {
    setState(() {
      _airplaneMode = value;
      if (_airplaneMode) {
        _wifiBeforeAirplaneMode = _wifi; // Store wifi state.
        _wifi = false;
        _bluetooth = false;
        _hotspot = false;
      } else {
        _wifi = _wifiBeforeAirplaneMode; // Restore wifi state.
        _bluetooth = true; // Restore bluetooth state.
      }
    });
  }


}

