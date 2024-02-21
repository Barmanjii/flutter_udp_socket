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

  @override
  void initState() {
    super.initState();
    // Trigger refresh data when the page is initially loaded
    _refreshData();
  }

  Timer? _loadingTimer; // Declare a Timer variable

  void _refreshData() {
    setState(() {
      returnData.clear(); // Clearing existing data
      isLoading = false; // Remove Extra loading
      selectedIndex = -1; // Resetting the index
    });

    // Cancel the existing Timer and run it again
    _loadingTimer?.cancel();
    // Start the Timer
    _startLoadingTimer();

    // Socket Broadcasting
    sendMessage();

    // Set up a periodic timer to run sendMessage every 1 second for a total of 5 seconds
    int count = 1;
    _loadingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      sendMessage();
      count++;
      if (count >= 5) {
        // After 5 seconds (5 calls), cancel the timer
        timer.cancel();
      }
    });
  }

  void _startLoadingTimer() {
    // Start the timer for 5 seconds
    _loadingTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _loadingTimer = null; // Remove the timer reference
      });
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
  void dispose() {
    // Dispose of the timer when the widget is disposed
    _loadingTimer?.cancel();
    super.dispose();
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
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // const SizedBox(width: 20),
                IconButton(
                  onPressed: _refreshData,
                  icon: const Icon(Icons.refresh_outlined),
                  tooltip: "Refresh",
                ),

                if (_loadingTimer != null)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SocketResponseListView(socketResponses: returnData),
            ),
          ],
        ),
      ),
    );
  }
}
