import 'package:firebase_provider/widget/WidgetText.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetText("text"),
      ),
    );
  }
}
