import 'package:flutter_udp_socket/model/socket_reponse.dart';

class SelectedBaseMachineDetails {
  // Singleton instance
  static final SelectedBaseMachineDetails _instance =
      SelectedBaseMachineDetails._internal();

  // Private constructor
  SelectedBaseMachineDetails._internal();

  // Factory constructor to return the singleton instance
  factory SelectedBaseMachineDetails() {
    return _instance;
  }

  // Selected Machine Details
  SocketResponse? baseMachineDetails;
  SocketResponse? baseURL;
}
