import 'package:flutter/material.dart';
import 'package:flutter_udp_socket/api/ping.dart';
import 'package:flutter_udp_socket/app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PingConnection()),
      ],
      child: const MyApp(),
    ),
  );
}
