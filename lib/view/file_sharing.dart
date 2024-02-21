// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FileShare extends StatelessWidget {
  final String? machineId;
  const FileShare({
    Key? key,
    required this.machineId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Sharing'),
      ),
      body: Center(
        child: Text(
          'Hi $machineId',
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
