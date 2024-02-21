import 'package:flutter/material.dart';
import 'package:flutter_udp_socket/model/socket_reponse.dart';

class SocketResponseListView extends StatelessWidget {
  final List<SocketResponse> socketResponses;

  const SocketResponseListView({Key? key, required this.socketResponses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: socketResponses.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Machine ID: ${socketResponses[index].machineId}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('WiFi IP: ${socketResponses[index].wifiIp}'),
                Text('Ethernet IP: ${socketResponses[index].ethernetIp}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
