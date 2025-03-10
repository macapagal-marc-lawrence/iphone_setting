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
//commit by charles
            CupertinoListSection.insetGrouped(
              children: <Widget>[
                CupertinoListTile(
                  title: const Text('Bluetooth'),
                  trailing: _bluetoothLoading
                      ? const CupertinoActivityIndicator()
                      : CupertinoSwitch(
                    value: _bluetoothEnabled,
                    onChanged: _toggleBluetooth,
                  ),
                ),
                if (_bluetoothEnabled)
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 5, bottom: 5),
                    child: Text(
                      'This iPhone is discoverable as "iPhone" while Bluetooth Settings is open.',
                      style: TextStyle(color: CupertinoColors.secondaryLabel, fontSize: 12),
                    ),
                  ),
              ],
            ),
    //commit by eric
            if (_bluetoothEnabled)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 10, bottom: 5),
                child: Text(
                  'MY DEVICES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ),


