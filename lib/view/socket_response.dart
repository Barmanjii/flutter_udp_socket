import 'package:flutter/material.dart';
import 'package:flutter_udp_socket/api/base_url.dart';
import 'package:flutter_udp_socket/model/socket_reponse.dart';
import 'package:flutter_udp_socket/view/file_sharing.dart';

class SocketResponseListView extends StatefulWidget {
  final List<SocketResponse> socketResponses;

  const SocketResponseListView({Key? key, required this.socketResponses})
      : super(key: key);

  @override
  SocketResponseListViewState createState() => SocketResponseListViewState();
}

class SocketResponseListViewState extends State<SocketResponseListView> {
  int selectedIndex = -1; // Initially no item is selected

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.socketResponses.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title:
                Text('Machine ID: ${widget.socketResponses[index].machineId}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('WiFi IP: ${widget.socketResponses[index].wifiIp}'),
                Text(
                    'Ethernet IP: ${widget.socketResponses[index].ethernetIp}'),
              ],
            ),
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              SelectedBaseURL().baseURL = widget.socketResponses[index];
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FileShare(
                        machineId: widget.socketResponses[index].machineId)),
              );
            },
            tileColor: selectedIndex == index
                ? Colors.blueAccent.withOpacity(0.5)
                : null,
          ),
        );
      },
    );
  }
}
