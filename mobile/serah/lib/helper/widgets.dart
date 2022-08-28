import 'package:flutter/material.dart';

class Widgets {
  Widget buildCenterCirular() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CircularProgressIndicator()],
    ));
  }
}
