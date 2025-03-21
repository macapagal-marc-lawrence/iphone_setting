
//commit by mac
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bluetooth_settings_page.dart';

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

//commit by mac
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
  }

//commit by kevin
  void _toggleWifi(bool value) async {
    setState(() {
      _wifi = value;
    });
  }
  void _showMembersDialog(BuildContext context) {
    final List<String> members = ['John Eric Cruz', 'Kevin Dizon', 'Jenzelle Luriz', 'Cris Juanatas', 'Marc Lawrence Macapagal', "Charles Venasquez"];

    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('List of Members'),
        actions: members.map((member) {
          return CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text(member),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          isDefaultAction: true,
          child: const Text('Close'),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Settings'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.settings),
          onPressed: () => _showMembersDialog(context),
        ),
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

//commit by charles
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.bluetooth, color: Colors.blue),
                  title: const Text('Bluetooth'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_bluetoothLoading)
                        const CupertinoActivityIndicator()
                      else if (_connectedDevice != null)
                        Text(_connectedDevice!, style: TextStyle(color: CupertinoColors.systemGrey))
                      else
                        Text(_bluetooth ? 'Beats Pro' : 'Off', style: TextStyle(color: CupertinoColors.systemGrey)),
                      const SizedBox(width: 5),
                      const Icon(CupertinoIcons.chevron_forward),
                    ],
                  ),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => BluetoothSettingsPage()),
                    );
                    if (result != null && result is Map<String, dynamic>) {
                      _toggleBluetooth(result['isEnabled']);
                      setState(() {
                        _connectedDevice = result['connectedDevice'];
                      });
                    }
                  },
                ),

//commit by eric
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.antenna_radiowaves_left_right, color: Colors.green),
                  title: const Text('Cellular'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Off', style: TextStyle(color: CupertinoColors.systemGrey)),
                      const SizedBox(width: 5),
                      const Icon(CupertinoIcons.chevron_forward),
                    ],
                  ),
                ),

//commit by charles
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.personalhotspot, color: Colors.grey.shade500),
                  title: Text('Personal Hotspot', style: TextStyle(color: Colors.grey.shade500)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(_hotspot ? 'On' : 'Off', style: TextStyle(color: Colors.grey.shade500)),
                      const SizedBox(width: 5),
                      const Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey),
                    ],
                  ),
                ),

//commit by eric
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.battery_100, color: Colors.green),
                  title: const Text('Battery'),
                  trailing: const Icon(CupertinoIcons.chevron_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//commit by mac
class WifiSettingsPage extends StatefulWidget {
  final bool wifiState;
  final Function(bool) onWifiToggle;
  const WifiSettingsPage({super.key, required this.wifiState, required this.onWifiToggle});

  @override
  _WifiSettingsPageState createState() => _WifiSettingsPageState();
}

//commit by kevin

class _WifiSettingsPageState extends State<WifiSettingsPage> {
  bool _wifiEnabled = true;
  bool _loading = false;
  List<String> _wifiNetworks = ['Other...', 'Network_1', 'Network_2', 'Guest_Wifi'];
  String _connectedNetwork = 'HCC_ICS_Lab';

  @override
  void initState() {
    super.initState();
    _wifiEnabled = widget.wifiState;
  }

//commit by cris
  void _toggleWifi(bool value) {
    setState(() {
      _loading = true;
    });
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        _wifiEnabled = value;
        _loading = false;
      });
      widget.onWifiToggle(value);
    });
  }

//commit by cris
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Wi-Fi'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Text('Settings', style: TextStyle(color: CupertinoColors.activeBlue)),
        ),
        trailing: const Text('Edit', style: TextStyle(color: CupertinoColors.activeBlue)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(CupertinoIcons.wifi, size: 50, color: Colors.blue),
                  const SizedBox(height: 10),
                  const Text('Wi-Fi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text(
                    'Connect to Wi-Fi, view available networks, and manage settings for joining networks and nearby hotspots.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: CupertinoColors.systemGrey),
                  ),
                ],
              ),
            ),

//commit by jenzelle
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  title: const Text('Wi-Fi'),
                  trailing: _loading
                      ? const CupertinoActivityIndicator()
                      : CupertinoSwitch(
                    value: _wifiEnabled,
                    onChanged: _toggleWifi,
                  ),
                ),
                if (_wifiEnabled)

//commit by jenzelle
                  CupertinoListTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('✓', style: TextStyle(fontSize: 20, color: CupertinoColors.activeBlue)),
                        const SizedBox(width: 5),
                        Text(_connectedNetwork),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(CupertinoIcons.lock_fill, size: 16, color: CupertinoColors.systemGrey),
                        const SizedBox(width: 2),
                        const Icon(CupertinoIcons.wifi, size: 16, color: CupertinoColors.systemGrey),
                        const SizedBox(width: 5),
                        const Icon(CupertinoIcons.info_circle, color: CupertinoColors.activeBlue),
                      ],
                    ),
                  ),
              ],
            ),
            if (_wifiEnabled) ...[
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 10, bottom: 5),
                child: Text(
                  'OTHER NETWORKS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ),

//commit by mac
              CupertinoListSection.insetGrouped(
                children: _wifiNetworks.map((network) {
                  return CupertinoListTile(
                    title: Text(network, style: const TextStyle(fontSize: 16)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(CupertinoIcons.wifi, color: CupertinoColors.activeBlue),
                        SizedBox(width: 5),
                        Icon(CupertinoIcons.info_circle, color: CupertinoColors.activeBlue),
                      ],
                    ),
                    onTap: () {},
                  );
                }).toList(),
              ),
            ],
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text('AirDrop, AirPlay, Notify When Left Behind, and improved location accuracy require Wi-Fi.',
                textAlign: TextAlign.center,
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

