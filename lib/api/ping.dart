import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_udp_socket/api/selected_machine_details.dart';

class PingConnection {
  void checkConnection(String? wifi, String? ethernet) async {
    if (wifi != null && ethernet != null) {
      await checkWifiConnection(wifi);
      await checkEthernetConnection(ethernet);
    } else if (wifi != null) {
      await checkWifiConnection(wifi);
    } else if (ethernet != null) {
      await checkEthernetConnection(ethernet);
    } else {
      if (kDebugMode) {
        print("Neither WiFi nor Ethernet provided");
      }
    }
  }

// The count is basically the number of times you listend to the ping output

// The event.summary is the whole summary of ping lifecycle which happened.
  Future<void> checkWifiConnection(String wifi) async {
    final ping = Ping(wifi, count: 5);
    ping.stream.listen((event) {
      if (event.error == null && event.summary == null) {
        if (kDebugMode) {
          print("WiFi working fine");
        }
        SelectedBaseMachineDetails().baseURL = wifi;
      }
    });
  }

  Future<void> checkEthernetConnection(String ethernet) async {
    final ping = Ping(ethernet, count: 5);
    ping.stream.listen((event) {
      if (event.error == null && event.summary == null) {
        if (kDebugMode) {
          print("Ethernet working fine");
        }
        SelectedBaseMachineDetails().baseURL = ethernet;
      }
    });
  }
}
