//commit by marc
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BluetoothSettingsPage extends StatefulWidget {
  const BluetoothSettingsPage({super.key});

  @override
  _BluetoothSettingsPageState createState() => _BluetoothSettingsPageState();
}

class _BluetoothSettingsPageState extends State<BluetoothSettingsPage> {
  bool _bluetoothEnabled = true;
  bool _bluetoothLoading = false;
  List<String> _myDevices = ['Beats Pro', 'K12', 'JBL WAVE BUDS', 'Bluetooth', 'Apple AirPods Pr'];
  List<String> _otherDevices = ['AirPods Pro'];
  String _connectedDevice = 'Beats Pro';

  void _toggleBluetooth(bool value) async {
    setState(() {
      _bluetoothLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 5));
    setState(() {
      _bluetoothEnabled = value;
      _bluetoothLoading = false;
    });
  }
  //commit by kevin
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Bluetooth'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context, {
              'isEnabled': _bluetoothEnabled,
              'connectedDevice': _bluetoothEnabled ? _connectedDevice : null,
            });
          },
          child: const Text('Settings', style: TextStyle(color: CupertinoColors.activeBlue)),
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const Icon(CupertinoIcons.bluetooth, size: 50, color: Colors.blue),
                  const SizedBox(height: 10),
                  const Text('Bluetooth', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text(
                    'Connect to accessories you can use for activities such as streaming music, making phone calls, and gaming.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: CupertinoColors.systemGrey),
                  ),
                  const Text(
                    'Learn More',
                    style: TextStyle(color: CupertinoColors.link),
                  ),
                ],
              ),
            ),

