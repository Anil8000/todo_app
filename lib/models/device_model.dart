class DeviceModel {
  final String id;
  final String name;
  final String? data;

  DeviceModel({required this.id, required this.name, this.data});

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(id: json['id'], name: json['name'], data: json['data']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'data': data};
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(id: map['id'], name: map['name'], data: map['data']);
  }
}
