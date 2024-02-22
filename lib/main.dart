import 'package:flutter/material.dart';
import 'package:flutter_udp_socket/api/selected_machine_details.dart';
import 'package:flutter_udp_socket/app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedBaseMachineDetails()),
      ],
      child: const MyApp(),
    ),
  );
}
