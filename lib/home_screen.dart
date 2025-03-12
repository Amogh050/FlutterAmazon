import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
      ),
      body: SafeArea(
        child: Center(
          child: Text("Home Screen", style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}
