import 'package:flutter/material.dart';

class CounterAppScreen extends StatefulWidget {
  const CounterAppScreen({Key? key}) : super(key: key);

  @override
  State<CounterAppScreen> createState() => _CounterAppScreenState();
}

class _CounterAppScreenState extends State<CounterAppScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
