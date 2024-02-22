import 'package:flutter/material.dart';
import 'package:flutter_udp_socket/api/ping.dart';
import 'package:flutter_udp_socket/api/selected_machine_details.dart';
import 'package:flutter_udp_socket/model/socket_reponse.dart';

class FileShare extends StatefulWidget {
  final SocketResponse? machineDetails;

  const FileShare({
    Key? key,
    required this.machineDetails,
  }) : super(key: key);

  @override
  FileShareState createState() => FileShareState();
}

class FileShareState extends State<FileShare> {
  String? baseURL;

  @override
  void initState() {
    super.initState();
    // Call the existing checkConnection function when the widget is loaded
    PingConnection().checkConnection(
        widget.machineDetails?.wifiIp, widget.machineDetails?.ethernetIp);

    // Listen to changes in SelectedBaseMachineDetails and update the state
    SelectedBaseMachineDetails().addListener(_updateBaseURL);
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    SelectedBaseMachineDetails().removeListener(_updateBaseURL);
    super.dispose();
  }

  void _updateBaseURL() {
    setState(() {
      baseURL = SelectedBaseMachineDetails().baseURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connected with $baseURL'),
      ),
      body: Center(
        child: Text(
          'Hi ${widget.machineDetails}',
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
