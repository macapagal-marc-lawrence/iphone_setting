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
