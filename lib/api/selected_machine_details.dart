import 'package:flutter/material.dart';
import 'package:flutter_udp_socket/model/socket_reponse.dart';

class SelectedBaseMachineDetails with ChangeNotifier {
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
  SocketResponse? _baseMachineDetails;
  String? _baseURL;

  // Getter for baseMachineDetails
  SocketResponse? get baseMachineDetails => _baseMachineDetails;

  // Getter for baseURL
  String? get baseURL => _baseURL;

  // Setter for baseMachineDetails
  set baseMachineDetails(SocketResponse? value) {
    _baseMachineDetails = value;
    notifyListeners(); // Notify listeners of the change
  }

  // Setter for baseURL
  set baseURL(String? value) {
    _baseURL = value;
    notifyListeners(); // Notify listeners of the change
  }
}
