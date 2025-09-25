import 'package:flutter/material.dart';

class SalesCommisionBreakdownScreen extends StatefulWidget {
  const SalesCommisionBreakdownScreen({super.key});

  @override
  State<SalesCommisionBreakdownScreen> createState() =>
      _SalesCommisionBreakdownScreenState();
}

class _SalesCommisionBreakdownScreenState
    extends State<SalesCommisionBreakdownScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Sales Commision Breakdown Screen')),
    );
  }
}
