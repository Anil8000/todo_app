import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  NoDataWidget({super.key, required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
