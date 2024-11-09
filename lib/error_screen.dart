import 'package:flutter/material.dart';
class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  ErrorScreen({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error Screen'),
      ),
      body: Center(
        child: Text('Error occurred during POST request: $errorMessage'),
      ),
    );
  }
}