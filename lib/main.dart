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

//commit by kevin
void _toggleBluetooth(bool value) async {
    setState(() {
      _bluetoothLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _bluetooth = value;
      _bluetoothLoading = false;
    });

void _toggleWifi(bool value) async {
    setState(() {
      _wifi = value;
    });
  }

  @override
    Widget build(BuildContext context) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Settings'),
        ),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              CupertinoListSection.insetGrouped(
                children: <Widget>[
                  CupertinoListTile(
                    leading: const Icon(CupertinoIcons.airplane, color: Colors.orange),
                    title: const Text('Airplane Mode'),
                    trailing: CupertinoSwitch(
                      value: _airplaneMode,
                      onChanged: _toggleAirplaneMode,
                    ),
                  ),
                  CupertinoListTile(
                    leading: const Icon(CupertinoIcons.wifi, color: Colors.blue),
                    title: const Text('Wi-Fi'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(_wifi ? 'HCC_ICS_Lab' : 'Off', style: TextStyle(color: CupertinoColors.systemGrey)),
                        const SizedBox(width: 5),
                        const Icon(CupertinoIcons.chevron_forward),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => WifiSettingsPage(
                                wifiState: _wifi, onWifiToggle: _toggleWifi)),
                      );
                    },
                  ),

