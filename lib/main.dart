import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UDP Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String broadbastIp =
      '192.168.0.255'; // Replace with your server's IP address
  static const int broadcastPort = 12345; // Replace with your server's port

  String _responseMessage = '';

  Future<void> _sendMessage() async {
    final String message = 'Hello from Flutter';
    try {
      // Create a UDP socket
      RawDatagramSocket udpSocket =
          await RawDatagramSocket.bind(InternetAddress.anyIPv4, 12345);
      // Send message to server
      udpSocket.send(
          utf8.encode(message), InternetAddress(broadbastIp), broadcastPort);
      // Listen for response
      udpSocket.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram? datagram = udpSocket.receive();
          if (datagram != null) {
            setState(() {
              _responseMessage = utf8.decode(datagram.data);
            });
          }
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UDP Client'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Response from Server:',
            ),
            Text(
              _responseMessage,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendMessage,
              child: const Text('Click Me'),
            ),
          ],
        ),
      ),
    );
  }
}
