import 'package:flutter_udp_socket/model/socket_reponse.dart';

class SelectedBaseURL {
  // Singleton instance
  static final SelectedBaseURL _instance = SelectedBaseURL._internal();

  // Private constructor
  SelectedBaseURL._internal();

  // Factory constructor to return the singleton instance
  factory SelectedBaseURL() {
    return _instance;
  }

  // Selected item
  SocketResponse? baseURL;
}
