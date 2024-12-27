import 'package:flutter/material.dart';

class DeviceDetailsTile extends StatelessWidget {
  DeviceDetailsTile({super.key, required this.name, required this.details});
  String name;
  String details;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(details),
    );
  }
}
