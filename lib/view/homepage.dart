import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_udp_socket/constants.dart';
import 'package:flutter_udp_socket/model/socket_reponse.dart';
import 'package:flutter_udp_socket/view/socket_response.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
// Replace with your server's port

  List<SocketResponse> returnData = [];
  Map<String, dynamic> _respObj = {};
  bool isLoading = false;

  void _refreshData() {
    setState(() {
      returnData.clear();
      isLoading = false;
    });
    sendMessage();
  }

  void _clearData() {
    setState(() {
      returnData.clear();
      isLoading = false; // Reset loading state
    });
  }

  Future<void> sendMessage() async {
    setState(() {
      isLoading = true; // Set loading state to true
    });

    try {
      // Create a UDP socket
      RawDatagramSocket udpSocket =
          await RawDatagramSocket.bind(InternetAddress.anyIPv4, 1234);

      udpSocket.broadcastEnabled = true;

      // Send message to server
      udpSocket.send(
          utf8.encode(message), InternetAddress(broadbastIp), broadcastPort);
      // Listen for response
      udpSocket.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram? datagram = udpSocket.receive();
          if (datagram != null) {
            setState(() {
              final data = utf8.decode(datagram.data);
              _respObj = jsonDecode(data);
              final socketResp = SocketResponse(
                  machineId: _respObj['machineId'],
                  wifiIp: _respObj['wifiIp'],
                  ethernetIp: _respObj['ethernetIp']);
              if (!returnData.contains(socketResp)) {
                returnData.add(socketResp);
              }
              setState(() {
                isLoading = false;
              });
            });
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      isLoading = false; // Set loading state to false if there's an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UDP Client',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: isLoading
                      ? null
                      : sendMessage, // Disable button when loading
                  icon: const Icon(Icons.play_circle_outline),
                  tooltip: "Find Robots",
                ),
                // const SizedBox(width: 20),
                IconButton(
                  onPressed: isLoading ? null : _refreshData,
                  icon: const Icon(Icons.refresh_outlined),
                  tooltip: "Refresh",
                ),
                IconButton(
                  onPressed: isLoading ? null : _clearData,
                  icon: const Icon(Icons.clear),
                  tooltip: "Clear",
                ),
              ],
            ),
            const SizedBox(height: 20),
            isLoading
                ? const LinearProgressIndicator() // Show progress indicator if loading
                : Expanded(
                    child: SocketResponseListView(socketResponses: returnData),
                  ),
          ],
        ),
      ),
    );
  }
}
