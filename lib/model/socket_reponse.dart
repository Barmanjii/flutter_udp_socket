import 'dart:convert';

class SocketResponse {
  String? machineId;
  String? wifiIp;
  String? ethernetIp;
  SocketResponse({
    this.machineId,
    this.wifiIp,
    this.ethernetIp,
  });

  SocketResponse copyWith({
    String? machineId,
    String? wifiIp,
    String? ethernetIp,
  }) {
    return SocketResponse(
      machineId: machineId ?? this.machineId,
      wifiIp: wifiIp ?? this.wifiIp,
      ethernetIp: ethernetIp ?? this.ethernetIp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'machineId': machineId,
      'wifiIp': wifiIp,
      'ethernetIp': ethernetIp,
    };
  }

  factory SocketResponse.fromMap(Map<String, dynamic> map) {
    return SocketResponse(
      machineId: map['machineId'] != null ? map['machineId'] as String : null,
      wifiIp: map['wifiIp'] != null ? map['wifiIp'] as String : null,
      ethernetIp:
          map['ethernetIp'] != null ? map['ethernetIp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocketResponse.fromJson(String source) =>
      SocketResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SocketResponse(machineId: $machineId, wifiIp: $wifiIp, ethernetIp: $ethernetIp)';

  @override
  bool operator ==(covariant SocketResponse other) {
    if (identical(this, other)) return true;

    return other.machineId == machineId &&
        other.wifiIp == wifiIp &&
        other.ethernetIp == ethernetIp;
  }

  @override
  int get hashCode =>
      machineId.hashCode ^ wifiIp.hashCode ^ ethernetIp.hashCode;
}
